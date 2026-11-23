#!/usr/bin/env bash
# Build and publish Homebrew bottles for this tap without GitHub Actions.
#
#   scripts/bottle.sh                   interactive menu (needs gum)
#   scripts/bottle.sh status [formula]  bottles per formula, all if none given
#   scripts/bottle.sh build <formula>   on each machine that should get a bottle
#   scripts/bottle.sh merge <formula>   once, on any machine, after the builds
#   scripts/bottle.sh check <formula>   after merge + push + brew update
#
# build: builds the formula from source with --build-bottle on this machine
# (Homebrew picks the platform tag), then uploads the bottle and its JSON to
# the GitHub Release <formula>-<version> of this tap, creating it if needed.
# Re-running replaces this platform's files.
#
# merge: downloads every bottle JSON from that release and writes the
# `bottle do` block into Formula/<formula>.rb of this checkout. It does not
# commit. Platforms without a bottle keep building from source.
#
# check: reinstalls the formula on this machine and passes only if brew
# poured this platform's bottle (no source build) and `brew test` passes.
#
# status: the version brew sees, the platforms in the formula's bottle block,
# the platforms uploaded to its release, and what this machine would install.
#
# Before build: push the formula and run `brew update`; brew builds from its
# own tap checkout, and this script stops if that differs from this one.
#
# Needs: brew, jq, and gh logged in (`gh auth login`) with write access to
# the tap; release assets go through the GitHub API, which git can't reach.
# The menu also needs gum (`brew install gum`).
set -euo pipefail

REPO="lthiagol/homebrew-tap"
TAP="lthiagol/tap"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SELF="${ROOT}/scripts/bottle.sh"
export HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_AUTO_UPDATE=1

# build and merge each run in their own process (the menu calls this script
# again), so one scratch directory per process is enough.
work=""
trap 'rm -rf "${work}"' EXIT

die() {
  echo "bottle.sh: $*" >&2
  exit 1
}

# The header comment is the help text.
usage() { sed -n '2,/^set -euo/{/^set -euo/d;s/^# \{0,1\}//;p;}' "${BASH_SOURCE[0]}"; }

formulas() {
  local f
  for f in "${ROOT}"/Formula/*.rb
  do
    basename "${f}" .rb
  done
}

release_tag() { echo "$1-$2"; }
release_url() { echo "https://github.com/${REPO}/releases/download/$(release_tag "$1" "$2")"; }

# brew builds and merges against its own tap checkout, not this one. If the
# two disagree, the bottle would be built from (or written into) a formula
# that isn't the one being shipped.
strip_bottle() {
  awk '/^  bottle do$/ { skip = 1; next }
       skip && /^  end$/ { skip = 2; next }
       skip == 2 && /^$/ { skip = 0; next }
       skip != 1 { skip = 0; print }' "$1"
}
tap_file() { echo "$(brew --repo "${TAP}")/Formula/$1.rb"; }
in_sync() {
  local tap local_file="${ROOT}/Formula/$1.rb"
  tap=$(tap_file "$1")
  [[ -f "${tap}" ]] || return 1
  diff -q <(strip_bottle "${tap}") <(strip_bottle "${local_file}") >/dev/null
}
require_sync() {
  in_sync "$1" || die "brew's tap checkout differs from this one for $1; push and run 'brew update' first
  brew's: $(tap_file "$1")
  this:   ${ROOT}/Formula/$1.rb"
}

version_of() { brew info --json=v2 "${TAP}/$1" | jq -r '.formulae[0].versions.stable'; }

cmd_build() {
  local name=$1 full="${TAP}/$1" version json local_name upload_name platform tag
  require_sync "${name}"
  version=$(version_of "${name}")
  tag=$(release_tag "${name}" "${version}")

  # Create the release first: a token that can't write to the tap fails here,
  # not after a long build.
  gh release view "${tag}" -R "${REPO}" >/dev/null 2>&1 ||
    gh release create "${tag}" -R "${REPO}" --title "${name} ${version}" \
      --notes "Bottles for ${name} ${version}."

  # brew reinstall has no --build-bottle. A keg of this version already built
  # with it (an earlier run whose upload failed) is bottled as is.
  local installed
  installed=$(brew info --json=v2 "${full}" |
    jq -r '.formulae[0].installed[0] // {} | "\(.version) \(.built_as_bottle)"')
  if [[ "${installed}" == "${version} true" ]]
  then
    echo "${name} ${version} is already built for bottling; skipping the build"
  else
    if brew list --formula "${full}" >/dev/null 2>&1
    then
      brew uninstall "${full}"
    fi
    brew install --build-bottle "${full}"
  fi

  work=$(mktemp -d)
  (
    cd "${work}"
    brew bottle --json --root-url="$(release_url "${name}" "${version}")" "${full}"
  )

  json=$(echo "${work}"/*.bottle.json)
  # brew writes the bottle as name--version.tag.bottle.tar.gz but downloads
  # name-version.tag.bottle.tar.gz; the JSON carries both names.
  local_name=$(jq -r '.[].bottle.tags[].local_filename' "${json}")
  upload_name=$(jq -r '.[].bottle.tags[].filename' "${json}")
  platform=$(jq -r '.[].bottle.tags | keys[0]' "${json}")
  mv "${work}/${local_name}" "${work}/${upload_name}"
  mv "${json}" "${work}/${tag}.${platform}.bottle.json"

  gh release upload "${tag}" -R "${REPO}" --clobber \
    "${work}/${upload_name}" "${work}/${tag}.${platform}.bottle.json"

  echo "uploaded the ${platform} bottle to release ${tag}"
  echo "next: '${SELF} merge ${name}' once every platform is built"
}

cmd_merge() {
  local name=$1 version tap platforms
  require_sync "${name}"
  version=$(version_of "${name}")
  tap=$(tap_file "${name}")

  work=$(mktemp -d)
  gh release download "$(release_tag "${name}" "${version}")" -R "${REPO}" \
    -p '*.bottle.json' -D "${work}" ||
    die "no bottle JSONs on release $(release_tag "${name}" "${version}"); run '${SELF} build ${name}' first"

  # brew bottle --merge rewrites brew's tap checkout; carry the result into
  # this checkout and put brew's back the way it was.
  cp "${tap}" "${work}/tap.rb.orig"
  brew bottle --merge --write --no-commit "${work}"/*.bottle.json
  cp "${tap}" "${ROOT}/Formula/${name}.rb"
  cp "${work}/tap.rb.orig" "${tap}"

  platforms=$(jq -rs '[.[][].bottle.tags | keys[]] | join(" ")' "${work}"/*.bottle.json)
  echo "wrote the bottle block for ${name}: ${platforms}"
  echo "review and commit: git -C '${ROOT}' diff Formula/${name}.rb"
}

# One tab-separated row per formula; the header row first.
status_rows() {
  local here names=("$@") info name version root formula_tags release_tags local_col notes
  here=$(brew ruby -e 'puts Utils::Bottles.tag')
  [[ ${#names[@]} -gt 0 ]] || mapfile -t names < <(formulas)
  info=$(brew info --json=v2 "${names[@]/#/${TAP}/}")

  printf 'Formula\tVersion\tIn formula\tOn release\t%s\tNotes\n' "${here}"
  for name in "${names[@]}"
  do
    version=$(jq -r --arg n "${name}" '.formulae[] | select(.name == $n) | .versions.stable' <<<"${info}")
    root=$(jq -r --arg n "${name}" '.formulae[] | select(.name == $n) | .bottle.stable.root_url // ""' <<<"${info}")
    formula_tags=$(jq -r --arg n "${name}" '.formulae[] | select(.name == $n) | .bottle.stable.files // {} | keys | join(" ")' <<<"${info}")
    release_tags=$(gh release view "$(release_tag "${name}" "${version}")" -R "${REPO}" \
      --json assets -q '.assets[].name' 2>/dev/null |
      sed -n 's/.*\.\([a-z0-9_]*\)\.bottle\.json$/\1/p' | sort | tr '\n' ' ' | sed 's/ $//') || true

    notes=()
    in_sync "${name}" || notes+=("tap checkout differs: push + brew update")
    if [[ -n "${formula_tags}" && "${root}" != "$(release_url "${name}" "${version}")" ]]
    then
      notes+=("stale bottle block: delete it")
    fi
    local t unmerged=()
    for t in ${release_tags}
    do
      [[ " ${formula_tags} " == *" ${t} "* ]] || unmerged+=("${t}")
    done
    [[ ${#unmerged[@]} -eq 0 ]] || notes+=("not merged: ${unmerged[*]}")

    if [[ " ${formula_tags} " == *" ${here} "* ]]
    then
      local_col="bottle"
    else
      local_col="source build"
    fi

    printf '%s\t%s\t%s\t%s\t%s\t%s\n' "${name}" "${version}" "${formula_tags:--}" \
      "${release_tags:--}" "${local_col}" "$(
        IFS=';'
        echo "${notes[*]:-}"
      )"
  done
}

cmd_check() {
  local name=$1 full="${TAP}/$1" here poured
  here=$(brew ruby -e 'puts Utils::Bottles.tag')
  # Without a bottle brew would quietly fall back to a long source build.
  brew info --json=v2 "${full}" | jq -e --arg t "${here}" '.formulae[0].bottle.stable.files[$t]' >/dev/null ||
    die "brew's ${name} has no ${here} bottle; merge, commit, push and 'brew update' first"

  brew reinstall "${full}"
  poured=$(brew info --json=v2 "${full}" | jq -r '.formulae[0].installed[0].poured_from_bottle')
  [[ "${poured}" == "true" ]] || die "${name} was built from source, not poured from the ${here} bottle"
  brew test "${full}" || die "${name} was poured from the ${here} bottle but 'brew test' failed"
  echo "ok: ${name} poured from the ${here} bottle and 'brew test' passed"
}

cmd_status() {
  if command -v gum >/dev/null
  then
    gum spin --title "Checking formulas and releases…" --show-output -- "${SELF}" _rows "$@" |
      gum table --print --separator=$'\t'
  else
    status_rows "$@" | column -t -s $'\t'
  fi
}

# gum's multi-select returns nothing when enter is pressed without space, so
# say so instead of silently going back to the menu.
pick() {
  local picked
  picked=$(formulas | gum choose --no-limit --header "$1 which? (space selects, enter confirms)") || return 1
  [[ -n "${picked}" ]] || {
    gum log --level warn "nothing selected: press space on a formula, then enter"
    return 1
  }
  echo "${picked}"
}

menu() {
  command -v gum >/dev/null || die "the menu needs gum ('brew install gum'); or see --help"
  local here action picked name failed
  here=$(brew ruby -e 'puts Utils::Bottles.tag')

  while true
  do
    clear
    cmd_status
    action=$(gum choose --header "What now?" \
      "Build bottles on this machine (${here})" \
      "Merge release bottles into formulas" \
      "Check install from bottle on this machine" \
      "Refresh status" \
      "Quit") || return 0

    failed=()
    case ${action} in
      Build*)
        picked=$(pick Build) || {
          pause
          continue
        }
        gum confirm "Build from source and upload ${here} bottles for: $(echo "${picked}" | tr '\n' ' ')?" || continue
        for name in ${picked}
        do
          gum log --level info "building ${name}"
          "${SELF}" build "${name}" || failed+=("${name}")
        done
        ;;
      Merge*)
        picked=$(pick Merge) || {
          pause
          continue
        }
        for name in ${picked}
        do
          "${SELF}" merge "${name}" || failed+=("${name}")
        done
        git -C "${ROOT}" --no-pager diff --stat -- Formula/
        gum log --level info "review with 'git -C ${ROOT} diff', then commit and push"
        ;;
      Check*)
        picked=$(pick Check) || {
          pause
          continue
        }
        for name in ${picked}
        do
          "${SELF}" check "${name}" || failed+=("${name}")
        done
        ;;
      Refresh*) continue ;;
      *) return 0 ;;
    esac
    [[ ${#failed[@]} -eq 0 ]] || gum log --level error "failed: ${failed[*]}"
    pause
  done
}

# The next round clears the screen; keep the output readable until then.
pause() { read -rsp $'\npress enter to go back to the menu\n' _; }

case ${1-} in
  -h | --help | help)
    usage
    exit 0
    ;;
  *) ;;
esac
for tool in brew gh jq
do
  command -v "${tool}" >/dev/null || die "${tool} not found"
done
gh auth status >/dev/null 2>&1 || die "gh is not logged in; run 'gh auth login'"

cmd=${1-}
case ${cmd} in
  "") menu ;;
  status) cmd_status "${@:2}" ;;
  _rows) status_rows "${@:2}" ;;
  build | merge | check)
    [[ $# -eq 2 ]] || die "usage: ${SELF} ${cmd} <formula> (see --help)"
    [[ -f "${ROOT}/Formula/$2.rb" ]] || die "no formula '$2' in ${ROOT}/Formula"
    "cmd_${cmd}" "$2"
    ;;
  *) die "unknown command '${cmd}' (see --help)" ;;
esac

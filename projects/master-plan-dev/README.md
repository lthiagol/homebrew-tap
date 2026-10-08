# master-plan-dev

Rolling development build of [master-plan](https://github.com/lthiagol/master-plan), tracking the `wip` branch.

- **Tap formula:** `lthiagol/tap/master-plan-dev`
- **Tracks:** `wip` branch (automatically bumped on every push to `wip`)
- **Installs:** `mp` (agent CLI) + `raul` (human TUI) — the same binary names
  as the stable `master-plan` formula

## ⚠️ Stability

This is a rolling build from the `wip` branch. It may have:

- Unfinished features
- Known regressions
- Breaking changes without notice

**Use `master-plan` (stable) for production.** Use `master-plan-dev` to test new features, reproduce bugs, or pre-validate changes before they ship.

## One version at a time

This formula and `lthiagol/tap/master-plan` both install binaries named `mp`
and `raul`, so they declare:

```ruby
conflicts_with "master-plan", because: "both install mp and raul"
```

Homebrew enforces that at install time — installing this formula while the
stable one is present (or the other way round) is refused rather than
silently clobbering `mp` and `raul` on your `PATH`.

To switch between them, uninstall first, then install the other:

```bash
brew uninstall lthiagol/tap/master-plan-dev
brew install  lthiagol/tap/master-plan
```

If you work in more than one checkout and want both available, use the
[From source](../master-plan/) instructions with a separate `CARGO_TARGET_DIR`
per branch instead of installing both formulas.

## Install

```bash
brew install lthiagol/tap/master-plan-dev
brew upgrade lthiagol/tap/master-plan-dev
```

Verify the install:

```bash
mp --help
raul --help
```

The version is the **workspace** version from the tapped commit (e.g.
`1.0.0-rc5`), not the formula's own `1.0.0-rc5-dev.20261008-<shortsha>`
string — those intentionally differ. The formula version encodes the `wip`
commit it was built from; the binary reports the code's own version.

## Update procedure (tap maintainer)

**You do not need to do this by hand.** `.github/workflows/dev-tap-update.yml`
in the master-plan repo bumps this formula on every push to `wip`, computes the
commit archive's sha256, opens a PR against the tap's `main`, and enables
auto-merge. The tap's own `stable-ci` job (`ruby -c`, `brew style`, plus a
per-formula sha256-vs-url check) is the gate.

For a manual bump to a specific `wip` commit:

1. From the `master-plan` repo, pick the `wip` commit you want to ship (usually the tip):

   ```bash
   git checkout wip
   git pull
   SHA=$(git rev-parse HEAD)
   ```

2. Download the tarball for that SHA and compute its SHA256:

   ```bash
   curl -sL -o /tmp/master-plan-wip.tar.gz \
     "https://github.com/lthiagol/master-plan/archive/${SHA}.tar.gz"
   shasum -a 256 /tmp/master-plan-wip.tar.gz
   ```

3. Edit `Formula/master-plan-dev.rb` in this tap:
   - Replace `url` with the new `${SHA}.tar.gz` URL.
   - Replace `sha256` with **that tarball's** hash.
   - Bump `version` to `<workspace-version>-dev.<date>-${SHA:0:8}`.

   The `sha256` must belong to the archive named in the formula's own `url`.
   The tag bump workflow writes two formulas pointing at two different
   archives (the tag archive for `master-plan`, the commit archive for this
   one), so the two hashes are never interchangeable.

4. Commit and push:

   ```bash
   git add Formula/master-plan-dev.rb
   git commit -m "master-plan-dev: bump to ${SHA:0:8}"
   git push
   ```

## Why a separate formula?

- `master-plan` (stable) is bumped on tag push, tracking released versions.
- `master-plan-dev` tracks `wip` — unreleased commits.
- Keeping them on separate, manually-maintained formulae means stable users are
  never surprised by untested code landing in their tap, and `wip` users
  explicitly opt in to the bleeding edge.

## See also

- [`master-plan`](../master-plan/) — the stable formula.
- [Main repo](https://github.com/lthiagol/master-plan) — source, issues, design docs.
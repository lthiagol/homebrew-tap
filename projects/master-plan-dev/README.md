# master-plan-dev

Rolling development build of [master-plan](https://codeberg.org/lthiagol/master-plan), tracking the `wip` branch.

- **Tap formula:** `lthiagol/tap/master-plan-dev`
- **Tracks:** `wip` branch (manual updates)
- **Coexists with:** `lthiagol/tap/master-plan` (stable) — installs to `mp-dev` + `raul-dev`, both can run side-by-side.

## ⚠️ Stability

This is a rolling build from the `wip` branch. It may have:

- Unfinished features
- Known regressions
- Breaking changes without notice

**Use `master-plan` (stable) for production.** Use `master-plan-dev` to test new features, reproduce bugs, or pre-validate changes before they ship.

## Install

```bash
brew install lthiagol/tap/master-plan-dev
brew upgrade lthiagol/tap/master-plan-dev
```

Verify the install:

```bash
mp-dev --help
raul-dev --help
```

You should see a version like `1.0.0-dev.<date>`, e.g. `1.0.0-dev.20260719`.

## Update procedure (tap maintainer)

This formula is **manually bumped**. To roll forward to a newer `wip` commit:

1. From the `master-plan` repo, pick the `wip` commit you want to ship (usually the tip):

   ```bash
   cd /Users/thiago/Code/Pessoal/master-plan
   git checkout wip
   git pull
   SHA=$(git rev-parse HEAD)
   ```

2. Download the tarball for that SHA and compute its SHA256:

   ```bash
   curl -sL -o /tmp/master-plan-wip.tar.gz \
     "https://codeberg.org/lthiagol/master-plan/archive/${SHA}.tar.gz"
   shasum -a 256 /tmp/master-plan-wip.tar.gz
   ```

3. Edit `Formula/master-plan-dev.rb` in this tap:
   - Replace `url` with the new `${SHA}.tar.gz` URL.
   - Replace `sha256` with the new hash.
   - Bump `version` to the next dev date (or use `${SHA:0:7}` for a short-sha suffix).

4. Commit and push:

   ```bash
   git add Formula/master-plan-dev.rb
   git commit -m "master-plan-dev: bump to ${SHA:0:7}"
   git push
   ```

5. The `brew test-bot` workflow will validate the formula on the PR / push.

## Why a separate formula?

`master-plan` (stable) is auto-bumped on tag push via `mislav/bump-homebrew-formula-action` (planned). Keeping `master-plan-dev` on a separate, manually-maintained formula means:

- Stable users are never surprised by untested code landing in their tap.
- `wip` users explicitly opt-in to the bleeding edge.
- Both binaries can be installed and compared side-by-side (`mp` vs `mp-dev`, `raul` vs `raul-dev`).

## See also

- [`master-plan`](../master-plan/) — the stable formula.
- [Main repo](https://codeberg.org/lthiagol/master-plan) — source, issues, design docs.
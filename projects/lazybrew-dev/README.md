# lazybrew-dev

Rolling development build of [lazybrew](https://github.com/lthiagol/lazybrew), tracking the `wip` branch.

- **Tap formula:** `lthiagol/tap/lazybrew-dev`
- **Tracks:** `wip` branch (manual updates)
- **Coexists with:** `lthiagol/tap/lazybrew` (stable) — installs to a different binary, both can run side-by-side.

## ⚠️ Stability

This is a rolling build from the `wip` branch. It may have:

- Unfinished features
- Known regressions
- Breaking changes without notice

**Use `lazybrew` (stable) for production.** Use `lazybrew-dev` to test new features, reproduce bugs, or pre-validate changes before they ship.

## Install

```bash
brew install lthiagol/tap/lazybrew-dev
brew upgrade lthiagol/tap/lazybrew-dev
```

Verify the install:

```bash
lazybrew-dev --version
```

You should see a version like `0.2.0-dev.<date>`, e.g. `0.2.0-dev.20260722`.

## Update procedure (tap maintainer)

This formula is **manually bumped**. To roll forward to a newer `wip` commit:

1. From the `lazybrew` repo, pick the `wip` commit you want to ship (usually the tip):

   ```bash
   cd /Users/thiago/Code/Pessoal/lazybrew
   git checkout wip
   git pull
   SHA=$(git rev-parse HEAD)
   ```

2. Download the tarball for that SHA and compute its SHA256:

   ```bash
   curl -sL -o /tmp/lazybrew-wip.tar.gz \
     "https://github.com/lthiagol/lazybrew/archive/${SHA}.tar.gz"
   shasum -a 256 /tmp/lazybrew-wip.tar.gz
   ```

3. Edit `Formula/lazybrew-dev.rb` in this tap:
   - Replace `url` with the new `${SHA}.tar.gz` URL.
   - Replace `sha256` with the new hash.
   - Bump `version` to the next dev date (or use `${SHA:0:7}` for a short-sha suffix).

4. Commit and push:

   ```bash
   git add Formula/lazybrew-dev.rb
   git commit -m "lazybrew-dev: bump to ${SHA:0:7}"
   git push
   ```

5. Validate locally with `brew install --build-from-source Formula/lazybrew-dev.rb` and `brew test lazybrew-dev`.

## Why a separate formula?

`lazybrew` (stable) is bumped manually on each release tag. Keeping `lazybrew-dev` on a separate, manually-maintained formula means:

- Stable users are never surprised by untested code landing in their tap.
- `wip` users explicitly opt-in to the bleeding edge.
- Both binaries can be installed and compared side-by-side.

## See also

- [`lazybrew`](../lazybrew/) — the stable formula.
- [Main repo](https://github.com/lthiagol/lazybrew) — source, issues, design docs.

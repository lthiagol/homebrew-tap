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

You should see the tag it was built from, e.g. `lazybrew 1.1.0-rc1`.

## Update procedure (tap maintainer)

This formula is **manually bumped**, to a tag cut from `wip`. To roll forward:

1. In the `lazybrew` repo, tag the `wip` commit you want to ship and push the tag:

   ```bash
   cd ~/coding/lazybrew
   git checkout wip && git pull
   git tag -a vX.Y.Z-rcN -m "lazybrew vX.Y.Z-rcN"
   git push origin vX.Y.Z-rcN
   ```

2. Download the tag's tarball and compute its SHA256:

   ```bash
   curl -sL -o /tmp/lazybrew-wip.tar.gz \
     "https://github.com/lthiagol/lazybrew/archive/refs/tags/vX.Y.Z-rcN.tar.gz"
   shasum -a 256 /tmp/lazybrew-wip.tar.gz
   ```

3. Edit `Formula/lazybrew-dev.rb` in this tap: replace the `url` tag and the
   `sha256`. There is no `version` line: Homebrew reads it from the tag, and the
   formula passes it to the binary with `-X main.version=#{version}`, so
   `lazybrew-dev --version` prints it.

4. Commit and push:

   ```bash
   git add Formula/lazybrew-dev.rb
   git commit -m "lazybrew-dev: bump to vX.Y.Z-rcN"
   git push
   ```

5. Validate with `brew style Formula/lazybrew-dev.rb`, then
   `brew upgrade lthiagol/tap/lazybrew-dev` (or install it) and
   `lazybrew-dev --version`.

## Why a separate formula?

`lazybrew` (stable) is bumped manually on each release tag. Keeping `lazybrew-dev` on a separate, manually-maintained formula means:

- Stable users are never surprised by untested code landing in their tap.
- `wip` users explicitly opt-in to the bleeding edge.
- Both binaries can be installed and compared side-by-side.

## See also

- [`lazybrew`](../lazybrew/) — the stable formula.
- [Main repo](https://github.com/lthiagol/lazybrew) — source, issues, design docs.

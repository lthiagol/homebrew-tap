# frond

Read-only-first Obsidian-style terminal UI for markdown vaults — tree
sidebar, wikilink navigation, tags, backlinks, global search, git sync
status, and `.base` table views.

- Homepage: https://github.com/lthiagol/Frond
- Tap formula: `lthiagol/tap/frond`

## Usage

```bash
brew tap lthiagol/tap
brew trust lthiagol/tap        # Homebrew 7+ requires trusting third-party taps
brew install lthiagol/tap/frond
brew upgrade lthiagol/tap/frond
```

First install compiles locally (the formula builds from the tagged source
archive with cargo — no prebuilt binaries), so expect a couple of minutes
while Homebrew pulls the Rust toolchain and builds the dependency tree.

## Quick start

```bash
frond                          # prompts for the vault directory
frond --vault ~/ai-notes       # open a vault (index.md first)
frond --config-show            # print a commented default config
```

See the [main repo](https://github.com/lthiagol/Frond) for full documentation,
keybindings and the configuration reference.

# lthiagol/tap

Homebrew tap for [lthiagol](https://github.com/lthiagol)'s public projects.

## Install

This tap is hosted on GitHub — the standard shorthand works. On Homebrew 7+,
third-party taps must also be trusted before their formulae load:

```bash
brew tap lthiagol/tap
brew trust lthiagol/tap
```

## Available formulae

| Formula | Description | Language | Repo |
|---------|-------------|----------|------|
| `andre` | TUI wrapper for GNU Stow — manage dotfiles interactively | Rust | [lthiagol/andre](https://github.com/lthiagol/andre) |
| `frond` | Read-only-first Obsidian-style terminal UI for markdown vaults | Rust | [lthiagol/Frond](https://github.com/lthiagol/Frond) |
| `lazybrew` | TUI for lazy management of Homebrew | Go | [lthiagol/lazybrew](https://github.com/lthiagol/lazybrew) |
| `lazybrew-dev` | Rolling development build of lazybrew (tracks `wip` branch) | Go | [lthiagol/lazybrew](https://github.com/lthiagol/lazybrew) |

## Installing a formula

```bash
brew install lthiagol/tap/<formula>
```

On Homebrew 7+ the tap must be trusted once first (see Install above):
`brew trust lthiagol/tap`.

For example:

```bash
brew install lthiagol/tap/andre
```

## Updating

```bash
brew update && brew upgrade lthiagol/tap/<formula>
```

## Project docs

See the `projects/` directory for per-project notes and documentation.

## License

Each formula is licensed under the same license as its source project.

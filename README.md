# lthiagol/tap

Homebrew tap for [lthiagol](https://github.com/lthiagol)'s public projects.

## Install

This tap is hosted on Codeberg, so add it with the full URL (the `lthiagol/tap` shorthand defaults to GitHub):

```bash
brew tap lthiagol/tap
```

## Available formulae

| Formula | Description | Language | Repo |
|---------|-------------|----------|------|
| `andre` | TUI wrapper for GNU Stow — manage dotfiles interactively | Rust | [lthiagol/andre](https://github.com/lthiagol/andre) |
| `lazybrew` | TUI for lazy management of Homebrew | Go | [lthiagol/lazybrew](https://github.com/lthiagol/lazybrew) |
| `lazybrew-dev` | Rolling development build of lazybrew (tracks `wip` branch) | Go | [lthiagol/lazybrew](https://github.com/lthiagol/lazybrew) |
| `master-plan` | Spec-driven project planning CLI for agents (mp + raul) | Rust | [lthiagol/master-plan](https://github.com/lthiagol/master-plan) |
| `master-plan-dev` | Rolling development build of master-plan (`mp-dev` + `raul-dev`, tracks `wip`) | Rust | [lthiagol/master-plan](https://github.com/lthiagol/master-plan) |
| `obsidian-terminal` | Read-only TUI for browsing Obsidian vaults | Go | [lthiagol/obsidian-terminal](https://github.com/lthiagol/obsidian-terminal) |

## Installing a formula

```bash
brew install lthiagol/tap/<formula>
```

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

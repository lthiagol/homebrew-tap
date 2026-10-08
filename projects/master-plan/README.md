# master-plan

Spec-driven project planning CLI — structured for agents, readable for humans.

- Homepage: https://github.com/lthiagol/master-plan
- Tap formula: `lthiagol/tap/master-plan`
- Installs: `mp` (agent CLI) + `raul` (human TUI)
- Mutually exclusive with `lthiagol/tap/master-plan-dev` — both install `mp`
  and `raul`, so Homebrew refuses to have both installed. Uninstall one before
  installing the other (see the
  [dev project doc](../master-plan-dev/#one-version-at-a-time)).

## Usage

```bash
brew install lthiagol/tap/master-plan
brew upgrade lthiagol/tap/master-plan
```

Verify:

```bash
mp --help
raul --help
```

## Branch model

- `stable` (default) — tagged releases land here.
- `wip` — day-to-day commits; tracked by the rolling `master-plan-dev`
  formula ([see project doc](../master-plan-dev/)).

See the [main repo](https://github.com/lthiagol/master-plan) for full
documentation, the agent integration guide, and the planning methodology.
# master-plan

Spec-driven project planning CLI — structured for agents, readable for humans.

- Homepage: https://codeberg.org/lthiagol/master-plan
- Tap formula: `lthiagol/tap/master-plan`
- Installs: `mp` (agent CLI) + `raul` (human TUI)

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

See the [main repo](https://codeberg.org/lthiagol/master-plan) for full
documentation, the agent integration guide, and the planning methodology.
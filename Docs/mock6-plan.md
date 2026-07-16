# Mock 6 Plan

## Goal

Turn the structures and technical findings from the preceding mocks into the
tested baseline for Kizuna's main development.

Mock 6 integrates Kizuna with Dokoni Foundation in an Xcode workspace and
reviews the code produced by Mock 1 through Mock 5 for sensible reuse and
ownership.

## Core Scope

- Create an Xcode workspace containing Kizuna and Dokoni Foundation.
- Add Dokoni Foundation as a local development dependency of Kizuna.
- Keep both repositories independently buildable and testable.
- Inventory the models, provider access, storage, filtering, environment, and
  synchronization-related code created by the earlier mocks.
- Reuse existing code when it already has a suitable responsibility and API.
- Refactor or relocate code only when doing so produces a clear ownership
  boundary.
- Move shared provider-level capabilities to Dokoni Foundation only when they
  satisfy Foundation's multi-consumer rule.
- Keep Kizuna-specific product and synchronization workflows in Kizuna.
- Verify the combined structure through builds, automated tests, and the CLI.
- Document the accepted module boundaries and development workflow.

## Non-goals

- No broad rewrite of working mock code.
- No transfer of Kizuna-specific workflows into Dokoni Foundation.
- No UI implementation merely to exercise the workspace.
- No unrelated feature expansion beyond what is required to validate the
  production structure.

## Code Review Categories

Each existing component should be assigned deliberately to one of these
categories:

1. Keep in Kizuna unchanged.
2. Refactor within Kizuna.
3. Reuse through a Dokoni Foundation contract.
4. Move into Dokoni Foundation because at least two concrete consumers require
   the capability.
5. Retire because a tested replacement makes it redundant.

Code must not be moved solely because it is UI-independent. A Foundation module
also requires a stable shared contract and at least two concrete Dokoni
ecosystem consumers.

## Validation Criteria

Mock 6 is accepted when:

- the Xcode workspace opens and builds successfully;
- Kizuna and Dokoni Foundation also build independently;
- all relevant automated tests pass;
- the Kizuna CLI remains usable from the integrated structure;
- Kizuna consumes the intended Foundation capabilities without circular
  dependencies;
- application-specific workflows remain owned by Kizuna;
- shared module responsibilities and repository boundaries are documented;
- obsolete or duplicate mock code has been deliberately handled; and
- the resulting structure is suitable for continued main development without
  another structural restart.

## Transition to Main Development

Mock 6 is not a throwaway prototype. After its validation criteria are met, its
accepted code and workspace structure are promoted as the baseline for Kizuna's
main development.

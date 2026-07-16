# Kizuna Agent Instructions

Kizuna is part of the Dokoni Ecosystem.

## Project purpose

Kizuna explores integration between GitHub issues and personal productivity systems such as calendars and reminders.

The project is currently developed through small CLI mocks before the main development phase.

## Architecture

Reuse the existing structure unless explicitly requested otherwise.

During the mock phase, keep Kizuna usable as an independent Swift Package. For
the later main development phase, plan for an Xcode workspace that brings
Kizuna and Dokoni Foundation together without moving Kizuna-specific workflows
into Foundation.

Current structure:

- Sources/Apps/CLI/
- Sources/Libraries/KizunaCore/
- Tests/KizunaCoreTests/
- Docs/

Keep responsibilities separated:

- CLI commands belong in Sources/Apps/CLI/Commands/
- CLI output formatting belongs in Sources/Apps/CLI/Output/
- Core models belong in Sources/Libraries/KizunaCore/Models/
- Filtering belongs in Sources/Libraries/KizunaCore/Filtering/
- Storage belongs in Sources/Libraries/KizunaCore/Storage/
- Environment handling belongs in Sources/Libraries/KizunaCore/Environment/
- Future sync logic belongs in Sources/Libraries/KizunaCore/Sync/

## Development rules

- Prefer small, testable steps.
- Add or update tests together with implementation.
- Run swift test before committing.
- Document completed mocks in Docs/.
- Do not redesign the package layout during a mock unless explicitly requested.

## Current development phase

Mock 2 is complete.

Mock 3 should reuse the Mock 2 structure and test changing and writing GitHub issues.

Repository selection is part of Mock 3.

Keep GitHub API access isolated from CLI parsing.

Mock 3 combines the authenticated GitHub reading proven by Mock 1 with the
models, filtering, and output architecture proven by Mock 2. `load` refreshes
a regenerable cache from a selected repository; `list` shows all loaded issues
or filters them by `epic`, `item`, or `task`.

Mock 3 may explore GitHub access locally, but its findings should inform the
future shared GitHub capability in Dokoni Foundation. Creating the final
workspace or production Foundation integration is not part of Mock 3.

Mock 6 is reserved for the final Foundation and Xcode workspace integration.
It should review the code from the preceding mocks for deliberate reuse,
refactoring, relocation, or retirement. Its accepted result becomes the
baseline for main development.

## Local references

Repository documentation remains the public source of truth.

When a current AMTS Space is available, consult its Kizuna project for
complementary working knowledge. Installation-specific paths, private notes,
local conversations, and other resources that exist only on one machine belong
in the project's `localreferences.md` file inside that Space.

Do not record personal filesystem or iCloud paths in this repository.

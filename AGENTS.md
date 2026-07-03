# Kizuna Agent Instructions

Kizuna is part of the Dokoni Ecosystem.

## Project purpose

Kizuna explores integration between GitHub issues and personal productivity systems such as calendars and reminders.

The project is currently developed through small CLI mocks before the main development phase.

## Architecture

Reuse the existing structure unless explicitly requested otherwise.

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

## Local private notes

Some developers may keep private notes outside the repository, for example in iCloud Drive.

These notes are optional and intentionally not version controlled.

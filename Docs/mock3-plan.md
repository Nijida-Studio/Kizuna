# Mock 3 Plan

## Goal

Reuse the Mock 2 structure and test writing changes to GitHub issues.

Mock 3 should prove that Kizuna can select a repository and perform basic GitHub issue write operations.

## Core scope

- Combine Mock 1 GitHub reading with the Mock 2 architecture.
- Select a GitHub repository through `load`.
- Refresh a regenerable local cache from GitHub.
- List all loaded issues consistently.
- Filter the loaded list by `epic`, `item`, or `task`.
- Create a GitHub issue from CLI input.
- Prepare the structure for later issue updates.
- Keep the existing Mock 2 architecture.

## Non-goals

- No major restructuring.
- No final Xcode workspace or Dokoni Foundation integration yet.
- No calendar or reminder integration yet.
- No full sync logic yet.
- No complex conflict handling yet.

## Possible CLI shape

Load or refresh the selected repository:

```text
kizuna load Nijida-Studio/Kizuna-Issue-test-Repo
```

List all loaded data or one ODTS level:

```text
kizuna list
kizuna list epic
kizuna list item
kizuna list task
```

Create issue:

```text
kizuna issue create <issue-type> --title "..." --body "..." --subtype ...
```

Later update shape:

```text
kizuna issue update <number> --status ...
```

## Expected implementation areas

- Add a GitHub issue loader in KizunaCore.
- Preserve the Mock 2 JSON loader for isolated tests and compatibility.
- Store downloaded issues as a regenerable cache rather than manually managed
  mock data.
- Make the `list` issue-type argument optional.
- Replace the old primary type `requirement` with `item`; Requirement remains an
  Epic subtype.
- Add GitHub writing support after the read path is verified.
- Add CLI commands in `Sources/Apps/CLI/Commands/`.
- Reuse models from `Sources/Libraries/KizunaCore/Models/`.
- Add tests for repository selection and issue creation preparation.
- Keep GitHub API access isolated from CLI parsing.

## Test repository

Mock 3 uses `Nijida-Studio/Kizuna-Issue-test-Repo` for isolated GitHub write tests and mock data.

Credentials and tokens must remain outside the repository.

Private repository access uses the `GITHUB_TOKEN` environment variable.

The generated issue cache is stored under `~/Library/Caches/Kizuna/` and may be
deleted at any time. Running `load` recreates it from GitHub.

## Design preference

Mock 3 should build on Mock 2.

The existing separation between CLI, core models, filtering, storage, and environment handling should remain intact.

Mock 3 should record the GitHub access requirements it discovers. These
requirements will inform the shared provider-level GitHub capability planned
for Dokoni Foundation, while Kizuna-specific synchronization workflows remain
owned by Kizuna.

After the mock phase, main development should use an Xcode workspace that
brings Kizuna and Dokoni Foundation together. Until then, Kizuna remains an
independently buildable Swift Package.

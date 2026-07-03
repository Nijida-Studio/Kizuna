# Mock 3 Plan

## Goal

Reuse the Mock 2 structure and test writing changes to GitHub issues.

Mock 3 should prove that Kizuna can select a repository and perform basic GitHub issue write operations.

## Core scope

- Select or configure a GitHub repository.
- Create a GitHub issue from CLI input.
- Prepare the structure for later issue updates.
- Keep the existing Mock 2 architecture.

## Non-goals

- No major restructuring.
- No calendar or reminder integration yet.
- No full sync logic yet.
- No complex conflict handling yet.

## Possible CLI shape

Repository selection:

```text
kizuna repo set Nijida-Studio/Kizuna
kizuna repo current
cat > Docs/README.md <<'EOF'
# Documentation

This directory contains the public project documentation.

## Files

- PROJECT_MEMORY.md
- ROADMAP.md
- mock2.md
- mock3-plan.md

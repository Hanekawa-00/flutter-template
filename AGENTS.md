# Agent Development Guide

This guide is for AI coding agents and human developers working on this Flutter
template. It describes repository-specific expectations that apply regardless
of the assistant, editor, or automation tool being used.

## First Steps

- Check the current branch and working tree before editing.
- Treat uncommitted changes as user-owned unless you created them in the
  current task.
- Use a feature branch for non-trivial changes.
- Keep edits scoped to the requested behavior and nearby architecture.
- Prefer existing project patterns over new abstractions.

## Architecture

- Application startup lives in `lib/main*.dart` and `lib/src/app/`.
- Cross-cutting infrastructure belongs in `lib/src/core/`.
- Shared data access belongs in `lib/src/data/repositories/`.
- User-facing feature code belongs in `lib/src/features/<feature_name>/`.
- Reusable UI and UI services belong in `lib/src/shared/`.

Read `docs/architecture.md` before changing routing, state management, data
access, or app startup.

## Feature Work

Generate a feature shell when adding a new feature:

```bash
dart run scripts/new_feature.dart <feature_name>
```

Then register routes, add navigation only when the feature is top-level, and
write focused tests. See `docs/new_feature.md`.

## UI And UX

- Use `PageFrame` for normal screens and give it a stable `storageId`.
- Use `SectionCard` for grouped panels and settings sections.
- Keep mobile top bars fixed and hide bottom navigation on detail pages.
- Use `context.push(...)` for detail pages and return with `context.pop()`
  when possible.
- Verify narrow mobile layouts and desktop layouts when changing UI.
- Keep desktop window chrome, rounded corners, resize behavior, and sidebar
  collapse behavior intact.

Read `docs/design_system.md` before changing shared UI, navigation, page
layout, or responsive behavior.

## Data, Errors, And Platform Services

- Access remote data through repositories, not directly from pages.
- Use `BaseRepository.guard` / `RepositoryResult<T>` when feature UI should
  handle retryable failure states.
- Use `appErrorReporterProvider` for recoverable feature errors that should be
  logged with context.
- Use platform service providers in `lib/src/core/platform/` rather than
  calling platform APIs directly from screens.

## Validation

Run the smallest useful checks for the change. Before merging, run:

```bash
dart format lib test scripts
flutter analyze
flutter test
```

For release or environment-entry changes, also run the relevant build command
from `docs/release.md`.

## Git

- Commit coherent stages with clear messages.
- Do not include unrelated user changes in commits.
- Leave generated build artifacts out of commits unless the repository
  explicitly tracks them.

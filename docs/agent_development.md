# Agent Development

This document expands `AGENTS.md` for assistants and developers that need a
repeatable workflow inside this template.

## Workflow

1. Inspect branch and working tree.
2. Read the smallest relevant project docs:
   - `docs/architecture.md` for startup, routing, state, data, and errors.
   - `docs/design_system.md` for UI and responsive behavior.
   - `docs/new_feature.md` for new feature modules.
   - `docs/release.md` for environment entry points and builds.
3. Make scoped edits that follow the existing file layout.
4. Add or update tests when behavior changes.
5. Run format, analysis, tests, and any relevant build.
6. Commit only the files related to the task.

## Common Tasks

### Add A Feature

```bash
dart run scripts/new_feature.dart profile
```

After generation, register the route, add navigation if needed, and replace the
placeholder UI with the real experience.

### Add A Detail Page

Add the route as a child of the parent `GoRoute`. Navigate with
`context.push('/parent/detail')`. Back actions should use `context.pop()` when
possible so the parent page keeps its scroll and state.

### Change Shared UI

Check both mobile and desktop expectations:

- Mobile: fixed top app bar, bottom navigation only on top-level pages.
- Desktop: collapsible sidebar, pinned page headers, custom window frame.
- All: no text overflow, no layout shift from interactive states.

### Change Data Access

Keep pages thin. Put shared API, cache, and persistence logic in repositories.
Expose dependencies through Riverpod providers.

## Avoid

- Adding business placeholders to the template home screen.
- Calling Dio, Hive, clipboard, or system navigator directly from UI pages.
- Replacing project conventions with one-off patterns.
- Committing unrelated local files or user-owned changes.
- Using `context.go(...)` for detail pages when preserving parent state matters.

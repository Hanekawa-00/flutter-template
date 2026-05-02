---
name: flutter-template-agent-guide
description: Complete project-specific guide for developing the LanRhyme Flutter template. Use when adding or refactoring features, changing routing/navigation, improving desktop or mobile UX, updating theme/settings/data/cache/network layers, creating tests, building releases, merging branches, or reviewing implementation quality in this Flutter template repository.
---

# Flutter Template Agent Guide

## Purpose

Use this skill as the complete development playbook for this Flutter template.
It is project-specific and self-contained: do not require external project docs
before acting. Repository docs may be read for extra context, but the rules here
are enough to start work.

The template is a cross-platform Flutter app foundation inspired by polished
desktop/mobile app conventions. It favors Material 3, restrained dark/light
themes, custom desktop chrome, mobile ergonomics, state preservation, and
clear extension boundaries.

## Before Editing

1. Inspect branch and working tree.
2. Treat uncommitted changes as user-owned unless created during this task.
3. Use a feature branch for meaningful work, usually `codex/<short-task-name>`.
4. Keep edits scoped to the request and the nearby architecture.
5. Prefer existing helpers, tokens, providers, and widgets over new patterns.

Never revert unrelated local changes. If unrelated files are dirty, leave them
alone and stage only task-related files.

## Repository Shape

Expected project layout:

```text
lib/
  main.dart
  main_development.dart
  main_staging.dart
  main_production.dart
  src/
    app/              # app_runner.dart, bootstrap.dart
    core/             # config, errors, logging, routing, settings, theme,
                      # network, storage, cache, platform, windowing
    data/repositories # shared data access and RepositoryResult
    features/         # home, settings, about, components, future features
    shared/           # reusable widgets and UI services
scripts/
  check.ps1
  check.sh
  new_feature.dart
test/
```

Use `AGENTS.md` and `docs/` only as optional supporting references. This skill
is the primary instruction set when it is loaded.

## Feature Workflow

For a new feature, start with:

```bash
dart run scripts/new_feature.dart <feature_name>
```

Then:

1. Register the route in `lib/src/core/routing/app_router.dart`.
2. Add navigation in `AppShell` only if it is top-level.
3. Keep feature-local UI state in `features/<feature>/<feature>_providers.dart`.
4. Put shared API/cache/persistence in `lib/src/data/repositories/`.
5. Use `PageFrame(storageId: '<feature>')` for the page.
6. Add focused tests for routing, responsive layout, or provider behavior.

Do not put business-specific fake data on the template home page unless the
user explicitly asks for a demo.

## Routing And Navigation

The app uses `go_router` with `StatefulShellRoute.indexedStack` for top-level
branches. This is intentional: it preserves route stacks, widget state, and
scroll positions when switching pages.

Top-level branches:

- `/`
- `/settings`
- `/components`

Detail pages should be nested under their parent route:

```dart
GoRoute(
  path: '/settings',
  builder: (context, state) => const SettingsPage(),
  routes: [
    GoRoute(
      path: 'about',
      builder: (context, state) => const AboutPage(),
    ),
  ],
)
```

Use `context.push('/settings/about')` for detail pages. Use `context.pop()` for
back actions when possible, with a fallback to parent route only when no stack
entry exists. Avoid `context.go(...)` for detail navigation when parent page
state should be preserved.

Mobile navigation rules:

- Top-level pages show bottom navigation.
- Detail pages hide bottom navigation.
- Every page has a fixed top app bar.
- Detail pages show a back button.
- Top-level system back shows a double-back-to-exit prompt.
- Detail system back returns to the parent page, not the OS.

Desktop navigation rules:

- Desktop uses the custom shell sidebar, not bottom navigation.
- Sidebar must remain collapsible/expandable.
- Page headers should remain available while scrolling.
- State should persist after switching branches and returning.

## Page And UI Rules

Use project widgets:

- `PageFrame` for normal scrollable screens.
- `SectionCard` for grouped panels.
- `AppLoadingView`, `AppEmptyState`, `AppErrorView` for states.
- `AppAsyncValueBuilder` for Riverpod async UI.
- `ConfirmActionDialog` for destructive confirmation.
- `AppMessenger` for feedback snackbars.

Use theme tokens:

```dart
final spacing = Theme.of(context).spacing;
final radii = Theme.of(context).radii;
final motion = Theme.of(context).motion;
```

Responsive requirements:

- Below `760px`: mobile layout, fixed app bar, top-level bottom nav only.
- `760px` and above: desktop shell, sidebar, pinned page header.
- Controls must wrap or horizontally scroll before overflowing.
- Text must not overflow buttons, tiles, cards, or headers.
- Avoid nested page cards; use full-width page flow and section cards.
- Do not add decorative gradients/orbs unless they serve real product meaning.

Component gallery requirements:

- Show loading, empty, and error states.
- Show controls, async state, feedback, and dialogs.
- Keep previews adaptive on narrow screens.

## Desktop Window Rules

Windows/Linux use `window_manager` with custom chrome.

Preserve:

- Frameless custom title bar.
- Minimize, maximize/restore, and close buttons.
- Drag-to-move area.
- Drag-to-resize behavior.
- Rounded window corners when not maximized.
- Square corners when maximized.
- Transparent native background where required.

If hover artifacts, unclickable title buttons, or resize regressions appear,
inspect `desktop_window_frame_io.dart` and `desktop_window_io.dart` together.

## Theme And Settings

Theme settings live in `core/settings` and `core/theme`.

Preserve support for:

- System/light/dark mode.
- Theme color presets.
- OLED pure black dark mode.
- Compact density.
- Settings persistence via `SharedPreferencesAsync`.

When adding settings:

1. Add fields to `AppSettings`.
2. Update defaults and copyWith.
3. Persist in `SettingsRepository`.
4. Expose mutations through `AppSettingsController`.
5. Add UI under the appropriate settings section.
6. Update localization strings.

## Data, Network, Cache, And Errors

Network:

- Use `ApiClient` and `DioFactory`; do not call Dio directly from pages.
- Map Dio failures through `ApiException`.
- Repositories live under `lib/src/data/repositories/`.

Repository convention:

- Implement `Repository` or extend `BaseRepository`.
- Use throwing methods for low-level operations when appropriate.
- Use `RepositoryResult<T>` at UI-facing boundaries when retryable failure
  states are useful.

Cache/storage:

- Use `JsonCacheStore` for TTL JSON cache.
- Use `KeyValueStore` / `HiveKeyValueStore` for local key-value persistence.
- Use `localDatabaseProvider` and `cacheStoreProvider`; do not open Hive boxes
  directly in UI.

Errors/logging:

- Global error handling is installed by `runTemplateApp`.
- Use `AppLogger` for logs.
- Use `appErrorReporterProvider` for recoverable feature errors with context.
- Do not log secrets, tokens, passwords, or personal data.

Platform services:

- Use providers in `core/platform/platform_services.dart`.
- Avoid direct UI calls to `Clipboard`, `SystemNavigator`, or `SystemChrome`
  unless adding a new service wrapper.

## Localization

User-facing strings should go through gen-l10n.

- Edit `lib/l10n/app_en.arb` and `lib/l10n/app_zh.arb`.
- Run `flutter gen-l10n` when generated files need updating.
- Do not hard-code new persistent UI text in pages unless it is temporary
  developer-only placeholder text.

## Testing

Prefer focused tests:

- Routing and navigation behavior in widget tests.
- Responsive layout smoke tests for mobile and desktop.
- Repository result/error behavior in unit tests.
- Cache/network behavior in core tests.

Existing expectations to preserve:

- Mobile top-level pages keep bottom navigation.
- Mobile detail pages hide bottom navigation.
- Mobile top-level back asks before exiting.
- Desktop subpage actions stay available after scrolling.
- Page scroll state survives leaving and returning.

Use fixed-duration pumps instead of `pumpAndSettle()` when a page has a
continuous animation.

## Validation Commands

Run formatting:

```bash
dart format lib test scripts
```

Run quality checks:

```bash
flutter analyze
flutter test
```

Run a full local check:

```powershell
pwsh ./scripts/check.ps1
```

```bash
bash ./scripts/check.sh
```

Build commands:

```bash
flutter build web --release -t lib/main_production.dart
flutter build windows --release -t lib/main_production.dart
flutter build apk --release --split-per-abi -t lib/main_production.dart
```

Use relevant builds when the user asks to review a platform or when the change
touches platform-specific code.

## Git Workflow

Use small, meaningful stages:

1. Create/switch to a feature branch.
2. Implement and validate.
3. Stage only related files.
4. Commit with an imperative message:
   - `feat: add <capability>`
   - `fix: preserve <behavior>`
   - `docs: update <topic>`
   - `test: cover <behavior>`
5. Merge to `main` only when requested or clearly part of the task.

Do not include unrelated local changes such as user-owned `.gitignore` edits or
untracked lockfiles unless the user asks.

## Review Checklist

Before finalizing:

- Branch and commit state are clear.
- Unrelated user changes were not staged.
- Formatting passed or was intentionally skipped with reason.
- `flutter analyze` passed.
- `flutter test` passed.
- Relevant platform build passed if requested.
- UI changes were considered on mobile and desktop.
- Routing changes preserve parent state and correct back behavior.
- New feature code follows `core` / `data` / `features` / `shared` boundaries.

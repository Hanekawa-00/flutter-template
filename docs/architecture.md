# Architecture

This template is organized around stable boundaries so new business code can
grow without leaking infrastructure details into screens.

## Layers

```text
lib/
  main*.dart                 # entry points for environment variants
  src/
    app/                     # app runner and MaterialApp bootstrap
    core/                    # cross-cutting infrastructure
    data/                    # repositories and shared data access
    features/                # user-facing feature screens and feature state
    shared/                  # reusable widgets and UI services
```

## Navigation

Top-level destinations use `StatefulShellRoute.indexedStack`, so each branch
keeps its route stack, widget state, and scroll position. Put detail pages under
their parent route and navigate to them with `context.push(...)`; return with
`context.pop()` when possible.

Use `PageFrame(storageId: ...)` for screens with scrollable content. The storage
ID keeps scroll positions stable across theme changes and branch switches.

## State

Use Riverpod providers as dependency boundaries:

- `core/*_providers.dart` exposes infrastructure.
- `data/repositories/*_providers.dart` exposes repositories.
- `features/<feature>/*_providers.dart` owns feature-local UI state.

Do not read Dio, Hive, or platform services directly from a page. Inject them
through repositories or feature providers.

## Data

Repositories implement `Repository` or extend `BaseRepository`.

- Throwing methods are fine for low-level APIs.
- `RepositoryResult<T>` is preferred at feature boundaries when the UI needs a
  retryable failure state instead of an exception.
- Shared cache and local persistence go through `JsonCacheStore`,
  `KeyValueStore`, or a repository wrapper.

## Errors And Logs

`runTemplateApp` installs global Flutter, platform, and zone error handlers.
Use `appErrorReporterProvider` for recoverable feature errors that should be
logged with context.

Keep log messages free of secrets. If a value may contain a token, password, or
personal data, log a stable ID or status instead.

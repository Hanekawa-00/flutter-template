# New Feature Workflow

Generate a feature shell:

```bash
dart run scripts/new_feature.dart profile
```

The script creates:

```text
lib/src/features/profile/
  profile_page.dart
  profile_providers.dart
  README.md
```

Then:

1. Register the page in `lib/src/core/routing/app_router.dart`.
2. Add navigation in `AppShell` only if it is a top-level destination.
3. Put shared API/cache logic in `lib/src/data/repositories/`.
4. Keep feature-only UI state in `profile_providers.dart`.
5. Add a focused widget or provider test.

## Route Shape

Top-level route:

```dart
StatefulShellBranch(
  routes: [
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
)
```

Detail route:

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

Use `context.push('/settings/about')` for detail pages so back navigation keeps
the parent page state.

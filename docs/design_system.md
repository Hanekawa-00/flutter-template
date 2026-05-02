# Design System

The UI should feel like an application shell, not a marketing page. Favor dense
but calm layouts, stable dimensions, clear hierarchy, and platform-appropriate
navigation.

## Tokens

Use theme extensions instead of hard-coded spacing and radii:

```dart
final spacing = Theme.of(context).spacing;
final radii = Theme.of(context).radii;
final motion = Theme.of(context).motion;
```

## Pages

Use `PageFrame` for normal screens and `SectionCard` for grouped settings or
tool panels. A page should have one primary scroll view. Nested scroll views are
only for small horizontal controls or fixed-height previews.

## Responsive Behavior

- Below `760px`: mobile app bar, top-level bottom navigation, hidden bottom nav
  on detail pages.
- `760px` and above: desktop navigation pane, pinned page header, custom window
  chrome on Windows/Linux.
- Content controls must wrap or scroll horizontally before they overflow.

## States

Use the shared state components:

- `AppLoadingView`
- `AppEmptyState`
- `AppErrorView`
- `AppAsyncValueBuilder`

State views should explain what happened and give a direct retry/action when
the user can recover.

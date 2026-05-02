# Flutter Template Supplemental Notes

This reference is optional. The main `SKILL.md` is the complete guide.

## Useful Files

- `lib/src/core/routing/app_router.dart`: route tree.
- `lib/src/shared/widgets/app_shell.dart`: mobile/desktop navigation shell.
- `lib/src/shared/widgets/page_frame.dart`: page frame and scroll persistence.
- `lib/src/shared/widgets/desktop_window_frame_io.dart`: custom desktop chrome.
- `lib/src/core/windowing/desktop_window_io.dart`: desktop window options.
- `lib/src/core/theme/app_theme.dart`: Material 3 theme generation.
- `lib/src/core/theme/app_design_tokens.dart`: spacing, radii, motion tokens.
- `lib/src/core/settings/settings_providers.dart`: settings controller.
- `lib/src/data/repositories/repository.dart`: repository result convention.
- `scripts/new_feature.dart`: feature generator.

## Investigation Shortcuts

When `rg` is unavailable on Windows, use:

```powershell
Get-ChildItem -Path lib,test -Recurse -Include *.dart |
  Select-String -Pattern 'PageFrame|StatefulShellRoute|context.push'
```

Use these searches while diagnosing:

- Routing: `StatefulShellRoute|GoRoute|context.go|context.push|context.pop`
- Mobile back: `PopScope|backAgainToExit|SystemNavigator`
- Desktop chrome: `DragToMoveArea|DragToResizeArea|windowManager`
- Responsive UI: `LayoutBuilder|MediaQuery|NavigationBar|CustomScrollView`
- Data layer: `RepositoryResult|BaseRepository|ApiClient|JsonCacheStore`

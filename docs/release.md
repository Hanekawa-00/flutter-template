# Release And Builds

The default entry point reads `--dart-define` values:

```bash
flutter run --dart-define=APP_ENV=staging
flutter run --dart-define=APP_ENV=production --dart-define=APP_NAME=MyApp
```

Fixed environment entry points are also available:

```bash
flutter run -t lib/main_development.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_production.dart
```

## Local Checks

```bash
pwsh ./scripts/check.ps1
# or
bash ./scripts/check.sh
```

## Common Builds

```bash
flutter build web --release -t lib/main_production.dart
flutter build windows --release -t lib/main_production.dart
flutter build apk --release --split-per-abi -t lib/main_production.dart
```

For Windows desktop builds, keep Developer Mode enabled so Flutter can create
plugin symlinks.

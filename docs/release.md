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

## GitHub Release

Release workflow lives in `.github/workflows/release.yml`.

Publish with a version tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

The workflow builds and uploads these assets:

- `flutter-template-web.zip`
- `flutter-template-windows-x64.zip`
- `app-arm64-v8a-release.apk`
- `app-armeabi-v7a-release.apk`
- `app-x86_64-release.apk`

It can also be run manually from GitHub Actions with an existing tag name.

Android APKs are not signed with a production keystore by this template. Add
project-specific signing before distributing outside test channels.

For Windows desktop builds, keep Developer Mode enabled so Flutter can create
plugin symlinks.

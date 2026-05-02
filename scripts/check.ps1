$ErrorActionPreference = 'Stop'

flutter pub get
dart format --set-exit-if-changed lib test
flutter analyze
flutter test

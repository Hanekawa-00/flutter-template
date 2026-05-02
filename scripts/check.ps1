$ErrorActionPreference = 'Stop'

flutter pub get
dart format --set-exit-if-changed lib test scripts
flutter analyze
flutter test

#!/usr/bin/env bash
set -euo pipefail

flutter pub get
dart format --set-exit-if-changed lib test
flutter analyze
flutter test

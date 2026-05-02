import 'package:flutter/foundation.dart';

class AppPlatform {
  const AppPlatform._();

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => true,
      _ => false,
    };
  }

  static bool get usesCustomWindowChrome {
    if (kIsWeb) {
      return false;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.linux || TargetPlatform.windows => true,
      _ => false,
    };
  }
}

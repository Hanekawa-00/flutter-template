import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appClipboardProvider = Provider<AppClipboardService>((ref) {
  return const AppClipboardService();
});

final appSystemNavigatorProvider = Provider<AppSystemNavigator>((ref) {
  return const AppSystemNavigator();
});

class AppClipboardService {
  const AppClipboardService();

  Future<void> copyText(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

  Future<String?> readText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}

class AppSystemNavigator {
  const AppSystemNavigator();

  Future<void> exitApplication() {
    return SystemNavigator.pop();
  }

  Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }
}

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../platform/app_platform.dart';

Future<void> configureDesktopWindow() async {
  if (!AppPlatform.usesCustomWindowChrome) {
    return;
  }

  await windowManager.ensureInitialized();

  const options = WindowOptions(
    size: Size(1120, 760),
    minimumSize: Size(840, 560),
    center: true,
    backgroundColor: Colors.transparent,
  );

  await windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.setAsFrameless();
    await windowManager.show();
    await windowManager.focus();
  });
}

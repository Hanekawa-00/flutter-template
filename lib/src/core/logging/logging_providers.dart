import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config_providers.dart';
import 'app_logger.dart';

final appLoggerProvider = Provider<AppLogger>((ref) {
  final config = ref.watch(appConfigProvider);

  return AppLogger(
    minimumLevel: config.enableVerboseLogs
        ? AppLogLevel.debug
        : AppLogLevel.info,
  );
});

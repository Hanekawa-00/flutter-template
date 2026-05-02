import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app/bootstrap.dart';
import 'src/core/config/app_config.dart';
import 'src/core/errors/app_error_boundary.dart';
import 'src/core/logging/app_logger.dart';
import 'src/core/logging/provider_logger.dart';
import 'src/core/windowing/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDesktopWindow();

  final config = AppConfig.fromEnvironment();
  final logger = AppLogger(
    minimumLevel: config.enableVerboseLogs
        ? AppLogLevel.debug
        : AppLogLevel.info,
  );

  await runAppGuarded(
    logger: logger,
    run: () {
      logger.info(
        'Starting ${config.appName} in ${config.environment.label}',
        name: 'bootstrap',
      );

      runApp(
        ProviderScope(
          observers: [AppProviderObserver(logger)],
          child: const AppBootstrap(),
        ),
      );
    },
  );
}

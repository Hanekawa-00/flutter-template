import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/config/config_providers.dart';
import '../core/errors/app_error_boundary.dart';
import '../core/logging/app_logger.dart';
import '../core/logging/provider_logger.dart';
import '../core/windowing/desktop_window.dart';
import 'bootstrap.dart';

Future<void> runTemplateApp({AppConfig? config}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDesktopWindow();

  final resolvedConfig = config ?? AppConfig.fromEnvironment();
  final logger = AppLogger(
    minimumLevel: resolvedConfig.enableVerboseLogs
        ? AppLogLevel.debug
        : AppLogLevel.info,
  );

  await runAppGuarded(
    logger: logger,
    run: () {
      logger.info(
        'Starting ${resolvedConfig.appName} in '
        '${resolvedConfig.environment.label}',
        name: 'bootstrap',
      );

      runApp(
        ProviderScope(
          overrides: [appConfigProvider.overrideWithValue(resolvedConfig)],
          observers: [AppProviderObserver(logger)],
          child: const AppBootstrap(),
        ),
      );
    },
  );
}

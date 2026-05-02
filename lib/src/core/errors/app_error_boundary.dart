import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../logging/app_logger.dart';

typedef AppRunner = FutureOr<void> Function();

Future<void> runAppGuarded({
  required AppRunner run,
  required AppLogger logger,
}) async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.error(
      'Flutter framework error',
      name: 'flutter',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error(
      'Uncaught platform error',
      name: 'platform',
      error: error,
      stackTrace: stackTrace,
    );
    return true;
  };

  ErrorWidget.builder = (details) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    }

    return const Material(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Something went wrong.'),
        ),
      ),
    );
  };

  await runZonedGuarded<FutureOr<void>>(run, (error, stackTrace) {
    logger.error(
      'Uncaught zone error',
      name: 'zone',
      error: error,
      stackTrace: stackTrace,
    );
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logging/app_logger.dart';
import '../logging/logging_providers.dart';

final appErrorReporterProvider = Provider<AppErrorReporter>((ref) {
  return AppErrorReporter(ref.watch(appLoggerProvider));
});

class AppErrorReporter {
  const AppErrorReporter(this._logger);

  final AppLogger _logger;

  void record(
    Object error, {
    StackTrace? stackTrace,
    String message = 'Application error',
    String name = 'app',
    Map<String, Object?> context = const {},
    bool fatal = false,
  }) {
    final details = context.isEmpty ? message : '$message ${_format(context)}';

    if (fatal) {
      _logger.error(details, name: name, error: error, stackTrace: stackTrace);
      return;
    }

    _logger.warning(details, name: name, error: error, stackTrace: stackTrace);
  }

  String _format(Map<String, Object?> context) {
    return context.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join(' ');
  }
}

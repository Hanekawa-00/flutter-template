import 'dart:developer' as developer;

enum AppLogLevel {
  debug,
  info,
  warning,
  error;

  int get priority => switch (this) {
    AppLogLevel.debug => 0,
    AppLogLevel.info => 1,
    AppLogLevel.warning => 2,
    AppLogLevel.error => 3,
  };
}

class AppLogger {
  const AppLogger({this.minimumLevel = AppLogLevel.info});

  final AppLogLevel minimumLevel;

  void debug(String message, {String name = 'app'}) {
    log(AppLogLevel.debug, message, name: name);
  }

  void info(String message, {String name = 'app'}) {
    log(AppLogLevel.info, message, name: name);
  }

  void warning(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      AppLogLevel.warning,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void error(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      AppLogLevel.error,
      message,
      name: name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void log(
    AppLogLevel level,
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.priority < minimumLevel.priority) {
      return;
    }

    developer.log(
      message,
      name: name,
      level: _developerLevel(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  int _developerLevel(AppLogLevel level) {
    return switch (level) {
      AppLogLevel.debug => 500,
      AppLogLevel.info => 800,
      AppLogLevel.warning => 900,
      AppLogLevel.error => 1000,
    };
  }
}

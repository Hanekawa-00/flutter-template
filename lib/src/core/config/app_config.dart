import 'app_environment.dart';

class AppConfig {
  const AppConfig({required this.environment, required this.appName});

  factory AppConfig.fromEnvironment() {
    const environmentName = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const appName = String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Template',
    );

    return AppConfig(
      environment: AppEnvironment.fromName(environmentName),
      appName: appName,
    );
  }

  final AppEnvironment environment;
  final String appName;

  String get apiBaseUrl => environment.apiBaseUrl;

  bool get enableVerboseLogs => environment.enableVerboseLogs;
}

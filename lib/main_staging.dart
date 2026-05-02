import 'src/app/app_runner.dart';
import 'src/core/config/app_config.dart';
import 'src/core/config/app_environment.dart';

Future<void> main() {
  return runTemplateApp(
    config: const AppConfig(
      environment: AppEnvironment.staging,
      appName: 'Flutter Template Staging',
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/config_providers.dart';
import '../core/localization/generated/app_localizations.dart';
import '../core/routing/app_router.dart';
import '../core/settings/app_settings.dart';
import '../core/settings/settings_providers.dart';
import '../core/theme/app_theme.dart';

class AppBootstrap extends ConsumerWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final router = ref.watch(appRouterProvider);
    final settings =
        ref.watch(appSettingsControllerProvider).asData?.value ??
        AppSettings.defaults();

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      locale: null,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: settings.themeMode,
      theme: AppTheme.light(settings),
      darkTheme: AppTheme.dark(settings),
      routerConfig: router,
      builder: (context, child) {
        return _AppScrollBehavior(child: child ?? const SizedBox.shrink());
      },
    );
  }
}

class _AppScrollBehavior extends StatelessWidget {
  const _AppScrollBehavior({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
      child: child,
    );
  }
}

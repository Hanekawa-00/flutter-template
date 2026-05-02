import 'package:flutter/material.dart';

import '../settings/app_settings.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light(AppSettings settings) {
    return _theme(settings: settings, brightness: Brightness.light);
  }

  static ThemeData dark(AppSettings settings) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: settings.colorPreset.seedColor,
      brightness: Brightness.dark,
    );

    return _theme(
      settings: settings,
      brightness: Brightness.dark,
      colorScheme: settings.pureBlackDarkMode
          ? colorScheme.copyWith(
              surface: Colors.black,
              surfaceContainerLowest: Colors.black,
              surfaceContainerLow: const Color(0xFF080808),
              surfaceContainer: const Color(0xFF101010),
              surfaceContainerHigh: const Color(0xFF161616),
              surfaceContainerHighest: const Color(0xFF1E1E1E),
            )
          : colorScheme,
    );
  }

  static ThemeData _theme({
    required AppSettings settings,
    required Brightness brightness,
    ColorScheme? colorScheme,
  }) {
    final scheme =
        colorScheme ??
        ColorScheme.fromSeed(
          seedColor: settings.colorPreset.seedColor,
          brightness: brightness,
        );
    final radius = _AppRadii();
    final density = settings.compactDensity
        ? VisualDensity.compact
        : VisualDensity.standard;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      visualDensity: density,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainer,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.large),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.medium),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.medium),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primaryContainer,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer.withValues(alpha: 0.82),
        selectedIconTheme: IconThemeData(color: scheme.onPrimaryContainer),
        selectedLabelTextStyle: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.medium),
            ),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.onPrimary;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return null;
        }),
      ),
    );
  }
}

class _AppRadii {
  double get medium => 20;
  double get large => 28;
}

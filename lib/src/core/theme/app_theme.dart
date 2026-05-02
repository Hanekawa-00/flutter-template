import 'package:flutter/material.dart';

import '../settings/app_settings.dart';
import 'app_design_tokens.dart';

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
    final softenedScheme = colorScheme.copyWith(
      surface: const Color(0xFF101310),
      surfaceContainerLowest: const Color(0xFF0B0E0B),
      surfaceContainerLow: const Color(0xFF141811),
      surfaceContainer: const Color(0xFF191E16),
      surfaceContainerHigh: const Color(0xFF20261C),
      surfaceContainerHighest: const Color(0xFF293024),
    );

    return _theme(
      settings: settings,
      brightness: Brightness.dark,
      colorScheme: settings.pureBlackDarkMode
          ? softenedScheme.copyWith(
              surface: Colors.black,
              surfaceContainerLowest: Colors.black,
              surfaceContainerLow: const Color(0xFF080808),
              surfaceContainer: const Color(0xFF101010),
              surfaceContainerHigh: const Color(0xFF161616),
              surfaceContainerHighest: const Color(0xFF1E1E1E),
            )
          : softenedScheme,
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
    final radii = const AppRadii.regular();
    final spacing = settings.compactDensity
        ? const AppSpacing.compact()
        : const AppSpacing.regular();
    final density = settings.compactDensity
        ? VisualDensity.compact
        : VisualDensity.standard;
    final typography = Typography.material2021(
      platform: TargetPlatform.android,
      colorScheme: scheme,
    );
    final textTheme =
        (brightness == Brightness.dark ? typography.white : typography.black)
            .apply(
              fontFamilyFallback: const [
                'Microsoft YaHei UI',
                'Segoe UI',
                'PingFang SC',
                'Noto Sans CJK SC',
              ],
            );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      visualDensity: density,
      extensions: [spacing, radii, const AppMotion.standard()],
      textTheme: textTheme,
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
          borderRadius: BorderRadius.circular(radii.xl),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.xl,
            vertical: spacing.lg,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radii.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.md),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.md),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.65),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radii.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.md),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: scheme.surfaceContainerLow,
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
              borderRadius: BorderRadius.circular(radii.md),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radii.md),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 450),
        decoration: BoxDecoration(
          color: scheme.inverseSurface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(radii.sm),
        ),
        textStyle: TextStyle(color: scheme.onInverseSurface),
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

import 'package:flutter/material.dart';

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  const AppSpacing.regular()
    : xs = 4,
      sm = 8,
      md = 12,
      lg = 16,
      xl = 24,
      xxl = 32;

  const AppSpacing.compact()
    : xs = 3,
      sm = 6,
      md = 10,
      lg = 14,
      xl = 20,
      xxl = 28;

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) {
      return this;
    }

    return AppSpacing(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
    );
  }
}

@immutable
class AppRadii extends ThemeExtension<AppRadii> {
  const AppRadii({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });

  const AppRadii.regular() : sm = 10, md = 16, lg = 20, xl = 28, full = 999;

  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  @override
  AppRadii copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) {
    return AppRadii(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
    );
  }

  @override
  AppRadii lerp(ThemeExtension<AppRadii>? other, double t) {
    if (other is! AppRadii) {
      return this;
    }

    return AppRadii(
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      full: _lerp(full, other.full, t),
    );
  }
}

@immutable
class AppMotion extends ThemeExtension<AppMotion> {
  const AppMotion({
    required this.fast,
    required this.normal,
    required this.slow,
  });

  const AppMotion.standard()
    : fast = const Duration(milliseconds: 120),
      normal = const Duration(milliseconds: 180),
      slow = const Duration(milliseconds: 260);

  final Duration fast;
  final Duration normal;
  final Duration slow;

  @override
  AppMotion copyWith({Duration? fast, Duration? normal, Duration? slow}) {
    return AppMotion(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
    );
  }

  @override
  AppMotion lerp(ThemeExtension<AppMotion>? other, double t) {
    if (other is! AppMotion) {
      return this;
    }

    return AppMotion(
      fast: _lerpDuration(fast, other.fast, t),
      normal: _lerpDuration(normal, other.normal, t),
      slow: _lerpDuration(slow, other.slow, t),
    );
  }
}

extension AppDesignTokens on ThemeData {
  AppSpacing get spacing =>
      extension<AppSpacing>() ?? const AppSpacing.regular();
  AppRadii get radii => extension<AppRadii>() ?? const AppRadii.regular();
  AppMotion get motion => extension<AppMotion>() ?? const AppMotion.standard();
}

double _lerp(double start, double end, double t) {
  return start + (end - start) * t;
}

Duration _lerpDuration(Duration start, Duration end, double t) {
  return Duration(
    microseconds: _lerp(
      start.inMicroseconds.toDouble(),
      end.inMicroseconds.toDouble(),
      t,
    ).round(),
  );
}

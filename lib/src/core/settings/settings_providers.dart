import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';
import 'settings_repository.dart';

final settingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
  return SettingsRepository(SharedPreferencesAsync());
});

final appSettingsControllerProvider =
    AsyncNotifierProvider<AppSettingsController, AppSettings>(
      AppSettingsController.new,
    );

class AppSettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return ref.watch(settingsRepositoryProvider).load();
  }

  Future<void> setThemeMode(ThemeMode themeMode) {
    return _update((settings) => settings.copyWith(themeMode: themeMode));
  }

  Future<void> setColorPreset(AppColorPreset colorPreset) {
    return _update((settings) => settings.copyWith(colorPreset: colorPreset));
  }

  Future<void> setPureBlackDarkMode(bool enabled) {
    return _update((settings) => settings.copyWith(pureBlackDarkMode: enabled));
  }

  Future<void> setCompactDensity(bool enabled) {
    return _update((settings) => settings.copyWith(compactDensity: enabled));
  }

  Future<void> reset() {
    return _update((settings) => AppSettings.defaults());
  }

  Future<void> _update(AppSettings Function(AppSettings) update) async {
    final repository = ref.read(settingsRepositoryProvider);
    final previous = state.asData?.value ?? AppSettings.defaults();
    final next = update(previous);

    state = AsyncData(next);

    try {
      await repository.save(next);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

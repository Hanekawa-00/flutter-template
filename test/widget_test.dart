import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/app/bootstrap.dart';
import 'package:flutter_template/src/core/settings/app_settings.dart';
import 'package:flutter_template/src/core/settings/settings_providers.dart';
import 'package:flutter_template/src/core/settings/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('renders the template home screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(
            _FakeSettingsRepository(),
          ),
        ],
        child: const AppBootstrap(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Flutter Template'), findsWidgets);
    expect(find.text('Template ready'), findsOneWidget);
    expect(find.byIcon(Icons.tune), findsWidgets);
  });
}

class _FakeSettingsRepository implements AppSettingsRepository {
  AppSettings _settings = AppSettings.defaults();

  @override
  Future<AppSettings> load() async => _settings;

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}

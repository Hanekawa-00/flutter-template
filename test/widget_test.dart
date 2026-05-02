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

  testWidgets('mobile top-level pages keep bottom navigation', (tester) async {
    _setMobileViewport(tester);

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

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Flutter Template'), findsWidgets);
  });

  testWidgets('mobile settings subpage hides bottom navigation', (
    tester,
  ) async {
    _setMobileViewport(tester);

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
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('About'), 520);
    await Scrollable.ensureVisible(
      tester.element(find.text('About')),
      alignment: 0.5,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('mobile top-level back asks before exiting', (tester) async {
    _setMobileViewport(tester);

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
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Press back again to exit'), findsOneWidget);
  });

  testWidgets('mobile component gallery adapts to narrow screens', (
    tester,
  ) async {
    _setMobileViewport(tester);

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
    await tester.tap(find.text('Components'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Components'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop settings keeps reset only in content', (tester) async {
    _setDesktopViewport(tester);

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
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, -900),
      900,
    );
    await tester.pumpAndSettle();

    expect(find.text('Reset'), findsNothing);
    expect(find.text('Reset preferences'), findsOneWidget);
  });

  testWidgets('desktop subpage actions stay available after scrolling', (
    tester,
  ) async {
    _setDesktopViewport(tester);

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
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, -900),
      900,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('About').last);
    await tester.pumpAndSettle();
    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, -900),
      900,
    );
    await tester.pumpAndSettle();

    expect(find.text('Back to settings'), findsOneWidget);
  });
}

void _setMobileViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void _setDesktopViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1200, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
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

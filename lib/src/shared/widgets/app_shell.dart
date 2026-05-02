import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/theme/app_design_tokens.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.location, required this.child});

  final String location;
  final Widget child;

  static const _destinations = [
    _ShellDestination(
      path: '/',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    _ShellDestination(
      path: '/settings',
      icon: Icons.tune_outlined,
      selectedIcon: Icons.tune,
    ),
    _ShellDestination(
      path: '/components',
      icon: Icons.widgets_outlined,
      selectedIcon: Icons.widgets,
    ),
    _ShellDestination(
      path: '/about',
      icon: Icons.info_outline,
      selectedIcon: Icons.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _selectedIndexFor(location);

    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 760;

        if (useRail) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Row(
              children: [
                _DesktopNavigationPane(
                  child: NavigationRail(
                    selectedIndex: selectedIndex,
                    extended: constraints.maxWidth >= 1080,
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: _AppMark(),
                    ),
                    destinations: [
                      for (final destination in _destinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.selectedIcon),
                          label: Text(destination.label(context)),
                        ),
                    ],
                    onDestinationSelected: (index) {
                      context.go(_destinations[index].path);
                    },
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          );
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            destinations: [
              for (final destination in _destinations)
                NavigationDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: destination.label(context),
                ),
            ],
            onDestinationSelected: (index) {
              context.go(_destinations[index].path);
            },
          ),
        );
      },
    );
  }

  int _selectedIndexFor(String location) {
    final index = _destinations.indexWhere((item) => item.path == location);
    return index < 0 ? 0 : index;
  }
}

class _DesktopNavigationPane extends StatelessWidget {
  const _DesktopNavigationPane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.22),
          ),
        ),
      ),
      child: child,
    );
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.path,
    required this.icon,
    required this.selectedIcon,
  });

  final String path;
  final IconData icon;
  final IconData selectedIcon;

  String label(BuildContext context) {
    final l10n = context.l10n;

    return switch (path) {
      '/settings' => l10n.navSettings,
      '/components' => l10n.navComponents,
      '/about' => l10n.navAbout,
      _ => l10n.navHome,
    };
  }
}

class _AppMark extends StatelessWidget {
  const _AppMark();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radii = Theme.of(context).radii;

    return Tooltip(
      message: context.l10n.appTitle,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: BorderRadius.circular(radii.md),
        ),
        child: Icon(Icons.layers_rounded, color: scheme.onPrimaryContainer),
      ),
    );
  }
}

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
          final extended = constraints.maxWidth >= 1080;

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: _DesktopShellBackground(
              child: Row(
                children: [
                  _DesktopNavigationPane(
                    extended: extended,
                    selectedIndex: selectedIndex,
                    destinations: _destinations,
                    onDestinationSelected: (index) {
                      context.go(_destinations[index].path);
                    },
                  ),
                  Expanded(child: _DesktopContentPane(child: child)),
                ],
              ),
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

class _DesktopShellBackground extends StatelessWidget {
  const _DesktopShellBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.surfaceContainerLowest,
            scheme.surfaceContainerLowest,
            scheme.surface,
          ],
          stops: const [0, 0.22, 0.68],
        ),
      ),
      child: child,
    );
  }
}

class _DesktopNavigationPane extends StatelessWidget {
  const _DesktopNavigationPane({
    required this.extended,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
  });

  final bool extended;
  final int selectedIndex;
  final List<_ShellDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final width = extended ? 232.0 : 88.0;

    return AnimatedContainer(
      duration: theme.motion.normal,
      curve: Curves.easeOutCubic,
      width: width,
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.xl,
        spacing.lg,
        spacing.xl,
      ),
      child: Column(
        children: [
          _AppMark(extended: extended),
          SizedBox(height: spacing.xxl),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: destinations.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: spacing.sm),
              itemBuilder: (context, index) {
                final destination = destinations[index];

                return _DesktopNavItem(
                  icon: destination.icon,
                  selectedIcon: destination.selectedIcon,
                  label: destination.label(context),
                  selected: selectedIndex == index,
                  extended: extended,
                  onTap: () => onDestinationSelected(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopContentPane extends StatelessWidget {
  const _DesktopContentPane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.82),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(28)),
      ),
      child: child,
    );
  }
}

class _DesktopNavItem extends StatefulWidget {
  const _DesktopNavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.extended,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final bool extended;
  final VoidCallback onTap;

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = theme.spacing;
    final radii = theme.radii;
    final selected = widget.selected;
    final foreground = selected ? scheme.onPrimaryContainer : scheme.onSurface;
    final mutedForeground = selected
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;
    final background = selected
        ? scheme.primaryContainer
        : _hovered
        ? scheme.surfaceContainerHigh.withValues(alpha: 0.72)
        : Colors.transparent;

    final navItem = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(radii.full),
          child: AnimatedContainer(
            duration: theme.motion.fast,
            curve: Curves.easeOutCubic,
            height: 48,
            padding: EdgeInsets.symmetric(
              horizontal: widget.extended ? spacing.lg : 0,
            ),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(radii.full),
            ),
            child: Row(
              mainAxisAlignment: widget.extended
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  selected ? widget.selectedIcon : widget.icon,
                  color: selected ? foreground : mutedForeground,
                ),
                if (widget.extended) ...[
                  SizedBox(width: spacing.md),
                  Expanded(
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: foreground,
                        fontWeight: selected ? FontWeight.w700 : null,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.extended) {
      return navItem;
    }

    return Tooltip(message: widget.label, child: navItem);
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
  const _AppMark({required this.extended});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Tooltip(
      message: context.l10n.appTitle,
      child: Row(
        mainAxisAlignment: extended
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(radii.md),
            ),
            child: Icon(Icons.layers_rounded, color: scheme.onPrimaryContainer),
          ),
          if (extended) ...[
            SizedBox(width: spacing.md),
            Expanded(
              child: Text(
                context.l10n.appTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

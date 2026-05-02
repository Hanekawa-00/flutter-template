import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/theme/app_design_tokens.dart';
import '../services/app_messenger.dart';

class AppCommandPalette extends StatelessWidget {
  const AppCommandPalette({
    super.key,
    required this.router,
    required this.child,
  });

  final GoRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyK, control: true):
            _OpenCommandPaletteIntent(),
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            _OpenCommandPaletteIntent(),
      },
      child: Actions(
        actions: {
          _OpenCommandPaletteIntent: CallbackAction<_OpenCommandPaletteIntent>(
            onInvoke: (_) {
              showAppCommandPalette(context, router: router);
              return null;
            },
          ),
        },
        child: Focus(autofocus: true, child: child),
      ),
    );
  }
}

Future<void> showAppCommandPalette(
  BuildContext context, {
  required GoRouter router,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _CommandPaletteDialog(router: router),
  );
}

class _OpenCommandPaletteIntent extends Intent {
  const _OpenCommandPaletteIntent();
}

class _CommandPaletteDialog extends StatefulWidget {
  const _CommandPaletteDialog({required this.router});

  final GoRouter router;

  @override
  State<_CommandPaletteDialog> createState() => _CommandPaletteDialogState();
}

class _CommandPaletteDialogState extends State<_CommandPaletteDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final scheme = theme.colorScheme;
    final commands = _commands(context);
    final query = _controller.text.trim().toLowerCase();
    final visibleCommands = query.isEmpty
        ? commands
        : commands.where((command) {
            return command.title.toLowerCase().contains(query) ||
                command.subtitle.toLowerCase().contains(query);
          }).toList();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 560),
        child: Padding(
          padding: EdgeInsets.all(spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: l10n.commandPaletteSearchHint,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) {
                  if (visibleCommands.isNotEmpty) {
                    _run(visibleCommands.first);
                  }
                },
              ),
              SizedBox(height: spacing.md),
              Flexible(
                child: visibleCommands.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: spacing.xxl),
                        child: Text(
                          l10n.commandPaletteNoResults,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: visibleCommands.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: spacing.xs),
                        itemBuilder: (context, index) {
                          final command = visibleCommands[index];

                          return ListTile(
                            leading: Icon(command.icon, color: scheme.primary),
                            title: Text(command.title),
                            subtitle: Text(command.subtitle),
                            trailing: const Icon(Icons.keyboard_return),
                            onTap: () => _run(command),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_PaletteCommand> _commands(BuildContext context) {
    final l10n = context.l10n;

    return [
      _PaletteCommand(
        icon: Icons.dashboard_outlined,
        title: l10n.commandGoHome,
        subtitle: l10n.homeSubtitle,
        action: () => widget.router.go('/'),
      ),
      _PaletteCommand(
        icon: Icons.tune_outlined,
        title: l10n.commandGoSettings,
        subtitle: l10n.settingsSubtitle,
        action: () => widget.router.go('/settings'),
      ),
      _PaletteCommand(
        icon: Icons.widgets_outlined,
        title: l10n.commandGoComponents,
        subtitle: l10n.componentsSubtitle,
        action: () => widget.router.go('/components'),
      ),
      _PaletteCommand(
        icon: Icons.info_outline,
        title: l10n.commandGoAbout,
        subtitle: l10n.aboutSubtitle,
        action: () => widget.router.go('/settings/about'),
      ),
    ];
  }

  void _run(_PaletteCommand command) {
    final message = context.l10n.commandPaletteExecuted;

    AppMessenger.showInfo(context, message);
    Navigator.of(context).pop();
    command.action();
  }
}

class _PaletteCommand {
  const _PaletteCommand({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.action,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback action;
}

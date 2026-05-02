import 'package:flutter/material.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/theme/app_design_tokens.dart';

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return _StateViewShell(
      icon: Icons.hourglass_empty_rounded,
      title: message ?? context.l10n.stateLoading,
      child: const Padding(
        padding: EdgeInsets.only(top: 16),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, this.title, this.message, this.action});

  final String? title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return _StateViewShell(
      icon: Icons.inbox_outlined,
      title: title ?? context.l10n.stateEmptyTitle,
      message: message ?? context.l10n.stateEmptyMessage,
      child: action == null
          ? null
          : Padding(padding: const EdgeInsets.only(top: 16), child: action),
    );
  }
}

class AppErrorView extends StatelessWidget {
  const AppErrorView({super.key, this.title, this.message, this.onRetry});

  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateViewShell(
      icon: Icons.error_outline_rounded,
      title: title ?? context.l10n.stateErrorTitle,
      message: message ?? context.l10n.stateErrorMessage,
      child: onRetry == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.stateRetry),
              ),
            ),
    );
  }
}

class _StateViewShell extends StatelessWidget {
  const _StateViewShell({
    required this.icon,
    required this.title,
    this.message,
    this.child,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: EdgeInsets.all(spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(radii.lg),
                ),
                child: Icon(icon, color: scheme.onPrimaryContainer),
              ),
              SizedBox(height: spacing.lg),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (message != null) ...[
                SizedBox(height: spacing.sm),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
              ?child,
            ],
          ),
        ),
      ),
    );
  }
}

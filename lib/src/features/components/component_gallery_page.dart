import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/theme/app_design_tokens.dart';
import '../../shared/services/app_messenger.dart';
import '../../shared/widgets/app_async_value_builder.dart';
import '../../shared/widgets/app_state_views.dart';
import '../../shared/widgets/confirm_action_dialog.dart';
import '../../shared/widgets/page_frame.dart';
import '../../shared/widgets/section_card.dart';

class ComponentGalleryPage extends StatefulWidget {
  const ComponentGalleryPage({super.key});

  @override
  State<ComponentGalleryPage> createState() => _ComponentGalleryPageState();
}

class _ComponentGalleryPageState extends State<ComponentGalleryPage> {
  AsyncValue<String> _asyncState = const AsyncData('Ready');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return PageFrame(
      title: l10n.componentsTitle,
      subtitle: l10n.componentsSubtitle,
      children: [
        SectionCard(
          title: l10n.componentsStatesTitle,
          icon: Icons.auto_awesome_motion_outlined,
          children: const [_StatePreviewGrid()],
        ),
        SectionCard(
          title: l10n.componentsStyleTitle,
          icon: Icons.interests_outlined,
          children: const [_ControlStylePreview()],
        ),
        SectionCard(
          title: l10n.componentsAsyncTitle,
          icon: Icons.sync_alt_rounded,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() {
                      _asyncState = const AsyncLoading();
                    });
                  },
                  icon: const Icon(Icons.hourglass_empty),
                  label: Text(l10n.stateLoading),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() {
                      _asyncState = const AsyncData('Ready');
                    });
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l10n.componentsAsyncData),
                ),
                FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() {
                      _asyncState = AsyncError(
                        StateError('Preview error'),
                        StackTrace.current,
                      );
                    });
                  },
                  icon: const Icon(Icons.error_outline),
                  label: Text(l10n.stateErrorTitle),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(24),
              ),
              child: AppAsyncValueBuilder<String>(
                value: _asyncState,
                data: (context, value) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 48,
                          color: scheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.componentsAsyncReady,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  );
                },
                onRetry: () {
                  setState(() {
                    _asyncState = const AsyncData('Ready');
                  });
                },
              ),
            ),
          ],
        ),
        SectionCard(
          title: l10n.componentsFeedbackTitle,
          icon: Icons.notifications_active_outlined,
          children: [
            Text(
              l10n.componentsFeedbackDescription,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    AppMessenger.showSuccess(
                      context,
                      l10n.componentsSuccessToast,
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l10n.componentsShowSuccess),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    AppMessenger.showError(context, l10n.componentsErrorToast);
                  },
                  icon: const Icon(Icons.error_outline),
                  label: Text(l10n.componentsShowError),
                ),
              ],
            ),
          ],
        ),
        SectionCard(
          title: l10n.componentsDialogsTitle,
          icon: Icons.chat_bubble_outline,
          children: [
            Text(
              l10n.componentsDialogsDescription,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () async {
                await ConfirmActionDialog.show(
                  context,
                  title: l10n.componentsDialogTitle,
                  message: l10n.componentsDialogMessage,
                  confirmLabel: l10n.commonConfirm,
                  cancelLabel: l10n.commonCancel,
                );
              },
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.componentsOpenDialog),
            ),
          ],
        ),
      ],
    );
  }
}

class _ControlStylePreview extends StatefulWidget {
  const _ControlStylePreview();

  @override
  State<_ControlStylePreview> createState() => _ControlStylePreviewState();
}

class _ControlStylePreviewState extends State<_ControlStylePreview> {
  double _progress = 0.62;
  bool _enabled = true;
  Set<String> _selection = const {'comfortable'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final scheme = theme.colorScheme;
    final spacing = theme.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.componentsStyleDescription,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: spacing.lg),
        Wrap(
          spacing: spacing.md,
          runSpacing: spacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(l10n.componentsPrimaryButton),
            ),
            FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome_outlined),
              label: Text(l10n.componentsTonalButton),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune_outlined),
              label: Text(l10n.componentsOutlineButton),
            ),
          ],
        ),
        SizedBox(height: spacing.lg),
        TextField(
          decoration: InputDecoration(
            labelText: l10n.componentsSearchLabel,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        SizedBox(height: spacing.lg),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 0),
            child: SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'compact',
                  icon: const Icon(Icons.view_agenda_outlined),
                  label: Text(l10n.componentsCompactChoice),
                ),
                ButtonSegment(
                  value: 'comfortable',
                  icon: const Icon(Icons.view_stream_outlined),
                  label: Text(l10n.componentsComfortChoice),
                ),
              ],
              selected: _selection,
              onSelectionChanged: (value) {
                setState(() {
                  _selection = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: spacing.lg),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _progress,
                onChanged: (value) {
                  setState(() {
                    _progress = value;
                  });
                },
              ),
            ),
            Switch(
              value: _enabled,
              onChanged: (value) {
                setState(() {
                  _enabled = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _StatePreviewGrid extends StatelessWidget {
  const _StatePreviewGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 920
            ? 3
            : constraints.maxWidth >= 620
            ? 2
            : 1;

        final panes = const [
          _PreviewPane(child: AppLoadingView()),
          _PreviewPane(child: AppEmptyState()),
          _PreviewPane(child: AppErrorView()),
        ];

        if (columns == 1) {
          return Column(
            children: [
              for (final pane in panes) ...[
                SizedBox(height: 240, child: pane),
                if (pane != panes.last) const SizedBox(height: 12),
              ],
            ],
          );
        }

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.35,
          children: panes,
        );
      },
    );
  }
}

class _PreviewPane extends StatelessWidget {
  const _PreviewPane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

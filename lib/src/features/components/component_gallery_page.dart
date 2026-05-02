import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/localization_extensions.dart';
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

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: columns == 1 ? 1.9 : 1.35,
          children: const [
            _PreviewPane(child: AppLoadingView()),
            _PreviewPane(child: AppEmptyState()),
            _PreviewPane(child: AppErrorView()),
          ],
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

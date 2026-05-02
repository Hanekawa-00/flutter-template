import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/settings/settings_providers.dart';
import '../../shared/widgets/app_state_views.dart';
import '../../shared/widgets/page_frame.dart';
import '../../shared/widgets/section_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(appSettingsControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return PageFrame(
      title: l10n.homeTitle,
      subtitle: l10n.homeSubtitle,
      trailing: IconButton.filledTonal(
        tooltip: l10n.openSettingsTooltip,
        onPressed: () => context.go('/settings'),
        icon: const Icon(Icons.tune),
      ),
      children: [
        _StatusPanel(isLoading: settings.isLoading),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 720;
            final cards = [
              _CapabilityCard(
                icon: Icons.devices_rounded,
                title: l10n.capabilityCrossPlatformTitle,
                description: l10n.capabilityCrossPlatformDescription,
              ),
              _CapabilityCard(
                icon: Icons.palette_outlined,
                title: l10n.capabilityThemeTitle,
                description: l10n.capabilityThemeDescription,
              ),
              _CapabilityCard(
                icon: Icons.route_outlined,
                title: l10n.capabilityRoutingTitle,
                description: l10n.capabilityRoutingDescription,
              ),
              _CapabilityCard(
                icon: Icons.extension_outlined,
                title: l10n.capabilityExtensionTitle,
                description: l10n.capabilityExtensionDescription,
              ),
            ];

            if (!twoColumns) {
              return Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    if (card != cards.last) const SizedBox(height: 12),
                  ],
                ],
              );
            }

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: cards,
            );
          },
        ),
        SectionCard(
          title: l10n.nextStepsTitle,
          icon: Icons.checklist_rounded,
          children: [
            _NextStepTile(color: scheme.primary, label: l10n.nextStepFeature),
            _NextStepTile(
              color: scheme.tertiary,
              label: l10n.nextStepRepository,
            ),
            _NextStepTile(color: scheme.secondary, label: l10n.nextStepDesktop),
          ],
        ),
        SectionCard(
          title: l10n.stateComponentsTitle,
          icon: Icons.widgets_outlined,
          children: const [SizedBox(height: 220, child: AppEmptyState())],
        ),
      ],
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLoading ? Icons.sync_rounded : Icons.layers_rounded,
              color: scheme.primary,
              size: 34,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLoading ? l10n.homeStatusLoading : l10n.homeStatusReady,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.homeStatusDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: scheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextStepTile extends StatelessWidget {
  const _NextStepTile({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(Icons.radio_button_checked, color: color, size: 18),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
        ],
      ),
    );
  }
}

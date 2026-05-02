import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/config/config_providers.dart';
import '../../core/localization/localization_extensions.dart';
import '../../shared/widgets/page_frame.dart';
import '../../shared/widgets/section_card.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final config = ref.watch(appConfigProvider);

    return PageFrame(
      storageId: 'settings-about',
      title: l10n.aboutTitle,
      subtitle: l10n.aboutSubtitle,
      trailing: OutlinedButton.icon(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
            return;
          }

          context.go('/settings');
        },
        icon: const Icon(Icons.arrow_back_rounded),
        label: Text(l10n.aboutBackToSettings),
      ),
      children: [
        SectionCard(
          title: l10n.aboutStructureTitle,
          icon: Icons.account_tree_outlined,
          children: [
            _InfoRow(label: l10n.aboutCoreLabel, value: l10n.aboutCoreValue),
            _InfoRow(
              label: l10n.aboutFeaturesLabel,
              value: l10n.aboutFeaturesValue,
            ),
            _InfoRow(
              label: l10n.aboutSharedLabel,
              value: l10n.aboutSharedValue,
            ),
          ],
        ),
        SectionCard(
          title: l10n.aboutVersionTitle,
          icon: Icons.info_outline,
          children: [
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final info = snapshot.data;

                return Column(
                  children: [
                    _InfoRow(
                      label: l10n.aboutAppNameLabel,
                      value: info?.appName ?? l10n.appTitle,
                    ),
                    _InfoRow(
                      label: l10n.aboutPackageLabel,
                      value:
                          info?.packageName ?? 'com.example.flutter_template',
                    ),
                    _InfoRow(
                      label: l10n.aboutVersionLabel,
                      value: info?.version ?? '1.0.0',
                    ),
                    _InfoRow(
                      label: l10n.aboutBuildLabel,
                      value: info?.buildNumber ?? '1',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        SectionCard(
          title: l10n.aboutEnvironmentTitle,
          icon: Icons.settings_applications_outlined,
          children: [
            _InfoRow(
              label: l10n.aboutEnvironmentLabel,
              value: config.environment.label,
            ),
            _InfoRow(
              label: l10n.aboutApiBaseUrlLabel,
              value: config.apiBaseUrl,
            ),
            _InfoRow(
              label: l10n.aboutVerboseLogsLabel,
              value: config.enableVerboseLogs
                  ? l10n.commonEnabled
                  : l10n.commonDisabled,
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Text(
              label,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

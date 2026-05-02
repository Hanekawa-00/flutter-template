import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/settings/app_settings.dart';
import '../../core/settings/settings_providers.dart';
import '../../shared/widgets/page_frame.dart';
import '../../shared/widgets/section_card.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final asyncSettings = ref.watch(appSettingsControllerProvider);
    final settings = asyncSettings.asData?.value ?? AppSettings.defaults();
    final controller = ref.read(appSettingsControllerProvider.notifier);

    return PageFrame(
      title: l10n.settingsTitle,
      subtitle: l10n.settingsSubtitle,
      children: [
        if (asyncSettings.hasError)
          _ErrorBanner(error: asyncSettings.error.toString()),
        SectionCard(
          title: l10n.settingsAppearanceTitle,
          icon: Icons.palette_outlined,
          children: [
            _SettingBlock(
              title: l10n.settingsThemeModeTitle,
              subtitle: l10n.settingsThemeModeSubtitle,
              child: SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: const Icon(Icons.brightness_auto_outlined),
                    label: Text(l10n.themeModeSystem),
                  ),
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: const Icon(Icons.light_mode_outlined),
                    label: Text(l10n.themeModeLight),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: const Icon(Icons.dark_mode_outlined),
                    label: Text(l10n.themeModeDark),
                  ),
                ],
                selected: {settings.themeMode},
                onSelectionChanged: (value) {
                  controller.setThemeMode(value.first);
                },
              ),
            ),
            const SizedBox(height: 20),
            _SettingBlock(
              title: l10n.settingsThemeColorTitle,
              subtitle: l10n.settingsThemeColorSubtitle,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final preset in AppColorPreset.values)
                    _ColorPresetButton(
                      preset: preset,
                      selected: settings.colorPreset == preset,
                      onSelected: () => controller.setColorPreset(preset),
                    ),
                ],
              ),
            ),
          ],
        ),
        SectionCard(
          title: l10n.settingsExperienceTitle,
          icon: Icons.tune_outlined,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.settingsPureBlackTitle),
              subtitle: Text(l10n.settingsPureBlackSubtitle),
              value: settings.pureBlackDarkMode,
              onChanged: controller.setPureBlackDarkMode,
            ),
            const Divider(),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.settingsCompactDensityTitle),
              subtitle: Text(l10n.settingsCompactDensitySubtitle),
              value: settings.compactDensity,
              onChanged: controller.setCompactDensity,
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingBlock extends StatelessWidget {
  const _SettingBlock({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _ColorPresetButton extends StatelessWidget {
  const _ColorPresetButton({
    required this.preset,
    required this.selected,
    required this.onSelected,
  });

  final AppColorPreset preset;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: preset.label,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onSelected,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: preset.seedColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? scheme.onSurface : Colors.transparent,
              width: 3,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: preset.seedColor.withValues(alpha: 0.3),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: selected
              ? Icon(Icons.check, color: scheme.onPrimary)
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      color: scheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: scheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.l10n.settingsSaveFailed(error),
                style: TextStyle(color: scheme.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

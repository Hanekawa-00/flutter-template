import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/settings/app_settings.dart';
import '../../core/settings/settings_providers.dart';
import '../../core/theme/app_design_tokens.dart';
import '../../shared/services/app_messenger.dart';
import '../../shared/widgets/confirm_action_dialog.dart';
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
    Future<void> resetSettings() async {
      final confirmed = await ConfirmActionDialog.show(
        context,
        title: l10n.settingsResetTitle,
        message: l10n.settingsResetMessage,
        confirmLabel: l10n.settingsResetConfirm,
        cancelLabel: l10n.commonCancel,
      );

      if (!confirmed || !context.mounted) {
        return;
      }

      await controller.reset();

      if (!context.mounted) {
        return;
      }

      AppMessenger.showSuccess(context, l10n.settingsResetSuccess);
    }

    return PageFrame(
      title: l10n.settingsTitle,
      subtitle: l10n.settingsSubtitle,
      trailing: OutlinedButton.icon(
        onPressed: resetSettings,
        icon: const Icon(Icons.restart_alt),
        label: Text(l10n.settingsResetAction),
      ),
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
            SizedBox(height: Theme.of(context).spacing.xl),
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
            _PreferenceTile(
              icon: Icons.contrast_rounded,
              title: Text(l10n.settingsPureBlackTitle),
              subtitle: Text(l10n.settingsPureBlackSubtitle),
              trailing: Switch(
                value: settings.pureBlackDarkMode,
                onChanged: controller.setPureBlackDarkMode,
              ),
              onTap: () {
                controller.setPureBlackDarkMode(!settings.pureBlackDarkMode);
              },
            ),
            _PreferenceTile(
              icon: Icons.density_medium_outlined,
              title: Text(l10n.settingsCompactDensityTitle),
              subtitle: Text(l10n.settingsCompactDensitySubtitle),
              trailing: Switch(
                value: settings.compactDensity,
                onChanged: controller.setCompactDensity,
              ),
              onTap: () {
                controller.setCompactDensity(!settings.compactDensity);
              },
            ),
          ],
        ),
        SectionCard(
          title: l10n.settingsOtherTitle,
          icon: Icons.more_horiz_rounded,
          children: [
            _PreferenceTile(
              icon: Icons.info_outline,
              title: Text(l10n.aboutTitle),
              subtitle: Text(l10n.aboutSubtitle),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => context.go('/settings/about'),
            ),
            _PreferenceTile(
              icon: Icons.restart_alt_rounded,
              title: Text(l10n.settingsResetTitle),
              subtitle: Text(l10n.settingsResetMessage),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: resetSettings,
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = theme.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: spacing.xs),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        SizedBox(height: spacing.md),
        child,
      ],
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = theme.spacing;
    final radii = theme.radii;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(radii.lg),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: scheme.primary),
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          contentPadding: EdgeInsets.symmetric(
            horizontal: spacing.lg,
            vertical: spacing.sm,
          ),
        ),
      ),
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
              ? Icon(Icons.check, color: _foregroundFor(preset.seedColor))
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

Color _foregroundFor(Color color) {
  return color.computeLuminance() > 0.45 ? Colors.black : Colors.white;
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

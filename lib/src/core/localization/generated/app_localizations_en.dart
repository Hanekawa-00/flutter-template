// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Template';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Settings';

  @override
  String get navComponents => 'Components';

  @override
  String get navAbout => 'About';

  @override
  String get homeTitle => 'Flutter Template';

  @override
  String get homeSubtitle =>
      'A cross-platform app template with common capabilities ready for real features.';

  @override
  String get openSettingsTooltip => 'Open settings';

  @override
  String get homeStatusLoading => 'Loading settings';

  @override
  String get homeStatusReady => 'Template ready';

  @override
  String get homeStatusDescription =>
      'This screen avoids fake business data and only shows template capabilities.';

  @override
  String get capabilityCrossPlatformTitle => 'Cross-platform base';

  @override
  String get capabilityCrossPlatformDescription =>
      'Android, iOS, Web, Windows, macOS, and Linux platform folders are ready.';

  @override
  String get capabilityThemeTitle => 'Theme system';

  @override
  String get capabilityThemeDescription =>
      'System, light, dark, seed colors, OLED dark mode, and compact density are supported.';

  @override
  String get capabilityRoutingTitle => 'Routing shell';

  @override
  String get capabilityRoutingDescription =>
      'go_router Shell is wired with bottom navigation on mobile and a rail on wide screens.';

  @override
  String get capabilityExtensionTitle => 'Extension boundary';

  @override
  String get capabilityExtensionDescription =>
      'core, features, and shared layers keep future modules easy to add.';

  @override
  String get nextStepsTitle => 'Suggested next steps';

  @override
  String get nextStepFeature =>
      'Place the first business page under lib/src/features/<feature_name>';

  @override
  String get nextStepRepository =>
      'Add a repository for data sources and inject it with Riverpod providers';

  @override
  String get nextStepDesktop =>
      'Add window, tray, or hotkey plugins only when desktop workflows need them';

  @override
  String get stateComponentsTitle => 'UI state components';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle =>
      'Only common preferences live here; feature settings can be added by section.';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsThemeModeTitle => 'Theme mode';

  @override
  String get settingsThemeModeSubtitle => 'Follow system, light, or dark mode.';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get settingsThemeColorTitle => 'Theme color';

  @override
  String get settingsThemeColorSubtitle =>
      'Material 3 generates the full palette from the seed color.';

  @override
  String get settingsExperienceTitle => 'Experience';

  @override
  String get settingsPureBlackTitle => 'OLED dark enhancement';

  @override
  String get settingsPureBlackSubtitle =>
      'Use a purer black surface in dark mode.';

  @override
  String get settingsCompactDensityTitle => 'Compact density';

  @override
  String get settingsCompactDensitySubtitle =>
      'Make desktop and information-dense pages more restrained.';

  @override
  String settingsSaveFailed(String error) {
    return 'Failed to save settings: $error';
  }

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutSubtitle =>
      'A general, extensible, cross-platform-first Flutter template.';

  @override
  String get aboutStructureTitle => 'Project structure';

  @override
  String get aboutCoreLabel => 'core';

  @override
  String get aboutCoreValue =>
      'Routing, theme, settings, and other infrastructure';

  @override
  String get aboutFeaturesLabel => 'features';

  @override
  String get aboutFeaturesValue => 'Pages and state split by feature';

  @override
  String get aboutSharedLabel => 'shared';

  @override
  String get aboutSharedValue => 'Reusable UI shared across features';

  @override
  String get aboutVersionTitle => 'Version';

  @override
  String get aboutAppNameLabel => 'App name';

  @override
  String get aboutPackageLabel => 'Package';

  @override
  String get aboutVersionLabel => 'Version';

  @override
  String get aboutBuildLabel => 'Build';

  @override
  String get aboutEnvironmentTitle => 'Environment';

  @override
  String get aboutEnvironmentLabel => 'Environment';

  @override
  String get aboutApiBaseUrlLabel => 'API base URL';

  @override
  String get aboutVerboseLogsLabel => 'Verbose logs';

  @override
  String get commonEnabled => 'Enabled';

  @override
  String get commonDisabled => 'Disabled';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get componentsTitle => 'Components';

  @override
  String get componentsSubtitle =>
      'Preview the template\'s reusable UI states and interaction components across platforms.';

  @override
  String get componentsStatesTitle => 'State views';

  @override
  String get componentsAsyncTitle => 'AsyncValue views';

  @override
  String get componentsAsyncData => 'Data';

  @override
  String get componentsAsyncReady => 'Data state is ready';

  @override
  String get componentsDialogsTitle => 'Confirm dialogs';

  @override
  String get componentsDialogsDescription =>
      'Use this for dangerous actions, exit prompts, deletion prompts, and other explicit choices.';

  @override
  String get componentsDialogTitle => 'Confirm action';

  @override
  String get componentsDialogMessage =>
      'This is a template confirm dialog. Feature code can replace the title, message, and labels.';

  @override
  String get componentsOpenDialog => 'Open dialog';

  @override
  String get stateRetry => 'Retry';

  @override
  String get stateLoading => 'Loading';

  @override
  String get stateEmptyTitle => 'Nothing here yet';

  @override
  String get stateEmptyMessage => 'There is no data to show right now.';

  @override
  String get stateErrorTitle => 'Something went wrong';

  @override
  String get stateErrorMessage =>
      'Try again later or check the current environment configuration.';
}

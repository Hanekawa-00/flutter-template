import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'Flutter Template'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get navHome;

  /// No description provided for @navSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get navSettings;

  /// No description provided for @navComponents.
  ///
  /// In zh, this message translates to:
  /// **'组件'**
  String get navComponents;

  /// No description provided for @navAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get navAbout;

  /// No description provided for @homeTitle.
  ///
  /// In zh, this message translates to:
  /// **'Flutter Template'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'跨平台应用模板，保留通用能力，业务功能从这里继续生长。'**
  String get homeSubtitle;

  /// No description provided for @openSettingsTooltip.
  ///
  /// In zh, this message translates to:
  /// **'打开设置'**
  String get openSettingsTooltip;

  /// No description provided for @homeStatusLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在加载设置'**
  String get homeStatusLoading;

  /// No description provided for @homeStatusReady.
  ///
  /// In zh, this message translates to:
  /// **'模板已就绪'**
  String get homeStatusReady;

  /// No description provided for @homeStatusDescription.
  ///
  /// In zh, this message translates to:
  /// **'这里刻意不放业务假数据，只展示模板当前已经具备的通用能力。'**
  String get homeStatusDescription;

  /// No description provided for @capabilityCrossPlatformTitle.
  ///
  /// In zh, this message translates to:
  /// **'跨平台基线'**
  String get capabilityCrossPlatformTitle;

  /// No description provided for @capabilityCrossPlatformDescription.
  ///
  /// In zh, this message translates to:
  /// **'Android、iOS、Web、Windows、macOS、Linux 平台目录已生成。'**
  String get capabilityCrossPlatformDescription;

  /// No description provided for @capabilityThemeTitle.
  ///
  /// In zh, this message translates to:
  /// **'主题系统'**
  String get capabilityThemeTitle;

  /// No description provided for @capabilityThemeDescription.
  ///
  /// In zh, this message translates to:
  /// **'支持系统/浅色/深色、种子色、OLED 深色和紧凑密度。'**
  String get capabilityThemeDescription;

  /// No description provided for @capabilityRoutingTitle.
  ///
  /// In zh, this message translates to:
  /// **'路由骨架'**
  String get capabilityRoutingTitle;

  /// No description provided for @capabilityRoutingDescription.
  ///
  /// In zh, this message translates to:
  /// **'go_router Shell 已接好，移动端底栏，宽屏侧边导航。'**
  String get capabilityRoutingDescription;

  /// No description provided for @capabilityExtensionTitle.
  ///
  /// In zh, this message translates to:
  /// **'扩展边界'**
  String get capabilityExtensionTitle;

  /// No description provided for @capabilityExtensionDescription.
  ///
  /// In zh, this message translates to:
  /// **'core、features、shared 分层，便于后续拆模块和接业务。'**
  String get capabilityExtensionDescription;

  /// No description provided for @nextStepsTitle.
  ///
  /// In zh, this message translates to:
  /// **'推荐下一步'**
  String get nextStepsTitle;

  /// No description provided for @nextStepFeature.
  ///
  /// In zh, this message translates to:
  /// **'把第一个业务页面放到 lib/src/features/<feature_name>'**
  String get nextStepFeature;

  /// No description provided for @nextStepRepository.
  ///
  /// In zh, this message translates to:
  /// **'为数据源新增 repository，并在 Riverpod provider 中注入'**
  String get nextStepRepository;

  /// No description provided for @nextStepDesktop.
  ///
  /// In zh, this message translates to:
  /// **'需要复杂桌面能力时，再按需引入窗口、托盘或热键插件'**
  String get nextStepDesktop;

  /// No description provided for @stateComponentsTitle.
  ///
  /// In zh, this message translates to:
  /// **'UI 状态组件'**
  String get stateComponentsTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'模板只保留通用偏好，后续业务设置可以继续按分组追加。'**
  String get settingsSubtitle;

  /// No description provided for @settingsAppearanceTitle.
  ///
  /// In zh, this message translates to:
  /// **'外观'**
  String get settingsAppearanceTitle;

  /// No description provided for @settingsThemeModeTitle.
  ///
  /// In zh, this message translates to:
  /// **'主题模式'**
  String get settingsThemeModeTitle;

  /// No description provided for @settingsThemeModeSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统、浅色或深色。'**
  String get settingsThemeModeSubtitle;

  /// No description provided for @themeModeSystem.
  ///
  /// In zh, this message translates to:
  /// **'系统'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In zh, this message translates to:
  /// **'浅色'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In zh, this message translates to:
  /// **'深色'**
  String get themeModeDark;

  /// No description provided for @settingsThemeColorTitle.
  ///
  /// In zh, this message translates to:
  /// **'主题色'**
  String get settingsThemeColorTitle;

  /// No description provided for @settingsThemeColorSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'Material 3 会用种子色生成完整配色。'**
  String get settingsThemeColorSubtitle;

  /// No description provided for @settingsExperienceTitle.
  ///
  /// In zh, this message translates to:
  /// **'体验'**
  String get settingsExperienceTitle;

  /// No description provided for @settingsPureBlackTitle.
  ///
  /// In zh, this message translates to:
  /// **'OLED 深色增强'**
  String get settingsPureBlackTitle;

  /// No description provided for @settingsPureBlackSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'深色模式下使用更纯的黑色 surface。'**
  String get settingsPureBlackSubtitle;

  /// No description provided for @settingsCompactDensityTitle.
  ///
  /// In zh, this message translates to:
  /// **'紧凑密度'**
  String get settingsCompactDensityTitle;

  /// No description provided for @settingsCompactDensitySubtitle.
  ///
  /// In zh, this message translates to:
  /// **'让桌面端和信息密集页面更克制。'**
  String get settingsCompactDensitySubtitle;

  /// No description provided for @settingsSaveFailed.
  ///
  /// In zh, this message translates to:
  /// **'设置保存失败：{error}'**
  String settingsSaveFailed(String error);

  /// No description provided for @aboutTitle.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'一个偏通用、可扩展、跨平台优先的 Flutter 模板。'**
  String get aboutSubtitle;

  /// No description provided for @aboutStructureTitle.
  ///
  /// In zh, this message translates to:
  /// **'项目结构'**
  String get aboutStructureTitle;

  /// No description provided for @aboutCoreLabel.
  ///
  /// In zh, this message translates to:
  /// **'core'**
  String get aboutCoreLabel;

  /// No description provided for @aboutCoreValue.
  ///
  /// In zh, this message translates to:
  /// **'路由、主题、设置等基础设施'**
  String get aboutCoreValue;

  /// No description provided for @aboutFeaturesLabel.
  ///
  /// In zh, this message translates to:
  /// **'features'**
  String get aboutFeaturesLabel;

  /// No description provided for @aboutFeaturesValue.
  ///
  /// In zh, this message translates to:
  /// **'按业务功能拆分页面与状态'**
  String get aboutFeaturesValue;

  /// No description provided for @aboutSharedLabel.
  ///
  /// In zh, this message translates to:
  /// **'shared'**
  String get aboutSharedLabel;

  /// No description provided for @aboutSharedValue.
  ///
  /// In zh, this message translates to:
  /// **'跨功能复用的通用组件'**
  String get aboutSharedValue;

  /// No description provided for @aboutVersionTitle.
  ///
  /// In zh, this message translates to:
  /// **'版本'**
  String get aboutVersionTitle;

  /// No description provided for @aboutAppNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'应用名'**
  String get aboutAppNameLabel;

  /// No description provided for @aboutPackageLabel.
  ///
  /// In zh, this message translates to:
  /// **'包名'**
  String get aboutPackageLabel;

  /// No description provided for @aboutVersionLabel.
  ///
  /// In zh, this message translates to:
  /// **'版本'**
  String get aboutVersionLabel;

  /// No description provided for @aboutBuildLabel.
  ///
  /// In zh, this message translates to:
  /// **'构建号'**
  String get aboutBuildLabel;

  /// No description provided for @aboutEnvironmentTitle.
  ///
  /// In zh, this message translates to:
  /// **'环境配置'**
  String get aboutEnvironmentTitle;

  /// No description provided for @aboutEnvironmentLabel.
  ///
  /// In zh, this message translates to:
  /// **'环境'**
  String get aboutEnvironmentLabel;

  /// No description provided for @aboutApiBaseUrlLabel.
  ///
  /// In zh, this message translates to:
  /// **'API 地址'**
  String get aboutApiBaseUrlLabel;

  /// No description provided for @aboutVerboseLogsLabel.
  ///
  /// In zh, this message translates to:
  /// **'详细日志'**
  String get aboutVerboseLogsLabel;

  /// No description provided for @commonEnabled.
  ///
  /// In zh, this message translates to:
  /// **'启用'**
  String get commonEnabled;

  /// No description provided for @commonDisabled.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get commonDisabled;

  /// No description provided for @commonConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get commonConfirm;

  /// No description provided for @commonCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get commonCancel;

  /// No description provided for @componentsTitle.
  ///
  /// In zh, this message translates to:
  /// **'组件'**
  String get componentsTitle;

  /// No description provided for @componentsSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'跨平台预览模板内置的通用 UI 状态和交互组件。'**
  String get componentsSubtitle;

  /// No description provided for @componentsStatesTitle.
  ///
  /// In zh, this message translates to:
  /// **'状态视图'**
  String get componentsStatesTitle;

  /// No description provided for @componentsAsyncTitle.
  ///
  /// In zh, this message translates to:
  /// **'AsyncValue 视图'**
  String get componentsAsyncTitle;

  /// No description provided for @componentsAsyncData.
  ///
  /// In zh, this message translates to:
  /// **'数据'**
  String get componentsAsyncData;

  /// No description provided for @componentsAsyncReady.
  ///
  /// In zh, this message translates to:
  /// **'数据状态已就绪'**
  String get componentsAsyncReady;

  /// No description provided for @componentsDialogsTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认弹窗'**
  String get componentsDialogsTitle;

  /// No description provided for @componentsDialogsDescription.
  ///
  /// In zh, this message translates to:
  /// **'用于危险操作、退出确认、删除确认等需要明确选择的场景。'**
  String get componentsDialogsDescription;

  /// No description provided for @componentsDialogTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认操作'**
  String get componentsDialogTitle;

  /// No description provided for @componentsDialogMessage.
  ///
  /// In zh, this message translates to:
  /// **'这是一个模板确认弹窗，业务侧可以替换标题、正文和按钮。'**
  String get componentsDialogMessage;

  /// No description provided for @componentsOpenDialog.
  ///
  /// In zh, this message translates to:
  /// **'打开弹窗'**
  String get componentsOpenDialog;

  /// No description provided for @stateRetry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get stateRetry;

  /// No description provided for @stateLoading.
  ///
  /// In zh, this message translates to:
  /// **'正在加载'**
  String get stateLoading;

  /// No description provided for @stateEmptyTitle.
  ///
  /// In zh, this message translates to:
  /// **'暂无内容'**
  String get stateEmptyTitle;

  /// No description provided for @stateEmptyMessage.
  ///
  /// In zh, this message translates to:
  /// **'这里还没有可以展示的数据。'**
  String get stateEmptyMessage;

  /// No description provided for @stateErrorTitle.
  ///
  /// In zh, this message translates to:
  /// **'出了点问题'**
  String get stateErrorTitle;

  /// No description provided for @stateErrorMessage.
  ///
  /// In zh, this message translates to:
  /// **'请稍后重试，或检查当前环境配置。'**
  String get stateErrorMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

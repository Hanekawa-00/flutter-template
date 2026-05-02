// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Flutter Template';

  @override
  String get navHome => '首页';

  @override
  String get navSettings => '设置';

  @override
  String get navComponents => '组件';

  @override
  String get navAbout => '关于';

  @override
  String get navCollapseSidebar => '折叠侧边栏';

  @override
  String get navExpandSidebar => '展开侧边栏';

  @override
  String get homeTitle => 'Flutter Template';

  @override
  String get homeSubtitle => '跨平台应用模板，保留通用能力，业务功能从这里继续生长。';

  @override
  String get openSettingsTooltip => '打开设置';

  @override
  String get homeStatusLoading => '正在加载设置';

  @override
  String get homeStatusReady => '模板已就绪';

  @override
  String get homeStatusDescription => '这里刻意不放业务假数据，只展示模板当前已经具备的通用能力。';

  @override
  String get capabilityCrossPlatformTitle => '跨平台基线';

  @override
  String get capabilityCrossPlatformDescription =>
      'Android、iOS、Web、Windows、macOS、Linux 平台目录已生成。';

  @override
  String get capabilityThemeTitle => '主题系统';

  @override
  String get capabilityThemeDescription => '支持系统/浅色/深色、种子色、OLED 深色和紧凑密度。';

  @override
  String get capabilityRoutingTitle => '路由骨架';

  @override
  String get capabilityRoutingDescription =>
      'go_router Shell 已接好，移动端底栏，宽屏侧边导航。';

  @override
  String get capabilityExtensionTitle => '扩展边界';

  @override
  String get capabilityExtensionDescription =>
      'core、features、shared 分层，便于后续拆模块和接业务。';

  @override
  String get nextStepsTitle => '推荐下一步';

  @override
  String get nextStepFeature => '把第一个业务页面放到 lib/src/features/<feature_name>';

  @override
  String get nextStepRepository => '为数据源新增 repository，并在 Riverpod provider 中注入';

  @override
  String get nextStepDesktop => '需要复杂桌面能力时，再按需引入窗口、托盘或热键插件';

  @override
  String get stateComponentsTitle => 'UI 状态组件';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSubtitle => '模板只保留通用偏好，后续业务设置可以继续按分组追加。';

  @override
  String get settingsAppearanceTitle => '外观';

  @override
  String get settingsThemeModeTitle => '主题模式';

  @override
  String get settingsThemeModeSubtitle => '跟随系统、浅色或深色。';

  @override
  String get themeModeSystem => '系统';

  @override
  String get themeModeLight => '浅色';

  @override
  String get themeModeDark => '深色';

  @override
  String get settingsThemeColorTitle => '主题色';

  @override
  String get settingsThemeColorSubtitle => 'Material 3 会用种子色生成完整配色。';

  @override
  String get settingsExperienceTitle => '体验';

  @override
  String get settingsPureBlackTitle => 'OLED 深色增强';

  @override
  String get settingsPureBlackSubtitle => '深色模式下使用更纯的黑色 surface。';

  @override
  String get settingsCompactDensityTitle => '紧凑密度';

  @override
  String get settingsCompactDensitySubtitle => '让桌面端和信息密集页面更克制。';

  @override
  String get settingsOtherTitle => '其他';

  @override
  String get settingsResetAction => '重置';

  @override
  String get settingsResetTitle => '重置偏好设置';

  @override
  String get settingsResetMessage => '主题、颜色和体验选项会恢复为模板默认值。';

  @override
  String get settingsResetConfirm => '重置';

  @override
  String get settingsResetSuccess => '偏好设置已重置';

  @override
  String settingsSaveFailed(String error) {
    return '设置保存失败：$error';
  }

  @override
  String get aboutTitle => '关于';

  @override
  String get aboutSubtitle => '一个偏通用、可扩展、跨平台优先的 Flutter 模板。';

  @override
  String get aboutBackToSettings => '返回设置';

  @override
  String get aboutStructureTitle => '项目结构';

  @override
  String get aboutCoreLabel => 'core';

  @override
  String get aboutCoreValue => '路由、主题、设置等基础设施';

  @override
  String get aboutFeaturesLabel => 'features';

  @override
  String get aboutFeaturesValue => '按业务功能拆分页面与状态';

  @override
  String get aboutSharedLabel => 'shared';

  @override
  String get aboutSharedValue => '跨功能复用的通用组件';

  @override
  String get aboutVersionTitle => '版本';

  @override
  String get aboutAppNameLabel => '应用名';

  @override
  String get aboutPackageLabel => '包名';

  @override
  String get aboutVersionLabel => '版本';

  @override
  String get aboutBuildLabel => '构建号';

  @override
  String get aboutEnvironmentTitle => '环境配置';

  @override
  String get aboutEnvironmentLabel => '环境';

  @override
  String get aboutApiBaseUrlLabel => 'API 地址';

  @override
  String get aboutVerboseLogsLabel => '详细日志';

  @override
  String get commonEnabled => '启用';

  @override
  String get commonDisabled => '关闭';

  @override
  String get commonConfirm => '确认';

  @override
  String get commonCancel => '取消';

  @override
  String get commandPaletteSearchHint => '搜索页面或操作';

  @override
  String get commandPaletteNoResults => '没有匹配的操作';

  @override
  String get commandPaletteExecuted => '已执行操作';

  @override
  String get commandGoHome => '前往首页';

  @override
  String get commandGoSettings => '前往设置';

  @override
  String get commandGoComponents => '前往组件';

  @override
  String get commandGoAbout => '前往关于';

  @override
  String get componentsTitle => '组件';

  @override
  String get componentsSubtitle => '跨平台预览模板内置的通用 UI 状态和交互组件。';

  @override
  String get componentsStatesTitle => '状态视图';

  @override
  String get componentsAsyncTitle => 'AsyncValue 视图';

  @override
  String get componentsAsyncData => '数据';

  @override
  String get componentsAsyncReady => '数据状态已就绪';

  @override
  String get componentsDialogsTitle => '确认弹窗';

  @override
  String get componentsDialogsDescription => '用于危险操作、退出确认、删除确认等需要明确选择的场景。';

  @override
  String get componentsDialogTitle => '确认操作';

  @override
  String get componentsDialogMessage => '这是一个模板确认弹窗，业务侧可以替换标题、正文和按钮。';

  @override
  String get componentsOpenDialog => '打开弹窗';

  @override
  String get componentsFeedbackTitle => '反馈提示';

  @override
  String get componentsFeedbackDescription =>
      '用于保存成功、轻量提醒和错误提示，默认走全局 ScaffoldMessenger。';

  @override
  String get componentsShowSuccess => '成功提示';

  @override
  String get componentsShowError => '错误提示';

  @override
  String get componentsSuccessToast => '操作已完成';

  @override
  String get componentsErrorToast => '操作失败，请稍后重试';

  @override
  String get componentsStyleTitle => '控件样式';

  @override
  String get componentsStyleDescription => '按钮、输入框和选择器使用统一 token，便于业务组件保持一致。';

  @override
  String get componentsPrimaryButton => '主要';

  @override
  String get componentsTonalButton => '次要';

  @override
  String get componentsOutlineButton => '描边';

  @override
  String get componentsSearchLabel => '搜索';

  @override
  String get componentsCompactChoice => '紧凑';

  @override
  String get componentsComfortChoice => '舒适';

  @override
  String get stateRetry => '重试';

  @override
  String get stateLoading => '正在加载';

  @override
  String get stateEmptyTitle => '暂无内容';

  @override
  String get stateEmptyMessage => '这里还没有可以展示的数据。';

  @override
  String get stateErrorTitle => '出了点问题';

  @override
  String get stateErrorMessage => '请稍后重试，或检查当前环境配置。';
}

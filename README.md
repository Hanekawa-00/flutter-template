# Flutter Template

[![CI](https://github.com/Hanekawa-00/flutter-template/actions/workflows/ci.yml/badge.svg)](https://github.com/Hanekawa-00/flutter-template/actions/workflows/ci.yml)

一个偏通用、可扩展、跨平台优先的 Flutter 应用模板。它不包含具体业务功能，重点提供应用开发早期最容易反复搭建的基础能力：主题、路由、设置、状态组件、本地存储、缓存、网络、桌面窗口、移动端返回体验、测试和构建流程。

## 特性

- Material 3 主题系统：系统/浅色/深色、主题色预设、OLED 深色增强、紧凑密度。
- 跨平台导航骨架：`go_router` + `StatefulShellRoute.indexedStack`，保留页面状态和滚动位置。
- 移动端体验：固定标题栏、一级页面底部导航、子页面隐藏底部导航、双击返回退出提示。
- 桌面端体验：自定义 Windows/Linux 标题栏、圆角窗口、窗口拖拽、缩放、侧边栏折叠。
- Riverpod 依赖注入和状态管理入口。
- `--dart-define` 和固定入口文件两种环境切换方式。
- `shared_preferences` 设置持久化。
- Dio 网络客户端、错误映射和 repository 约定。
- Hive CE 本地数据库入口和带 TTL 的 JSON 缓存层。
- Flutter gen-l10n 中英文国际化基础设施。
- 加载、空状态、错误状态、确认弹窗、消息反馈等通用 UI 组件。
- 功能模块脚手架：`dart run scripts/new_feature.dart <feature_name>`。
- GitHub Actions CI、本地检查脚本、Web release 构建检查。
- 项目专用 Skill：`skills/flutter-template-agent-guide`。

## 平台

| Platform | Status |
| --- | --- |
| Android | Supported |
| iOS | Project generated |
| Web | Supported |
| Windows | Supported with custom chrome |
| macOS | Project generated |
| Linux | Supported with custom chrome |

## 快速开始

```bash
flutter pub get
flutter run
```

指定环境：

```bash
flutter run --dart-define=APP_ENV=staging
flutter run --dart-define=APP_ENV=production --dart-define=APP_NAME=MyApp
```

也可以使用固定入口：

```bash
flutter run -t lib/main_development.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_production.dart
```

Windows 上使用插件时需要开启 Developer Mode，否则 Flutter 可能无法创建插件 symlink。

## 项目结构

```text
lib/
  main.dart
  main_development.dart
  main_staging.dart
  main_production.dart
  src/
    app/              # 应用启动、ProviderScope、MaterialApp
    core/             # 配置、日志、异常、i18n、网络、存储、缓存、路由、主题、设置
    data/             # repository 约定与共享数据访问
    features/         # 首页、设置、关于、组件展示和后续业务模块
    shared/           # 可复用 UI 组件与 UI 服务
scripts/              # 检查脚本和功能模块生成器
skills/               # 项目专用开发 Skill
test/                 # 单元测试和 widget 测试
```

## 新增功能模块

```bash
dart run scripts/new_feature.dart profile
```

生成后通常需要：

1. 在 `lib/src/core/routing/app_router.dart` 注册路由。
2. 如果是一级功能，在 `AppShell` 中添加导航项。
3. 将共享 API/cache/persistence 逻辑放入 `lib/src/data/repositories/`。
4. 为路由、响应式布局或 provider 行为补充测试。

## 常用命令

格式化、分析和测试：

```bash
dart format lib test scripts
flutter analyze
flutter test
```

本地完整检查：

```bash
pwsh ./scripts/check.ps1
# or
bash ./scripts/check.sh
```

生成本地化代码：

```bash
flutter gen-l10n
```

常见 release 构建：

```bash
flutter build web --release -t lib/main_production.dart
flutter build windows --release -t lib/main_production.dart
flutter build apk --release --split-per-abi -t lib/main_production.dart
```

发布 Release：

```bash
git tag v0.1.0
git push origin v0.1.0
```

推送 `v*` tag 后，GitHub Actions 会构建 Web、Windows x64 和 Android split ABI APK，并把产物上传到 GitHub Release。

## 缓存示例

```dart
final cache = await ref.read(jsonCacheStoreProvider.future);

await cache.put(
  'profile',
  {'name': 'Flutter Template'},
  ttl: const Duration(hours: 1),
);

final profile = await cache.getValue('profile');
```

## 文档

- `AGENTS.md`：面向 AI agent 和人类开发者的协作规范。
- `docs/agent_development.md`：常见开发任务和注意事项。
- `docs/architecture.md`：分层、路由、状态、数据和错误处理约定。
- `docs/design_system.md`：设计系统、页面布局和响应式规则。
- `docs/new_feature.md`：新增功能流程。
- `docs/release.md`：环境入口和构建命令。
- `skills/flutter-template-agent-guide`：项目专用 Skill。

## 贡献建议

- 使用 feature branch 开发。
- 提交前运行 `flutter analyze` 和 `flutter test`。
- UI 改动需要同时考虑移动端和桌面端。
- 路由改动需要确认页面状态保留和返回行为。
- 不要把具体业务假数据写进模板首页，除非目标是演示模板能力。

## License

当前仓库尚未声明开源许可证。公开分发或接受外部贡献前，建议补充 `LICENSE` 文件。

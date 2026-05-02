# Flutter Template

一个跨平台 Flutter 应用模板，当前只包含通用能力：

- Material 3 主题系统：系统/浅色/深色、种子色、OLED 深色增强、紧凑密度
- go_router 路由骨架：移动端底部导航，宽屏 NavigationRail
- Riverpod 状态入口：设置控制器和依赖注入示例
- shared_preferences 设置持久化
- `--dart-define` 环境配置：`development`、`staging`、`production`
- 全局日志与异常入口
- Dio 网络客户端、错误映射和 repository 约定
- Hive CE 本地数据库入口和带 TTL 的 JSON 缓存层
- Flutter gen-l10n 中英文国际化基础设施
- 加载、空状态、错误状态、确认弹窗等通用 UI 组件
- GitHub Actions CI 与本地质量检查脚本
- 固定环境入口：`main_development.dart`、`main_staging.dart`、`main_production.dart`
- 功能模块脚手架：`dart run scripts/new_feature.dart <feature_name>`
- `core`、`features`、`shared` 分层目录

## 结构

```text
lib/
  main.dart
  src/
    app/              # 应用启动与 MaterialApp
    core/             # 配置、日志、异常、i18n、网络、存储、缓存、路由、主题、设置
    data/             # repository 约定与数据源入口
    features/         # 首页、设置、关于等功能入口
    shared/widgets/   # 可复用 UI 组件
```

## 运行

```bash
flutter pub get
flutter run
```

切换环境：

```bash
flutter run --dart-define=APP_ENV=staging
flutter run --dart-define=APP_ENV=production --dart-define=APP_NAME=MyApp
flutter run -t lib/main_staging.dart
```

新增功能模块：

```bash
dart run scripts/new_feature.dart profile
```

更多约定见：

- `docs/architecture.md`
- `docs/design_system.md`
- `docs/new_feature.md`
- `docs/release.md`

缓存使用示例：

```dart
final cache = await ref.read(jsonCacheStoreProvider.future);

await cache.put(
  'profile',
  {'name': 'Flutter Template'},
  ttl: const Duration(hours: 1),
);

final profile = await cache.getValue('profile');
```

运行质量检查：

```bash
pwsh ./scripts/check.ps1
# or
bash ./scripts/check.sh
```

生成本地化代码：

```bash
flutter gen-l10n
```

Windows 上使用插件时需要开启 Developer Mode，否则 Flutter 可能无法创建插件
symlink。

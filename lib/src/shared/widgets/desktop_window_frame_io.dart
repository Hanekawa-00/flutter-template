import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../core/platform/app_platform.dart';
import '../../core/localization/localization_extensions.dart';
import '../../core/theme/app_design_tokens.dart';

class DesktopWindowFrame extends StatefulWidget {
  const DesktopWindowFrame({super.key, required this.child});

  final Widget child;

  @override
  State<DesktopWindowFrame> createState() => _DesktopWindowFrameState();
}

class _DesktopWindowFrameState extends State<DesktopWindowFrame>
    with WindowListener {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    if (AppPlatform.usesCustomWindowChrome) {
      windowManager.addListener(this);
      _syncMaximizedState();
    }
  }

  @override
  void dispose() {
    if (AppPlatform.usesCustomWindowChrome) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    setState(() => _isMaximized = true);
  }

  @override
  void onWindowUnmaximize() {
    setState(() => _isMaximized = false);
  }

  Future<void> _syncMaximizedState() async {
    final isMaximized = await windowManager.isMaximized();
    if (mounted) {
      setState(() => _isMaximized = isMaximized);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!AppPlatform.usesCustomWindowChrome) {
      return widget.child;
    }

    final scheme = Theme.of(context).colorScheme;
    final radii = Theme.of(context).radii;
    final radius = _isMaximized ? 0.0 : radii.lg;
    final content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: scheme.surface,
        child: DecoratedBox(
          decoration: BoxDecoration(color: scheme.surface),
          child: Column(
            children: [
              _DesktopTitleBar(isMaximized: _isMaximized),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ),
    );

    if (_isMaximized) {
      return content;
    }

    return DragToResizeArea(
      resizeEdgeSize: 6,
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(padding: const EdgeInsets.all(1), child: content),
      ),
    );
  }
}

class _DesktopTitleBar extends StatelessWidget {
  const _DesktopTitleBar({required this.isMaximized});

  final bool isMaximized;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      color: scheme.surface,
      child: Stack(
        children: [
          Positioned.fill(
            right: 156,
            child: DragToMoveArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.layers_rounded,
                          color: scheme.onPrimaryContainer,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.l10n.appTitle,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 156,
            child: ColoredBox(
              color: scheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _WindowButton(
                      icon: Icons.remove_rounded,
                      onPressed: windowManager.minimize,
                    ),
                    _WindowButton(
                      icon: isMaximized
                          ? Icons.filter_none_rounded
                          : Icons.crop_square_rounded,
                      onPressed: () async {
                        if (await windowManager.isMaximized()) {
                          await windowManager.unmaximize();
                        } else {
                          await windowManager.maximize();
                        }
                      },
                    ),
                    _WindowButton(
                      icon: Icons.close_rounded,
                      danger: true,
                      onPressed: windowManager.close,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowButton extends StatefulWidget {
  const _WindowButton({
    required this.icon,
    required this.onPressed,
    this.danger = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool danger;

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = widget.danger && _hovered
        ? scheme.errorContainer
        : _hovered
        ? scheme.surfaceContainerHigh
        : Colors.transparent;
    final foreground = widget.danger && _hovered
        ? scheme.onErrorContainer
        : scheme.onSurfaceVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: 40,
            height: 34,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(widget.icon, size: 18, color: foreground),
            ),
          ),
        ),
      ),
    );
  }
}

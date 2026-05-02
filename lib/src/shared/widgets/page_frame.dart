import 'package:flutter/material.dart';

import '../../core/theme/app_design_tokens.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final compact = MediaQuery.sizeOf(context).width < 760;

    return SafeArea(
      top: !compact,
      bottom: false,
      child: CustomScrollView(
        slivers: [
          if (!compact)
            SliverPersistentHeader(
              pinned: true,
              delegate: _PageHeaderDelegate(
                title: title,
                subtitle: subtitle,
                trailing: trailing,
              ),
            ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              compact ? spacing.lg : spacing.xl,
              compact ? spacing.lg : spacing.sm,
              compact ? spacing.lg : spacing.xl,
              spacing.xxl,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) => children[index],
              separatorBuilder: (context, index) =>
                  SizedBox(height: spacing.lg),
              itemCount: children.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _PageHeaderDelegate({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  double get minExtent => 96;

  @override
  double get maxExtent => subtitle == null ? 104 : 144;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final spacing = theme.spacing;
    final scheme = theme.colorScheme;
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.96),
        border: Border(
          bottom: BorderSide(
            color: overlapsContent
                ? scheme.outlineVariant.withValues(alpha: 0.36)
                : Colors.transparent,
          ),
        ),
      ),
      child: ClipRect(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.xl,
            spacing.lg,
            spacing.xl,
            spacing.md,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _PageHeader(
              title: title,
              subtitle: progress > 0.45 ? null : subtitle,
              trailing: trailing,
              dense: progress > 0.18,
              maxHeight: minExtent - spacing.lg - spacing.md,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PageHeaderDelegate oldDelegate) {
    return title != oldDelegate.title ||
        subtitle != oldDelegate.subtitle ||
        trailing != oldDelegate.trailing;
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.title,
    this.subtitle,
    this.trailing,
    this.dense = false,
    this.maxHeight,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool dense;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final spacing = theme.spacing;

    return SizedBox(
      height: maxHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      (dense ? textTheme.titleLarge : textTheme.headlineMedium)
                          ?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: spacing.sm),
                  Flexible(
                    child: Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[SizedBox(width: spacing.lg), trailing!],
        ],
      ),
    );
  }
}

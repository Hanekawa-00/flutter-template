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

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              spacing.xl,
              spacing.xl,
              spacing.xl,
              spacing.sm,
            ),
            sliver: SliverToBoxAdapter(
              child: _PageHeader(
                title: title,
                subtitle: subtitle,
                trailing: trailing,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              spacing.xl,
              spacing.sm,
              spacing.xl,
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

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, this.subtitle, this.trailing});

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final spacing = theme.spacing;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: spacing.sm),
                Text(
                  subtitle!,
                  style: textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: spacing.lg), trailing!],
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/theme/app_design_tokens.dart';

class AppMessenger {
  const AppMessenger._();

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, icon: Icons.check_circle_outline);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message: message, icon: Icons.info_outline);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message: message, icon: Icons.error_outline, isError: true);
  }

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    bool isError = false,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final messenger =
        ScaffoldMessenger.maybeOf(context) ?? scaffoldMessengerKey.currentState;

    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          backgroundColor: isError
              ? scheme.errorContainer
              : scheme.inverseSurface,
          closeIconColor: isError
              ? scheme.onErrorContainer
              : scheme.onInverseSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radii.md),
          ),
          content: Row(
            children: [
              Icon(
                icon,
                color: isError
                    ? scheme.onErrorContainer
                    : scheme.onInverseSurface,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: isError
                        ? scheme.onErrorContainer
                        : scheme.onInverseSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

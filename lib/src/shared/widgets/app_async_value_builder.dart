import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state_views.dart';

class AppAsyncValueBuilder<T> extends StatelessWidget {
  const AppAsyncValueBuilder({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.error,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) data;
  final WidgetBuilder? loading;
  final Widget Function(BuildContext context, Object error, StackTrace stack)?
  error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.map(
      data: (value) => data(context, value.value),
      error: (value) {
        return error?.call(context, value.error, value.stackTrace) ??
            AppErrorView(onRetry: onRetry);
      },
      loading: (_) {
        return loading?.call(context) ?? const AppLoadingView();
      },
    );
  }
}

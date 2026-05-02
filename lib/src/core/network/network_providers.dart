import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/config_providers.dart';
import '../logging/logging_providers.dart';
import 'api_client.dart';
import 'dio_factory.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final logger = ref.watch(appLoggerProvider);

  return DioFactory(config: config, logger: logger).create();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});

import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../logging/app_logger.dart';

class DioFactory {
  const DioFactory({required this.config, required this.logger});

  final AppConfig config;
  final AppLogger logger;

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: const Duration(seconds: 12),
        sendTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(_ApiLogInterceptor(logger));

    return dio;
  }
}

class _ApiLogInterceptor extends Interceptor {
  _ApiLogInterceptor(this._logger);

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('${options.method} ${options.uri}', name: 'network');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.debug(
      '${response.requestOptions.method} ${response.requestOptions.uri} '
      '-> ${response.statusCode}',
      name: 'network',
    );
    handler.next(response);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    _logger.warning(
      '${error.requestOptions.method} ${error.requestOptions.uri} failed',
      name: 'network',
      error: error,
      stackTrace: error.stackTrace,
    );
    handler.next(error);
  }
}

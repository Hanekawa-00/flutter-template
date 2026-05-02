import 'package:dio/dio.dart';
import 'package:flutter_template/src/core/network/api_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiException', () {
    test('maps timeout errors', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/health'),
        type: DioExceptionType.connectionTimeout,
      );

      final result = ApiException.fromDioException(exception);

      expect(result.type, ApiErrorType.timeout);
      expect(result.statusCode, isNull);
    });

    test('uses response message when available', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/health'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/health'),
          statusCode: 503,
          data: {'message': 'Service unavailable'},
        ),
      );

      final result = ApiException.fromDioException(exception);

      expect(result.type, ApiErrorType.badResponse);
      expect(result.statusCode, 503);
      expect(result.message, 'Service unavailable');
    });
  });
}

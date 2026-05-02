import 'package:dio/dio.dart';

import 'api_exception.dart';

class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Object? data)? decode,
  }) {
    return _request(
      () => _dio.get<Object?>(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
      decode: decode,
    );
  }

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Object? data)? decode,
  }) {
    return _request(
      () => _dio.post<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decode: decode,
    );
  }

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(Object? data)? decode,
  }) {
    return _request(
      () => _dio.put<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decode: decode,
    );
  }

  Future<void> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _request<void>(
      () => _dio.delete<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      decode: (_) {},
    );
  }

  Future<T> _request<T>(
    Future<Response<Object?>> Function() request, {
    T Function(Object? data)? decode,
  }) async {
    try {
      final response = await request();
      final parser = decode ?? (data) => data as T;
      return parser(response.data);
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(
        type: ApiErrorType.unknown,
        message: 'Failed to decode response.',
        cause: error,
      );
    }
  }
}

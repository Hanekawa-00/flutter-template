import 'package:dio/dio.dart';

enum ApiErrorType {
  cancelled,
  connection,
  timeout,
  badResponse,
  badCertificate,
  unknown,
}

class ApiException implements Exception {
  const ApiException({
    required this.type,
    required this.message,
    this.statusCode,
    this.cause,
  });

  final ApiErrorType type;
  final String message;
  final int? statusCode;
  final Object? cause;

  factory ApiException.fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.cancel => ApiException(
        type: ApiErrorType.cancelled,
        message: 'Request was cancelled.',
        cause: exception,
      ),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => ApiException(
        type: ApiErrorType.timeout,
        message: 'Request timed out.',
        cause: exception,
      ),
      DioExceptionType.badCertificate => ApiException(
        type: ApiErrorType.badCertificate,
        message: 'Bad certificate.',
        cause: exception,
      ),
      DioExceptionType.badResponse => ApiException(
        type: ApiErrorType.badResponse,
        message: _messageFromResponse(exception.response),
        statusCode: exception.response?.statusCode,
        cause: exception,
      ),
      DioExceptionType.connectionError => ApiException(
        type: ApiErrorType.connection,
        message: 'Network connection failed.',
        cause: exception,
      ),
      DioExceptionType.unknown => ApiException(
        type: ApiErrorType.unknown,
        message: exception.message ?? 'Unknown network error.',
        cause: exception,
      ),
    };
  }

  static String _messageFromResponse(Response<dynamic>? response) {
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
    }

    return 'Server responded with status ${response?.statusCode ?? 'unknown'}.';
  }

  @override
  String toString() {
    final code = statusCode == null ? '' : ' ($statusCode)';
    return 'ApiException$type$code: $message';
  }
}

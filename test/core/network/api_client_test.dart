import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/src/core/network/api_client.dart';
import 'package:flutter_template/src/core/network/api_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiClient', () {
    test('decodes successful responses', () async {
      final dio = Dio()
        ..httpClientAdapter = _FakeAdapter(
          responseData: {'ok': true},
          statusCode: 200,
        );
      final client = ApiClient(dio);

      final result = await client.get<bool>(
        '/health',
        decode: (data) => (data as Map<String, dynamic>)['ok'] as bool,
      );

      expect(result, isTrue);
    });

    test('wraps bad responses as ApiException', () async {
      final dio = Dio()
        ..httpClientAdapter = _FakeAdapter(
          responseData: {'message': 'Nope'},
          statusCode: 500,
        );
      final client = ApiClient(dio);

      final call = client.get<Map<String, dynamic>>('/health');

      await expectLater(
        call,
        throwsA(
          isA<ApiException>()
              .having((error) => error.type, 'type', ApiErrorType.badResponse)
              .having((error) => error.statusCode, 'statusCode', 500),
        ),
      );
    });
  });
}

class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter({required this.responseData, required this.statusCode});

  final Object? responseData;
  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(responseData),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

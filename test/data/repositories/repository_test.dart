import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/src/data/repositories/repository.dart';

void main() {
  test('BaseRepository.guard returns success data', () async {
    final repository = _TestRepository();

    final result = await repository.loadValue();

    expect(result, isA<RepositorySuccess<int>>());
    expect(result.when(success: (data) => data, failure: (_) => -1), 42);
  });

  test('BaseRepository.guard captures failures', () async {
    final repository = _TestRepository();

    final result = await repository.loadFailure();

    expect(result, isA<RepositoryFailure<int>>());
    expect(
      result.when(success: (_) => '', failure: (failure) => failure.message),
      'Failed to load value.',
    );
  });
}

final class _TestRepository extends BaseRepository {
  @override
  String get name => 'test';

  Future<RepositoryResult<int>> loadValue() {
    return guard(() async => 42);
  }

  Future<RepositoryResult<int>> loadFailure() {
    return guard<int>(
      () async => throw StateError('No value'),
      failureMessage: 'Failed to load value.',
    );
  }
}

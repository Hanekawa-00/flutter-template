abstract interface class Repository {
  String get name;
}

typedef RepositoryDecoder<T> = T Function(Object? data);

sealed class RepositoryResult<T> {
  const RepositoryResult();

  bool get isSuccess => this is RepositorySuccess<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(RepositoryFailure<T> failure) failure,
  }) {
    final result = this;

    return switch (result) {
      RepositorySuccess<T>(:final data) => success(data),
      RepositoryFailure<T>() => failure(result),
    };
  }
}

final class RepositorySuccess<T> extends RepositoryResult<T> {
  const RepositorySuccess(this.data);

  final T data;
}

final class RepositoryFailure<T> extends RepositoryResult<T> {
  const RepositoryFailure({
    required this.message,
    required this.error,
    this.stackTrace,
    this.canRetry = true,
  });

  final String message;
  final Object error;
  final StackTrace? stackTrace;
  final bool canRetry;
}

abstract base class BaseRepository implements Repository {
  const BaseRepository();

  Future<RepositoryResult<T>> guard<T>(
    Future<T> Function() action, {
    String failureMessage = 'Repository request failed.',
    bool canRetry = true,
  }) async {
    try {
      return RepositorySuccess(await action());
    } catch (error, stackTrace) {
      return RepositoryFailure<T>(
        message: failureMessage,
        error: error,
        stackTrace: stackTrace,
        canRetry: canRetry,
      );
    }
  }
}

/// {@template api_client_error}
/// Error throw when accessing api failed.
///
/// Check [cause] and [stackTrace] for specific details.
/// {@endtemplate}
class ApiClientError implements Exception {
  /// {@macro api_client_error}
  ApiClientError(this.cause, this.stackTrace);

  /// Error cause.
  final dynamic cause;

  /// The stack trace of the error.
  final StackTrace stackTrace;

  @override
  String toString() {
    return '''
cause: $cause
stackTrace: $stackTrace
''';
  }
}


class NetworkException implements Exception {
  NetworkException(this.cause);
  final String cause;
}

class ServerException implements Exception {
  ServerException(this.cause);
  final String cause;
}

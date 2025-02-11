class DbClientException implements Exception {
  DbClientException(this.cause);
  final String cause;
}

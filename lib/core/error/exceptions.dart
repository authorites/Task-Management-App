class ServerException implements Exception {}

class NetworkHttpException implements Exception {}

class NoInternetException implements Exception {}

class CacheException implements Exception {}

class UnknownException implements Exception {
  UnknownException([this.message = 'unknown error']);

  final dynamic message;
}

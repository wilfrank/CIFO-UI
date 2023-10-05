class ServerException implements Exception {
  final String message;
  final int errorCode;

  ServerException({required this.message, required this.errorCode});
}

class TokenException implements Exception {}

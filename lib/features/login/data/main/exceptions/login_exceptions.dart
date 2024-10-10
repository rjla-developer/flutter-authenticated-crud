class WrongCredentialsException implements Exception {}

class InvalidTokenException implements Exception {}

class ConnectionTimeoutException implements Exception {}

class CustomErrorException implements Exception {
  final String message;
  final int errorCode;

  CustomErrorException({required this.message, required this.errorCode});
}

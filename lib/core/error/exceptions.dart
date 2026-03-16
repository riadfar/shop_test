import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  
  const AppException(this.message, [this.statusCode]);
  
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  final DioExceptionType? dioType;
  
  const NetworkException(
    String message, {
    int? statusCode, 
    this.dioType,
  }) : super(message, statusCode);
  
  factory NetworkException.fromDioError(DioException error) {
    return NetworkException(
      _getErrorMessage(error),
      statusCode: error.response?.statusCode,
      dioType: error.type,
    );
  }
  
  static String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timeout. Server took too long to respond.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badCertificate:
        return 'Bad certificate. Connection is not secure.';
      case DioExceptionType.unknown:
        return error.message ?? 'An unexpected error occurred';
    }
  }
  
  static String _handleBadResponse(int? statusCode) {
    switch (statusCode) {
      case 400: return 'Bad request. Please check your input.';
      case 401: return 'Unauthorized. Please login again.';
      case 403: return 'Forbidden. You don\'t have permission.';
      case 404: return 'Resource not found.';
      case 500: return 'Internal server error. Please try again later.';
      case 502: return 'Bad gateway.';
      case 503: return 'Service unavailable. Please try again later.';
      default: return 'Something went wrong. Status code: $statusCode';
    }
  }
}

class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message);
}

class AuthorizationException extends AppException {
  const AuthorizationException(super.message);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

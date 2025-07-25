import 'package:dio/dio.dart';
import 'dart:io';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please try again.';
        case DioExceptionType.sendTimeout:
          return 'Request timeout. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Response timeout. Please try again.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) return 'Unauthorized. Please login again.';
          if (statusCode == 404) return 'Resource not found.';
          if (statusCode == 500) return 'Server error. Please try later.';
          return 'Received invalid status code: $statusCode';
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.unknown:
        default:
          return 'Network error. Please check your connection.';
      }
    } else if (error is SocketException) {
      return 'No Internet connection.';
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unknown error occurred.';
    }
  }
}

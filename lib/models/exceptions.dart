import 'package:dio/dio.dart';
import '../models/exceptions.dart';
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}


void handleDioExceptions(DioException e) {
  print('DioException: ${e.type}, Status Code: ${e.response?.statusCode}, Data: ${e.response?.data}');

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServerException(
        message: 'A connection error occurred. Please check your network.',
        statusCode: e.response?.statusCode,
      );

    case DioExceptionType.badResponse:
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final data = e.response!.data;
        throw ServerException(
          message: data?['message'] ?? 'An unexpected error occurred.',
          statusCode: statusCode,
        );
      } else {
        throw ServerException(
          message: 'No response received from the server.',
        );
      }
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

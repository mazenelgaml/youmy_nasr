import 'package:dio/dio.dart';
import '../models/exceptions.dart'; // Import your custom exception models
import 'api_consumer.dart';
import 'api_interceptor.dart';
import 'end_points.dart'; // Base URL and endpoints

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl; // Set base URL
    dio.interceptors.add(ApiInterceptor()); // Add custom headers globally via interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
        Map<String, dynamic>? headers, // Additional headers
      }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers), // Pass headers
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e); // Handle Dio-specific exceptions
    }
  }

  @override
  Future get(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers, // Additional headers
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers), // Pass headers
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
        Map<String, dynamic>? headers, // Additional headers
      }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers), // Pass headers
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFromData = false,
        Map<String, dynamic>? headers, // Additional headers
      }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers), // Pass headers
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}

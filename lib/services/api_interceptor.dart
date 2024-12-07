import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add headers
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}

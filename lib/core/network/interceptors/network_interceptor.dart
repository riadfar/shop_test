import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('🚀 REQUEST: ${options.method} ${options.uri}');
      print('📋 Headers: ${options.headers}');
      print('📦 Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('✅ RESPONSE: ${response.statusCode}');
      print('📊 Data: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('❌ ERROR: ${err.message}');
      print('📍 Status Code: ${err.response?.statusCode}');
      print('📊 Error Data: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
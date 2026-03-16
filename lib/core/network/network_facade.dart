import 'package:dio/dio.dart';
import '../error/exceptions.dart';
import 'interceptors/network_interceptor.dart';

abstract class NetworkFacadeInterface {
  Future<T> get<T>(String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<T> post<T>(String endpoint, {dynamic data, T Function(Map<String, dynamic>)? fromJson});
  Future<T> put<T>(String endpoint, {dynamic data, T Function(Map<String, dynamic>)? fromJson});
  Future<T> delete<T>(String endpoint, {T Function(Map<String, dynamic>)? fromJson});
  Future<T> uploadFile<T>(String endpoint, {required FormData formData, T Function(Map<String, dynamic>)? fromJson});
}

class NetworkFacade implements NetworkFacadeInterface {
  static final NetworkFacade _instance = NetworkFacade._internal();
  factory NetworkFacade() => _instance;
  NetworkFacade._internal();

  final Dio _dio = Dio()
    ..options.connectTimeout = const Duration(seconds: 30)
    ..options.receiveTimeout = const Duration(seconds: 30)
    ..options.sendTimeout = const Duration(seconds: 30)
    ..interceptors.add(NetworkInterceptor());

  @override
  Future<T> get<T>(String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<T> post<T>(String endpoint, {dynamic data, T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<T> put<T>(String endpoint, {dynamic data, T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<T> delete<T>(String endpoint, {T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.delete(endpoint);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<T> uploadFile<T>(String endpoint, {required FormData formData, T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await _dio.post(endpoint, data: formData);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  T _handleResponse<T>(Response response, T Function(Map<String, dynamic>)? fromJson) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (fromJson != null && response.data != null) {
        return fromJson(response.data as Map<String, dynamic>);
      }
      return response.data as T;
    }
    throw NetworkException(
      'Request failed with status: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }
}
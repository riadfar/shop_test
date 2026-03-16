import 'package:dio/dio.dart';
import '../error/exceptions.dart';

abstract class RequestHandler {
  RequestHandler? _nextHandler;

  RequestHandler setNext(RequestHandler handler) {
    _nextHandler = handler;
    return handler;
  }

  Future<RequestContext> handle(RequestContext context) async {
    if (_nextHandler != null) {
      return await _nextHandler!.handle(context);
    }
    return context;
  }
}

class RequestContext {
  final String url;
  final String method;
  final dynamic body;
  final Map<String, dynamic> headers;
  final bool requiresAuth;
  final Response? response;
  final Exception? error;

  RequestContext({
    required this.url,
    required this.method,
    this.body,
    this.headers = const {},
    this.requiresAuth = true,
    this.response,
    this.error,
  });

  bool get hasError => error != null;

  RequestContext copyWith({
    String? url,
    String? method,
    dynamic body,
    Map<String, dynamic>? headers,
    bool? requiresAuth,
    Response? response,
    Exception? error,
  }) {
    return RequestContext(
      url: url ?? this.url,
      method: method ?? this.method,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      requiresAuth: requiresAuth ?? this.requiresAuth,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}
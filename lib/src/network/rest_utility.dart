import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utilities/utilities.dart';

abstract class IRestUtility {
  Future<Response> request(
    Method method,
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  });
}

class RestUtility implements IRestUtility {
  late Dio _dio;

  final String baseUrl;
  final List<Interceptor>? interceptors;
  final ResponseType responseType;

  RestUtility(
    this.baseUrl, {
    this.interceptors,
    this.responseType = ResponseType.plain,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    int sendTimeout = 30000,
  }) {
    BaseOptions _options = BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      responseType: responseType,
      headers: {},
      validateStatus: (_) {
        return true;
      },
      baseUrl: baseUrl,
    );
    _dio = Dio(_options);

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors ?? []);
    }
  }

  Future<Response> _createRequest(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    options ??= Options(headers: {});
    options.method = method;

    var response;
    try {
      response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      Log.d(e.toString(), tag: 'RestUtility');
    }
    return response;
  }

  @override
  Future<Response> request(
    Method method,
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await _createRequest(
      method.value,
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }
}

enum Method { POST, PUT, DELETE, GET }

extension MethodExtensions on Method {
  String get value => describeEnum(this);
}

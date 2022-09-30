
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restaurantapp/core/data/api.dart';
import 'package:restaurantapp/core/data/base_api_impl.dart';
import 'package:restaurantapp/core/models/api/api_response.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/connection/connection_provider.dart';
import 'package:restaurantapp/injector.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;
  final endpoint = locator<Api>();

  /// Initialize constructors
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
  }
  Options getHeaders({bool? useToken}) {
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';
    if (useToken == true) {
      header['Authorization'] = 'Bearer <token>';
    }
    return Options(
      headers: header,
      sendTimeout: 60*1000, // 60 seconds
      receiveTimeout: 60*1000 // 60 seconds
    );
  }

  @override
  Future<APIResponse> delete(String url, {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.delete(
        url,
        options: getHeaders(useToken: useToken),
        queryParameters: param
      );
      return _parseResponse(result);
    } on DioError catch(e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> get(String url, {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.get(
        url,
        options: getHeaders(useToken: useToken),
        queryParameters: param
      );
      return _parseResponse(result);
    } on DioError catch(e) {
      if (e.error is SocketException) {
        ConnectionProvider.instance(navigate.navigatorKey.currentContext!).setConnection(false);
      } else {
        if (Platform.environment.containsKey('FLUTTER_TEST') == false) {
          ConnectionProvider.instance(navigate.navigatorKey.currentContext!).setConnection(true);
        }
      }
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> post(String url, {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.post(
        url,
        options: getHeaders(useToken: useToken),
        data: data,
        queryParameters: param
      );
      return _parseResponse(result);
    } on DioError catch(e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> put(String url, {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.put(
        url,
        options: getHeaders(useToken: useToken),
        data: data,
        queryParameters: param
      );
      return _parseResponse(result);
    } on DioError catch(e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }
  
  Future<APIResponse> _parseResponse(Response? response) async {
    return APIResponse.fromJson({
      'statusCode': response?.statusCode,
      'data': response?.data,
    });
  }
}
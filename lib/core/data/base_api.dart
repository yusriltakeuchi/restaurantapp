
import 'package:dio/dio.dart';
import 'package:restaurantapp/core/data/api.dart';
import 'package:restaurantapp/core/data/base_api_impl.dart';
import 'package:restaurantapp/core/models/api/api_response.dart';
import 'package:restaurantapp/injector.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;
  final endpoint = locator<Api>();

  /// Initialize constructors
  BaseAPI() {
    _dio = Dio();
    /// Show api logger in debug mode
    // if (kDebugMode) {
    //   _dio?.interceptors.add(
    //     PrettyDioLogger(
    //       requestBody: true,
    //       requestHeader: true,
    //     ),
    //   );
    // }
  }
  Options _getHeaders({bool? useToken}) {
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
        options: _getHeaders(useToken: useToken),
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
        options: _getHeaders(useToken: useToken),
        queryParameters: param
      );
      return _parseResponse(result);
    } on DioError catch(e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> post(String url, {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.post(
        url,
        options: _getHeaders(useToken: useToken),
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
        options: _getHeaders(useToken: useToken),
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
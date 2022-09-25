import 'package:restaurantapp/core/models/api/api_response.dart';

abstract class BaseAPIImpl {
  Future<APIResponse> get(String url, {Map<String, dynamic>? param, bool? useToken});

  Future<APIResponse> post(String url, {Map<String, dynamic>? param, dynamic data, bool? useToken});

  Future<APIResponse> put(String url, {Map<String, dynamic>? param, dynamic data, bool? useToken});

  Future<APIResponse> delete(String url, {Map<String, dynamic>? param, bool? useToken});
}
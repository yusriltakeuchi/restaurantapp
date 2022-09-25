class ApiResult<T extends Serializable> {
  String? message;
  bool? error;
  T data;
  ApiResult({
    required this.message, 
    required this.error, 
    required this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic>? json, Function(Map<String, dynamic>) create, String field) {
    return ApiResult<T>(
      message: json?['message'] ?? "",
      error: json?['error'] ?? false,
      data: json?[field] != null && json?[field] is Map
        ? create(json?[field] ?? {})
        : create({}),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "data": data.toJson(),
  };
}

class ApiResultList<T extends Serializable> {
  String? message;
  bool? error;
  List<T>? data;

  ApiResultList({this.message, this.error, this.data});

  factory ApiResultList.fromJson(Map<String, dynamic>? json, Function(List<dynamic>) build, String field) {
    return ApiResultList<T>(
      message: json?['message'] ?? "",
      error: json?['error'] ?? false,
      data: json?[field] != null && json?[field] is List
        ? build(json?[field])
        : build([]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "data": data?.toList(),
  };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
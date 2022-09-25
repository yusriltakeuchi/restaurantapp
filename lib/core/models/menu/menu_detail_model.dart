import 'package:restaurantapp/core/models/api/api_result_model.dart';

class MenuDetailModel extends Serializable {
  final String name;
  MenuDetailModel({
    required this.name,
  });
  
  factory MenuDetailModel.fromJson(Map<String, dynamic> json) {
    return MenuDetailModel(
      name: json['name'] ?? "",
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }
}

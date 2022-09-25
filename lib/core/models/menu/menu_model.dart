import 'package:restaurantapp/core/models/api/api_result_model.dart';
import 'package:restaurantapp/core/models/menu/menu_detail_model.dart';

class MenuModel extends Serializable {
  final List<MenuDetailModel> foods;
  final List<MenuDetailModel> drinks;
  MenuModel({
    required this.foods,
    required this.drinks,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      foods: (json['foods'] as List)
          .map((e) => MenuDetailModel.fromJson(e))
          .toList(),
      drinks: (json['drinks'] as List)
          .map((e) => MenuDetailModel.fromJson(e))
          .toList(),
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "foods": foods,
      "drinks": drinks,
    };
  }
}

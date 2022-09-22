import 'package:restaurantapp/core/models/menu/menu_detail_model.dart';

class MenuModel {
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
}

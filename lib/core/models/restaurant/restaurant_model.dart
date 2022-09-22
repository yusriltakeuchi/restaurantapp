import 'package:restaurantapp/core/models/menu/menu_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String pictureUrl;
  final String city;
  final double rating;
  final MenuModel menus;
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureUrl,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      pictureUrl: json['pictureId'] ?? "",
      city: json['city'] ?? "",
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
      menus: MenuModel.fromJson(json['menus']),
    );
  }

  get length => null;
}

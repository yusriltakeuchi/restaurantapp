import 'package:restaurantapp/core/models/api/api_result_model.dart';
import 'package:restaurantapp/core/models/category/category_model.dart';
import 'package:restaurantapp/core/models/menu/menu_model.dart';
import 'package:restaurantapp/core/models/review/review_model.dart';

class RestaurantModel extends Serializable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final double rating;
  final MenuModel? menus;
  final RestaurantImageModel? image;
  final List<CategoryModel>? categories;
  List<ReviewModel>? reviews;
  bool isFavorite;
  
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.rating,
    this.menus,
    this.image,
    this.categories,
    this.reviews,
    this.isFavorite = false
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      city: json['city'] ?? "",
      address: json['address'] ?? "",
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0,
      menus: json['menus'] != null 
        ? MenuModel.fromJson(json['menus'])
        : null,
      image: json['pictureId'] != null
        ? RestaurantImageModel.fromJson(json['pictureId'])
        : null,
      categories: json['categories'] != null
        ? List<CategoryModel>.from(json['categories'].map((x) => CategoryModel.fromJson(x)))
        : [],
      reviews: json['customerReviews'] != null
        ? List<ReviewModel>.from(json['customerReviews'].map((x) => ReviewModel.fromJson(x)))
        : [],
    );
  }

  factory RestaurantModel.failure()
    => RestaurantModel(id: "", name: "", description: "", city: "", rating: 0.0);
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "city": city,
      "rating": rating,
      "menus": menus?.toJson(),
      "image": image?.toJson(),
      "categories": categories?.map((x) => x.toJson()).toList()
    };
  }
}

class RestaurantImageModel extends Serializable {
  String smallResolution;
  String mediumResolution;
  String largeResolution;
  RestaurantImageModel({
    required this.smallResolution,
    required this.mediumResolution,
    required this.largeResolution,
  });

  factory RestaurantImageModel.fromJson(String pictureId) {
    return RestaurantImageModel(
      smallResolution: "https://restaurant-api.dicoding.dev/images/small/$pictureId",
      mediumResolution: "https://restaurant-api.dicoding.dev/images/medium/$pictureId",
      largeResolution: "https://restaurant-api.dicoding.dev/images/large/$pictureId",
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      "smallResolution": smallResolution,
      "mediumResolution": mediumResolution,
      "largeResolution": largeResolution,
    };
  }
}

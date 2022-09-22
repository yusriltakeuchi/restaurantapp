import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/gen/assets.gen.dart';

class RestaurantService {
  /// Fetching list of restaurant from local assets
  Future<List<RestaurantModel>> getRestaurants() async {
    final dataRaw = await rootBundle.loadString(Assets.data.localRestaurant);
    final data = jsonDecode(dataRaw);
    return data.containsKey("restaurants")
        ? (data['restaurants'] as List)
            .map((e) => RestaurantModel.fromJson(e))
            .toList()
        : [];
  }

  /// Fetching list of city from local assets
  Future<List<String>> getCities() async {
    final dataRaw = await rootBundle.loadString(Assets.data.localRestaurant);
    final data = jsonDecode(dataRaw);
    return data.containsKey("restaurants")
        ? (data['restaurants'] as List).map((e) => e['city'] as String).toList().toSet().toList()
        : [];
  }
}


import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/injector.dart';

void main() {
  RestaurantService? restaurantService;
  /// Setup injector
  setupLocator();
  setUp(() {
    restaurantService = locator<RestaurantService>();
  });

  group("Searching Restaurant", () {
    test("Should return data when search something", () async {
      final result = await restaurantService!.searchRestaurants("Ampiran");
      expect(result.data?.length, greaterThanOrEqualTo(1));
    });

    test("Should return data with class RestaurantModel", () async {
      final result = await restaurantService!.searchRestaurants("Ampiran");
      expect(result.data?.first.runtimeType, equals(RestaurantModel));
    });


    test("Should return empty list when search with wrong keyword", () async {
      final result = await restaurantService!.searchRestaurants("Ampiran123");
      expect(result.data?.length, equals(0));
    });

    test("Should return empty list when search with empty keyword", () async {
      final result = await restaurantService!.searchRestaurants("");
      expect(result.data?.length, equals(0));
    });
  });

}
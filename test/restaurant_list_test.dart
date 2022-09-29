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

  group("Fetching Restaurants", () {
    test("Should return data with class RestaurantModel", () async {
      final result = await restaurantService!.getRestaurants();
      expect(result.data?.first.runtimeType, equals(RestaurantModel));
    });

    test("Should return list of restaurants", () async {
      final result = await restaurantService!.getRestaurants();
      expect(result.data?.length, greaterThanOrEqualTo(1));
    });
  });
}

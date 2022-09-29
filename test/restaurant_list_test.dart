import 'package:flutter_test/flutter_test.dart';
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
    test("should return list of restaurants", () async {
      final result = await restaurantService!.getRestaurants();
      expect(result.data?.length, greaterThanOrEqualTo(1));
    });

    test("should contains restaurant named 'Ampiran Kota'", () async {
      final result = await restaurantService!.getRestaurants();
      const restaurantName = "Ampiran Kota";
      expect(result.data?.any((item) => item.name == restaurantName), true);
    });
  });
}

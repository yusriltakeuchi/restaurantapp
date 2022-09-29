
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantapp/core/models/review/create_review_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/injector.dart';

void main() {
  RestaurantService? restaurantService;
  /// Setup injector
  setupLocator();
  setUp(() {
    restaurantService = locator<RestaurantService>();
  });

  group("Review Restaurants", () {
    test("Should return the review data like what was made before", () async {
      String text =  "Restorannya bagus dan nyaman untuk bersantai bersama keluarga";
      String sender = "Yusril";
      final data = CreateReviewModel(
        id: "rqdv5juczeskfw1e867", 
        name: sender, 
        review: text
      );
      final result = await restaurantService?.createReview(data);
      expect(result?.data?.any((item) 
        => item.name == sender && item.review == text), equals(true));
    });
  });
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:restaurantapp/core/data/base_api.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/injector.dart';

final responseRestaurantSearchAmpira = jsonEncode({
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "6u9lf7okjh9kfw1e867",
      "name": "Ampiran Kota",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "35",
      "city": "Balikpapan",
      "rating": 4.1
    }
  ]
});
final responseRestaurantSearchEmpty = jsonEncode({
  "error": false,
  "founded": 0,
  "restaurants": []
});

final responseRestaurantSearchNull = jsonEncode({
  "error": true,
  "message": "query should not empty"
});

void main() {
  final dio = Dio();
  DioAdapter? dioAdapter;
  BaseAPI? baseAPI;
  setupLocator();

  setUp(() {
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter!;
    baseAPI = BaseAPI(dio: dio);
  });

  group("Searching Restaurant", () {
    test("Should return data when search something", () async {
      dioAdapter?.onGet(
        baseAPI!.endpoint.searchRestaurant, 
        (request) {
          return request.reply(200, jsonDecode(responseRestaurantSearchAmpira));
        },
        headers: baseAPI?.getHeaders().headers,
      );

      final restaurantService = RestaurantService(baseAPI!);
      final result = await restaurantService.searchRestaurants("Ampiran");
      expect(result.data?.length, greaterThanOrEqualTo(1));
    });

    test("Should return data with class RestaurantModel", () async {
      dioAdapter?.onGet(
        baseAPI!.endpoint.searchRestaurant, 
        (request) {
          return request.reply(200, jsonDecode(responseRestaurantSearchAmpira));
        },
        headers: baseAPI?.getHeaders().headers,
      );

      final restaurantService = RestaurantService(baseAPI!);
      final result = await restaurantService.searchRestaurants("Ampiran");
      expect(result.data?.first.runtimeType, equals(RestaurantModel));
    });


    test("Should return empty list when search with wrong keyword", () async {
      dioAdapter?.onGet(
        baseAPI!.endpoint.searchRestaurant, 
        (request) {
          return request.reply(200, jsonDecode(responseRestaurantSearchEmpty));
        },
        headers: baseAPI?.getHeaders().headers,
      );

      final restaurantService = RestaurantService(baseAPI!);
      final result = await restaurantService.searchRestaurants("Ampiran1234214");
      expect(result.data?.length, equals(0));
    });

    test("Should return empty list when search with empty keyword", () async {
      dioAdapter?.onGet(
        baseAPI!.endpoint.searchRestaurant, 
        (request) {
          return request.reply(200, jsonDecode(responseRestaurantSearchNull));
        },
        headers: baseAPI?.getHeaders().headers,
      );

      final restaurantService = RestaurantService(baseAPI!);
      final result = await restaurantService.searchRestaurants("");
      expect(result.data?.length, equals(0));
    });
  });

}
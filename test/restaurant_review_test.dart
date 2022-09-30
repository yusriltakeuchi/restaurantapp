
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:restaurantapp/core/data/base_api.dart';
import 'package:restaurantapp/core/models/review/create_review_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/injector.dart';

final responseCreateReview = jsonEncode({
    "error": false,
    "message": "success",
    "customerReviews": [
        {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
        },
        {
            "name": "Yusril",
            "review": "Restorannya bagus dan nyaman untuk bersantai bersama keluarga",
            "date": "30 September 2022"
        },
        {
            "name": "Yusril",
            "review": "Restorannya bagus dan nyaman untuk bersantai bersama keluarga",
            "date": "30 September 2022"
        },
        {
            "name": "fsdf",
            "review": "sdafsdfa",
            "date": "30 September 2022"
        },
        {
            "name": "John",
            "review": "enak",
            "date": "30 September 2022"
        },
        {
            "name": "Beta",
            "review": "so so",
            "date": "30 September 2022"
        },
        {
            "name": "Omega",
            "review": "nice",
            "date": "30 September 2022"
        },
        {
            "name": "Andi",
            "review": "not bad",
            "date": "30 September 2022"
        },
        {
            "name": "Andi",
            "review": "nuansanya mantap dan makanannya mantap",
            "date": "30 September 2022"
        },
        {
            "name": "Andi",
            "review": "makanannya enak dan nuansanya mantap",
            "date": "30 September 2022"
        },
        {
            "name": "Dedi",
            "review": "restorannya pricey",
            "date": "30 September 2022"
        },
        {
            "name": "Yusril",
            "review": "Keren Banget",
            "date": "30 September 2022"
        }
    ]
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


  group("Review Restaurants", () {
    test("Should return the review data like what was made before", () async {
      String text =  "Keren Banget";
      String sender = "Yusril";
      final data = CreateReviewModel(
        id: "rqdv5juczeskfw1e867", 
        name: sender, 
        review: text
      );
      
      dioAdapter?.onPost(
        baseAPI!.endpoint.createReview, 
        (request) {
          return request.reply(201, jsonDecode(responseCreateReview));
        },
        headers: baseAPI?.getHeaders().headers,
        data: data.toJson(),
      );

      final restaurantService = RestaurantService(baseAPI!);
      final result = await restaurantService.createReview(data);
      expect(result.data?.any((item) 
        => item.name == sender && item.review == text), equals(true));
    });
  });
}
import 'package:restaurantapp/core/data/base_api.dart';
import 'package:restaurantapp/core/models/api/api_response.dart';
import 'package:restaurantapp/core/models/api/api_result_model.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/models/review/create_review_model.dart';
import 'package:restaurantapp/core/models/review/review_model.dart';

class RestaurantService {
  BaseAPI api;
  RestaurantService(this.api);
  
  Future<ApiResultList<RestaurantModel>> getRestaurants() async {
    APIResponse response = await api.get(api.endpoint.getRestaurants);
    return ApiResultList<RestaurantModel>.fromJson(response.data, (data) 
      => data.map((e) => RestaurantModel.fromJson(e)).toList(), "restaurants");
  }

  Future<ApiResultList<RestaurantModel>> searchRestaurants(String keyword) async {
    APIResponse response = await api.get(
      api.endpoint.searchRestaurant,
      param: {"q": keyword}
    );
    return ApiResultList<RestaurantModel>.fromJson(response.data, (data) 
      => data.map((e) => RestaurantModel.fromJson(e)).toList(), "restaurants");
  }

  Future<ApiResult<RestaurantModel>> getRestaurant(String id) async {
    APIResponse response = await api.get(
      api.endpoint.getRestaurant.replaceAll(":id", id),
    );
    return ApiResult<RestaurantModel>.fromJson(response.data, (data) 
      => RestaurantModel.fromJson(data), "restaurant");
  }

  Future<ApiResultList<ReviewModel>> createReview(CreateReviewModel data) async {
    APIResponse response = await api.post(
      api.endpoint.createReview,
      data: data.toJson()
    );
    return ApiResultList<ReviewModel>.fromJson(response.data, (data) 
      => data.map((e) => ReviewModel.fromJson(e)).toList(), "customerReviews");
  }
  
}

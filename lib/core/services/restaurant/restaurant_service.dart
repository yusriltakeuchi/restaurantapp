import 'package:restaurantapp/core/data/base_api.dart';
import 'package:restaurantapp/core/models/api/api_response.dart';
import 'package:restaurantapp/core/models/api/api_result_model.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';

class RestaurantService extends BaseAPI {
  
  Future<ApiResultList<RestaurantModel>> getRestaurants() async {
    APIResponse response = await get(endpoint.getRestaurants);
    return ApiResultList<RestaurantModel>.fromJson(response.data, (data) 
      => data.map((e) => RestaurantModel.fromJson(e)).toList(), "restaurants");
  }

  Future<ApiResultList<RestaurantModel>> searchRestaurants(String keyword) async {
    APIResponse response = await get(
      endpoint.searchRestaurant,
      param: {"q": keyword}
    );
    return ApiResultList<RestaurantModel>.fromJson(response.data, (data) 
      => data.map((e) => RestaurantModel.fromJson(e)).toList(), "restaurants");
  }

  Future<ApiResult<RestaurantModel>> getRestaurant(String id) async {
    APIResponse response = await get(
      endpoint.getRestaurant.replaceAll(":id", id),
    );
    return ApiResult<RestaurantModel>.fromJson(response.data, (data) 
      => RestaurantModel.fromJson(data), "restaurant");
  }
  
}

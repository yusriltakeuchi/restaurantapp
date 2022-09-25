
class Api {
  /// Base API Endpoint
  static const _baseServer = "https://restaurant-api.dicoding.dev";

  /// * -------------------
  ///  * Restaurants Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some route about restaurants
  /// */
  String getRestaurants = "$_baseServer/list";
  String getRestaurant = "$_baseServer/detail/:id";
  String searchRestaurant = "$_baseServer/search";
  String createReview = "$_baseServer/review";
}
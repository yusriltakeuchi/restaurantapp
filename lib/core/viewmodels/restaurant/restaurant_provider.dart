import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/models/review/create_review_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_local_service.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';
import 'package:restaurantapp/injector.dart';
import 'package:restaurantapp/ui/widgets/dialog/snackbar_item.dart';

class RestaurantProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections 
  ///=========================
 
  /// List of restaurants
  List<RestaurantModel>? _restaurants;
  List<RestaurantModel>? get restaurants => _restaurants;

  /// Detail of restaurant
  RestaurantModel? _restaurant;
  RestaurantModel? get restaurant => _restaurant;

  /// List of search result restaurants
  List<RestaurantModel>? _searchRestaurants;
  List<RestaurantModel>? get searchRestaurants => _searchRestaurants;

  /// List of restaurants by cities
  List<RestaurantModel>? _restaurantsByCity;
  List<RestaurantModel>? get restaurantsByCity => _restaurantsByCity;

  /// Save latest keyword
  String? _latestKeyword;
  String? get latestKeyword => _latestKeyword;

  /// List of city 
  List<String>? _cities;
  List<String>? get cities => _cities;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final restaurantLocalService = locator<RestaurantLocalService>();
  final restaurantService = locator<RestaurantService>();

  ///=========================
  /// Function Logic Sections 
  ///=========================

  /// Instance provider
  static RestaurantProvider instance(BuildContext context)
  => Provider.of(context, listen: false);
  
  /// Finding list of restaurant from API
  Future<void> getRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await restaurantService.getRestaurants();
      final favoriteProv = FavoriteProvider.instance(navigate.navigatorKey.currentContext!);
      if (result.error == false) {
        _restaurants = result.data;
        /// Validating favorite state
        _restaurants?.map((e) async => e.isFavorite = favoriteProv.isFavorite(e.id)).toList();
      } else {
        _restaurants = [];
      }
    } catch(e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _restaurants = [];
    } 
    setOnSearch(false);
  }

  /// Get detail of restaurant
  void getRestaurant(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await restaurantService.getRestaurant(id);
      final favoriteProv = FavoriteProvider.instance(navigate.navigatorKey.currentContext!);
      if (result.error == false) {
        _restaurant = result.data;
        /// Validating favorite state
        _restaurant?.isFavorite = favoriteProv.isFavorite(_restaurant!.id);
      } else {
        _restaurant = RestaurantModel.failure();
      }
    } catch(e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _restaurant = RestaurantModel.failure();
    } 
    setOnSearch(false);
  }

  /// Search restaurant by keywords
  void search(String keyword) async {
    if (keyword.isEmpty) {
      _searchRestaurants = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await restaurantService.searchRestaurants(keyword);
        if (result.error == false) {
          _searchRestaurants = result.data;
        } else {
          _searchRestaurants = [];
        }
      } catch(e) {
        debugPrint("Error: ${e.toString()}");
        _searchRestaurants = [];
      } 
      setOnSearch(false);
    }
  }

  /// Finding list of restaurants by cities
  void getRestaurantsByCity(String city) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    if (_restaurants == null) {
      await getRestaurants();
    }
    try {
      _restaurantsByCity = _restaurants!.where((item) => item.city.toLowerCase() == city.toLowerCase()).toList();
    } catch(e) {
      debugPrint("Error: ${e.toString()}");
      _restaurantsByCity = [];
    } 
    setOnSearch(false);
  }

  /// Finding list of city from local assets
  void getCities() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await restaurantService.getRestaurants();
      if (result.error == false) {
        _cities = result.data?.map((e) => e.city).toList().toSet().toList();
      } else {
        _cities = [];
      }
    } catch(e) {
      debugPrint("Error: ${e.toString()}");
      _cities = [];
    } 
    setOnSearch(false);
  }

  void createReview(CreateReviewModel data) async {
    try {
      final result = await restaurantService.createReview(data);
      if (result.error == false) {
        _restaurant?.reviews = result.data;
        showSnackbar(
          title: "Successfully create new review",
          color: Colors.green
        );
        notifyListeners();
      }
    } catch(e) {
      debugPrint("Error: ${e.toString()}");
      showSnackbar(
        title: "Failed creating review",
        color: Colors.red,
        isError: true
      );
    } 
  }

  void clearRestaurants() {
    _restaurants = null;
    notifyListeners();
  }

  void clearCities() {
    _cities = null;
    notifyListeners();
  }

  void clearRestaurantByCity() {
    _restaurantsByCity = null;
    notifyListeners();
  }

  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
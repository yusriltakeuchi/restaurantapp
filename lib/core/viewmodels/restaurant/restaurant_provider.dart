import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/injector.dart';

class RestaurantProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections 
  ///=========================
 
  /// List of restaurants
  List<RestaurantModel>? _restaurants;
  List<RestaurantModel>? get restaurants => _restaurants;

  /// List of search result restaurants
  List<RestaurantModel>? _searchRestaurants;
  List<RestaurantModel>? get searchRestaurants => _searchRestaurants;

  /// List of restaurants by cities
  List<RestaurantModel>? _restaurantsByCity;
  List<RestaurantModel>? get restaurantsByCity => _restaurantsByCity;

  /// List of city 
  List<String>? _cities;
  List<String>? get cities => _cities;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final restaurantService = locator<RestaurantService>();

  ///=========================
  /// Function Logic Sections 
  ///=========================

  /// Instance provider
  static RestaurantProvider instance(BuildContext context)
  => Provider.of(context, listen: false);
  
  /// Finding list of restaurant from local assets
  Future<void> getRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      _restaurants = await restaurantService.getRestaurants();
    } catch(e) {
      debugPrint("Error: ${e.toString()}");
      _restaurants = [];
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
      if (_restaurants == null) {
        await getRestaurants();
      }
      try {
        _searchRestaurants = _restaurants!.where((item) => item.name.toLowerCase().contains(keyword.toLowerCase())).toList();
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
      _cities = await restaurantService.getCities();
    } catch(e) {
      debugPrint("Error: ${e.toString()}");
      _cities = [];
    } 
    setOnSearch(false);
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
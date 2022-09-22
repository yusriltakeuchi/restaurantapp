import 'package:flutter/material.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/screens/restaurant/restaurant_cities_screen.dart';
import 'package:restaurantapp/ui/screens/restaurant/restaurant_detail_screen.dart';
import 'package:restaurantapp/ui/screens/restaurant/restaurant_screen.dart';
import 'package:restaurantapp/ui/screens/restaurant/restaurant_search_screen.dart';
import 'package:restaurantapp/ui/screens/splash/splash_screen.dart';

class RouterGenerator {
  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    /// Declaring argumen route
    final args = settings.arguments;
    switch (settings.name) {

      /// Splash group
      case routeSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: routeSplash),
        );

      /// Restaurant group
      case routeRestaurant:
        return MaterialPageRoute(
          builder: (_) => const RestaurantScreen(),
          settings: const RouteSettings(name: routeRestaurant),
        );
      case routeRestaurantSearch:
        return MaterialPageRoute(
          builder: (_) => const RestaurantSearchScreen(),
          settings: const RouteSettings(name: routeRestaurantSearch),
        );
      case routeRestaurantByCities:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ResturantCitiesScreen(
              city: args,
            ),
            settings: const RouteSettings(name: routeRestaurantByCities),
          );
        }
        break;
      case routeRestaurantDetail:
        if (args is RestaurantModel) {
          return MaterialPageRoute(
            builder: (_) => RestaurantDetailScreen(
              restaurant: args,
            ),
            settings: const RouteSettings(name: routeRestaurantDetail),
          );
        }
        break;
    }

    return null;
  }
}

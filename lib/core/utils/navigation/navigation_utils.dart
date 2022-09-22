
import 'package:flutter/material.dart';
import 'package:restaurantapp/injector.dart';

class NavigationUtils {
  /// Global key to use in navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Navigating to some screen using [routeName] and optional
  /// argument [data]
  Future<dynamic> pushTo(String routeName, {dynamic data}) 
    => navigatorKey.currentState!.pushNamed(routeName, arguments: data);

  Future<dynamic> pushToReplacement(String routeName, {dynamic data}) 
    => navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: data);

  /// Navigating to some screen using [routeName] and optional
  /// argument [data], this function include clear all navigation stack
  Future<dynamic> pushToRemoveUntil(String routeName, {dynamic data})
    => navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) 
      => false, arguments: data);

  /// Navigating back using pop,
  /// with optional argument [data]
  dynamic pop({dynamic data}) 
    => navigatorKey.currentState!.pop(data);
}

final navigate = locator<NavigationUtils>();


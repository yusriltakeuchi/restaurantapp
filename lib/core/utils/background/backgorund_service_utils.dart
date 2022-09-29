import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/core/utils/notification/notification_utils.dart';
import 'package:restaurantapp/injector.dart';
import 'package:restaurantapp/main.dart';

final ReceivePort port = ReceivePort();
class BackgroundServiceUtils {

  static BackgroundServiceUtils? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
 
  BackgroundServiceUtils._internal() {
    _instance = this;
  }
 
  factory BackgroundServiceUtils() => _instance ?? BackgroundServiceUtils._internal();
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');

    setupLocator();
    final notificationUtils = locator<NotificationUtils>();

    /// Fetching random restaurants
    final restaurantServices = locator<RestaurantService>();
    final rawData = await restaurantServices.getRestaurants();
    final restaurants = rawData.data;
    Random random = Random();
    final randomRestaurant = restaurants![random.nextInt(restaurants.length)];

    notificationUtils.showNotification(
      flutterLocalNotificationsPlugin,
      "Restaurant ${randomRestaurant.name}",
      "${randomRestaurant.name} is the best recommendation for you today!",
      randomRestaurant.id
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
 
  Future<void> someTask() async {
    debugPrint('Updated data from the background isolate');
  }

}
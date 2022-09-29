import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurantapp/core/utils/background/backgorund_service_utils.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/utils/notification/notification_utils.dart';
import 'package:restaurantapp/global_providers.dart';
import 'package:restaurantapp/injector.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/constant/themes.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/router/router_generator.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Registering global providers
  var providers = await GlobalProviders.register();

  /// Setup notification
  final notificationUtils = locator<NotificationUtils>();
  notificationUtils.initNotifications(flutterLocalNotificationsPlugin);
  notificationUtils.requestIOSPermissions(flutterLocalNotificationsPlugin);

  /// Setup Alarm Manager
  final bgService = locator<BackgroundServiceUtils>();
  bgService.initializeIsolate();
  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp(
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  final List<dynamic> providers;
  const MyApp({Key? key, 
    required this.providers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers as List<SingleChildWidget>,
      child: MaterialApp(
        title: 'Restaurant App',
        navigatorKey: locator<NavigationUtils>().navigatorKey,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        builder: (ctx, child) {
          setupScreenUtil(ctx);
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            ),
          );
        },
        initialRoute: routeSplash,
        onGenerateRoute: RouterGenerator.generate,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/injector.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/constant/themes.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/router/router_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

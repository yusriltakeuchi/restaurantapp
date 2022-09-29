import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/utils/background/backgorund_service_utils.dart';
import 'package:restaurantapp/core/utils/notification/notification_utils.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';
import 'package:restaurantapp/injector.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/screens/favorite/favorite_screen.dart';
import 'package:restaurantapp/ui/screens/restaurant/restaurant_screen.dart';
import 'package:restaurantapp/ui/screens/setting/setting_screen.dart';
import 'package:restaurantapp/ui/widgets/idle/idle_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  List<Widget> menuList = [
    const RestaurantScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];
  final _bgService = locator<BackgroundServiceUtils>();
  final notificationUtils = locator<NotificationUtils>();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _bgService.someTask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProv, _) {
          if (favoriteProv.favorites == null &&
              favoriteProv.onSearch == false) {
            favoriteProv.getFavorites();
            return const IdleLoadingCenter();
          }

          return menuList[_currentIndex];
        },
      ),
    );
  }

  Widget _bottomNavBar() {
    return CustomNavigationBar(
      iconSize: 25,
      selectedColor: primaryColor,
      unSelectedColor: grayColor.withOpacity(0.4),
      strokeColor: primaryColor,
      backgroundColor: Colors.white,
      borderRadius: const Radius.circular(15),
      currentIndex: _currentIndex,
      onTap: (index) {
        if (_currentIndex != index) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.local_restaurant_rounded),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Restaurant",
            style: styleSubtitle,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Favorite",
            style: styleSubtitle,
          ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.settings),
          badgeCount: 0,
          showBadge: false,
          title: Text(
            "Setting",
            style: styleSubtitle,
          ),
        ),
      ],
    );
  }
}

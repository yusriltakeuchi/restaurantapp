import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';
import 'package:restaurantapp/core/viewmodels/restaurant/restaurant_provider.dart';
import 'package:restaurantapp/gen/assets.gen.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/widgets/idle/idle_item.dart';
import 'package:restaurantapp/ui/widgets/idle/loading/loading_listview.dart';
import 'package:restaurantapp/ui/widgets/restaurant/restaurant_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Favorite",
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
            color: Colors.white,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => RestaurantProvider(),
        child: const FavoriteBody(),
      )
    );
  }
}

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, FavoriteProvider>(
      builder: (context, restaurantProv, favoriteProv, _) {
        
        if (restaurantProv.restaurantFavorites == null && restaurantProv.onSearch == false) {
          restaurantProv.getRestaurantFavorites(favoriteProv.favorites!);
          return const LoadingListView();
        }

        if (restaurantProv.restaurantFavorites == null && restaurantProv.onSearch) {
          return const LoadingListView();
        }

        if (restaurantProv.restaurantFavorites!.isEmpty) {
          return IdleNoItemCenter(
            title: "Restaurant not found",
            iconPathSVG: Assets.images.illustrationNotfound.path,
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: restaurantProv.restaurantFavorites!.length,
          itemBuilder: (context, index) {
            final restaurant = restaurantProv.restaurantFavorites![index];
            bool isFavorite = favoriteProv.isFavorite(restaurant.id);
            return RestaurantItem(
              restaurant: restaurant,
              onClick: () => navigate.pushTo(
                routeRestaurantDetail,
                data: restaurant.id,
              ),
              onClickFavorite: () {
                favoriteProv.toggleFavorite(restaurant.id);
                if (isFavorite) {
                  restaurantProv.removeFavorite(restaurant.id);
                }
              },
              isFavorite: isFavorite,
            );
          },
        );
      },
    );
  }
}
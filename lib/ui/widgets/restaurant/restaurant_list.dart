import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/widgets/restaurant/restaurant_item.dart';

class RestaurantListWidget extends StatelessWidget {
  final List<RestaurantModel> restaurants;
  final bool useHero;
  final bool useReplacement;

  const RestaurantListWidget({
    super.key,
    required this.restaurants,
    this.useHero = true,
    this.useReplacement = false
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProv, _) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: restaurants.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            RestaurantModel restaurant = restaurants[index];
            return RestaurantItem(
              restaurant: restaurant,
              useHero: useHero,
              onClick: () => useReplacement
                ? navigate.pushToReplacement(
                    routeRestaurantDetail,
                    data: restaurant.id,
                  )
                : navigate.pushTo(
                    routeRestaurantDetail,
                    data: restaurant.id,
                  ),
              onClickFavorite: () => favoriteProv.toggleFavorite(restaurant.id),
              isFavorite: favoriteProv.isFavorite(restaurant.id),
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/models/restaurant/restaurant_model.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';
import 'package:restaurantapp/core/viewmodels/restaurant/restaurant_provider.dart';
import 'package:restaurantapp/gen/assets.gen.dart';
import 'package:restaurantapp/ui/router/route_list.dart';
import 'package:restaurantapp/ui/widgets/idle/idle_item.dart';
import 'package:restaurantapp/ui/widgets/idle/loading/loading_listview.dart';
import 'package:restaurantapp/ui/widgets/restaurant/restaurant_item.dart';

class RestaurantListWidget extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantListWidget({
    super.key,
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProv, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: restaurants.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            RestaurantModel restaurant = restaurants[index];
            return RestaurantItem(
              restaurant: restaurant,
              onClick: () => navigate.pushTo(
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

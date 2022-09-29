import 'package:get_it/get_it.dart';
import 'package:restaurantapp/core/data/api.dart';
import 'package:restaurantapp/core/data/base_api.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_local_service.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/core/utils/favorite/favorite_utils.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  /// Registering api
  locator.registerSingleton(Api());
  locator.registerSingleton(BaseAPI());

  /// Registering utils
  locator.registerSingleton(NavigationUtils());
  locator.registerLazySingleton(() => FavoriteUtils());

  /// Registering services
  locator.registerLazySingleton(() => RestaurantLocalService());
  locator.registerLazySingleton(() => RestaurantService(
    locator<BaseAPI>()
  ));
}
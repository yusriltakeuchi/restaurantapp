import 'package:get_it/get_it.dart';
import 'package:restaurantapp/core/services/restaurant/restaurant_service.dart';
import 'package:restaurantapp/core/utils/navigation/navigation_utils.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  /// Registering utils
  locator.registerSingleton(NavigationUtils());

  /// Registering services
  locator.registerLazySingleton(() => RestaurantService());
}
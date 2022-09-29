import 'package:provider/provider.dart';
import 'package:restaurantapp/core/viewmodels/connection/connection_provider.dart';
import 'package:restaurantapp/core/viewmodels/favorite/favorite_provider.dart';

class GlobalProviders {

  /// Register your provider here
  static Future register() async => [
    ChangeNotifierProvider(create: (context) => ConnectionProvider()),
    ChangeNotifierProvider(create: (context) => FavoriteProvider()),
  ];
 
}

import 'package:restaurantapp/core/utils/global/shared_manager.dart';

class FavoriteUtils {
  final _key = "favoritesz";

  Future<List<String>> getFavorits() async {
    final shared = SharedManager<List<String>>();
    List<String>? data = await shared.read(_key);
    return data ?? [];
  }

  Future<void> addFavorite(String id) async {
    final shared = SharedManager<List<String>>();
    final favorites = await getFavorits();
    favorites.add(id);
    await shared.store(_key, favorites);
  }

  Future<void> removeFavorite(String id) async {
    final shared = SharedManager<List<String>>();
    final favorites = await getFavorits();
    favorites.remove(id);
    await shared.store(_key, favorites);
  }
}
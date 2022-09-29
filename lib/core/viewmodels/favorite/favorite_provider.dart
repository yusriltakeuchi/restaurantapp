import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/utils/favorite/favorite_utils.dart';
import 'package:restaurantapp/injector.dart';

class FavoriteProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections 
  ///=========================
 
  /// List of restaurants favorite id
  List<String>? _favorites;
  List<String>? get favorites => _favorites;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final favoriteUtils = locator<FavoriteUtils>();

  ///=========================
  /// Function Logic Sections 
  ///=========================

  /// Instance provider
  static FavoriteProvider instance(BuildContext context)
  => Provider.of(context, listen: false);

  /// Get list of favorites restaurant id
  Future<void> getFavorites() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    _favorites = await favoriteUtils.getFavorits();
    setOnSearch(false);
  }

  Future<void> toggleFavorite(String id) async {
    if (isFavorite(id) == false) {
      favoriteUtils.addFavorite(id);
    } else {
      favoriteUtils.removeFavorite(id);
    }
    getFavorites();
  }

  bool isFavorite(String id) => _favorites!.contains(id);
  
  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
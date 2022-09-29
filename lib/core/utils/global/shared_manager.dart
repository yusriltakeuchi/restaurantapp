import 'package:shared_preferences/shared_preferences.dart';

/// Generic class to do shared preferences
/// management with dynamic data type
class SharedManager<T> {

  /// Instance shared preferences
  /// and make it private
  late SharedPreferences _prefs;
  /// Get type of this generic class
  // ignore: avoid_shadowing_type_parameters
  Type type<T>() => T;
  
  /// Call the shared preferences
  /// field using keyname and with 
  /// the generic return type
  Future<T?> read(String key) async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(key)) {
      switch (type<T>()) {
        case String:
          return _prefs.getString(key) as T;
        case int:
          return _prefs.getInt(key) as T;
        case double:
          return _prefs.getDouble(key) as T;
        case bool:
          return _prefs.getBool(key) as T;
        case List<String>:
          return _prefs.getStringList(key) as T;
        default:
          return null;
      }
    }
    return null;
  }

  /// This function will set value
  /// into shared preferences
  Future store(String key, dynamic value) async {
    _prefs = await SharedPreferences.getInstance();
    var types = type<T>();
    switch(types) {
      case String:
        _prefs.setString(key, value);
        break;
      case int:
        _prefs.setInt(key, value);
        break;
      case bool:
        _prefs.setBool(key, value);
        break;
      case double:
        _prefs.setDouble(key, value);
        break;
      case List<String>:
        _prefs.setStringList(key, value);
        break;
    }
  }

  /// Clear all stored shared preferences
  Future clear() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }
}
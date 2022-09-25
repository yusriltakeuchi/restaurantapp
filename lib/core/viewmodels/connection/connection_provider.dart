import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections 
  ///=========================

  /// Connectivity status
  bool? _internetConnected = true;
  bool? get internetConnected => _internetConnected;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  
  ///=========================
  /// Function Logic Sections 
  ///=========================

  /// Instance provider
  static ConnectionProvider instance(BuildContext context)
  => Provider.of(context, listen: false);

  void setConnection(bool value) {
    if (_internetConnected != value) {
      _internetConnected = value;
      notifyListeners();
    }
  }

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
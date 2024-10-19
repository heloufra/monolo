import 'package:flutter/material.dart';

class NavBarVisibilityProvider extends ChangeNotifier {
  bool _isNavBarVisible = true;

  bool get isNavBarVisible => _isNavBarVisible;

  void showNavBar() {
    _isNavBarVisible = true;
    notifyListeners();
  }

  void hideNavBar() {
    _isNavBarVisible = false;
    notifyListeners();
  }
}

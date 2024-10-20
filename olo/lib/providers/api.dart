import 'package:flutter/foundation.dart';

class AppInitializationProvider with ChangeNotifier {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initializeAppData() async {
    // Fetch your app's data asynchronously
    // await Future.delayed(Duration(seconds: 2)); // Simulate data fetching

    _isInitialized = true;
    notifyListeners();
  }
}

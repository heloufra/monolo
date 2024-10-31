import 'package:flutter/foundation.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/models/mockRestaurants.dart';

class RestaurantProvider extends ChangeNotifier {
  List<Restaurant>? _restaurants;
  bool _isLoading = false;
  String? _error;
  DateTime? _lastFetchTime;

  List<Restaurant>? get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRestaurantsIfNeeded() async {
    // Check if we need to fetch data
    if (_shouldFetchData()) {
      await _fetchRestaurants();
    }
  }

  bool _shouldFetchData() {
    // Fetch if we don't have data or if it's been more than 15 minutes since last fetch
    if (_restaurants == null || _lastFetchTime == null) {
      return true;
    }
    final fifteenMinutesAgo = DateTime.now().subtract(Duration(minutes: 15));
    return _lastFetchTime!.isBefore(fifteenMinutesAgo);
  }

  Future<void> _fetchRestaurants() async {
    if (_isLoading) return; // Prevent multiple simultaneous fetches

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _restaurants = await MockDataService.getRestaurants() as List<Restaurant>?;
      _lastFetchTime = DateTime.now();
    } catch (e) {
      _error = e.toString();
      print('Error fetching restaurants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Force refresh method
  Future<void> forceRefresh() async {
    _lastFetchTime = null; // Reset last fetch time
    await _fetchRestaurants();
  }
}
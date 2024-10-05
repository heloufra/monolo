import 'package:flutter/foundation.dart';
import 'package:olo/models/dish.dart';

class DishProvider with ChangeNotifier {
  Map<String, List<Dish>> _dishesByRestaurant = {};

  Map<String, List<Dish>> get dishesByRestaurant => _dishesByRestaurant;

  void setDishesForRestaurant(String restaurantId, List<Dish> dishes) {
    _dishesByRestaurant[restaurantId] = dishes;
    notifyListeners();
  }

  List<Dish> getDishesForRestaurant(String restaurantId) {
    return _dishesByRestaurant[restaurantId] ?? [];
  }

  // Add more dish-related methods as needed, for example:
  Future<void> fetchDishesForRestaurant(String restaurantId) async {
    // Implement the logic to fetch dishes for a specific restaurant from your API
    // After fetching:
    // _dishesByRestaurant[restaurantId] = fetchedDishes;
    notifyListeners();
  }
}
import 'package:flutter/foundation.dart';
import 'package:olo/models/dish.dart';
import 'package:olo/models/order.dart';

class RestaurantDashboardProvider with ChangeNotifier {
  String _restaurantId = '';
  List<Dish> _menu = [];
  List<Order> _currentOrders = [];
  bool _isDeliveryEnabled = true;
  bool _isServiceAvailable = true;

  String get restaurantId => _restaurantId;
  List<Dish> get menu => _menu;
  List<Order> get currentOrders => _currentOrders;
  bool get isDeliveryEnabled => _isDeliveryEnabled;
  bool get isServiceAvailable => _isServiceAvailable;

  void setRestaurantId(String id) {
    _restaurantId = id;
    notifyListeners();
  }

  Future<void> fetchMenu() async {
    // TODO: Implement API call to fetch menu
    // For now, we'll use dummy data
    // _menu = [
    //   Dish(id: '1', name: 'Burger', description: 'Tasty burger', price: 9.99),
    //   Dish(id: '2', name: 'Pizza', description: 'Delicious pizza', price: 12.99),
    // ];
    notifyListeners();
  }

  Future<void> addDish(Dish dish) async {
    // TODO: Implement API call to add dish
    _menu.add(dish);
    notifyListeners();
  }

  Future<void> updateDish(Dish dish) async {
    // TODO: Implement API call to update dish
    final index = _menu.indexWhere((d) => d.id == dish.id);
    if (index != -1) {
      _menu[index] = dish;
      notifyListeners();
    }
  }

  Future<void> deleteDish(String dishId) async {
    // TODO: Implement API call to delete dish
    _menu.removeWhere((d) => d.id == dishId);
    notifyListeners();
  }

  Future<void> fetchCurrentOrders() async {
    // TODO: Implement API call to fetch current orders
    // For now, we'll use dummy data
    _currentOrders = [
      Order(id: '1', items: [], customerId: 'customer1', restaurantId: _restaurantId, status: OrderStatus.CONFIRMED),
      Order(id: '2', items: [], customerId: 'customer2', restaurantId: _restaurantId, status: OrderStatus.PREPARING),
    ];
    notifyListeners();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    // TODO: Implement API call to update order status
    final index = _currentOrders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _currentOrders[index].status = newStatus;
      notifyListeners();
    }
  }

  void toggleDeliveryService() {
    _isDeliveryEnabled = !_isDeliveryEnabled;
    notifyListeners();
  }

  void toggleServiceAvailability() {
    _isServiceAvailable = !_isServiceAvailable;
    notifyListeners();
  }
}
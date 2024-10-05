import 'package:flutter/foundation.dart';
import 'package:olo/models/order.dart';
import 'package:olo/models/order_item.dart';
import 'package:olo/models/dish.dart';

class OrderProvider with ChangeNotifier {
  Order? _currentOrder;
  List<Order> _pastOrders = [];

  Order? get currentOrder => _currentOrder;
  List<Order> get pastOrders => _pastOrders;

  void createNewOrder(String restaurantId, String customerId) {
    _currentOrder = Order(
      items: [],
      customerId: customerId,
      restaurantId: restaurantId,
    );
    notifyListeners();
  }

  void addDishToOrder(Dish dish) {
    if (_currentOrder != null) {
      final existingItemIndex = _currentOrder!.items.indexWhere((item) => item.dish.id == dish.id);
      if (existingItemIndex != -1) {
        _currentOrder!.items[existingItemIndex].quantity++;
      } else {
        _currentOrder!.items.add(OrderItem(dish: dish, quantity: 1));
      }
      notifyListeners();
    }
  }

  void removeDishFromOrder(String dishId) {
    if (_currentOrder != null) {
      _currentOrder!.items.removeWhere((item) => item.dish.id == dishId);
      notifyListeners();
    }
  }

  void updateDishQuantity(String dishId, int quantity) {
    if (_currentOrder != null) {
      final itemIndex = _currentOrder!.items.indexWhere((item) => item.dish.id == dishId);
      if (itemIndex != -1) {
        if (quantity > 0) {
          _currentOrder!.items[itemIndex].quantity = quantity;
        } else {
          _currentOrder!.items.removeAt(itemIndex);
        }
        notifyListeners();
      }
    }
  }

  Future<void> placeOrder() async {
    if (_currentOrder != null) {
      // Implement the logic to place the order (e.g., API call)
      // After successful order placement:
      _pastOrders.add(_currentOrder!);
      _currentOrder = null;
      notifyListeners();
    }
  }

  Future<void> fetchPastOrders(String customerId) async {
    // Implement the logic to fetch past orders from your API
    // After fetching:
    // _pastOrders = fetchedOrders;
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final orderIndex = _pastOrders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      _pastOrders[orderIndex].status = newStatus;
      notifyListeners();
    }
  }
}
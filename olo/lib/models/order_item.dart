import 'package:uuid/uuid.dart';
import 'package:olo/models/dish.dart';

class OrderItem {
  final String id;
  final Dish dish;
  int quantity;

  OrderItem({
    String? id,
    required this.dish,
    required this.quantity,
  }) : this.id = id ?? Uuid().v4();

  double get totalPrice => dish.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dish': dish.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'],
      dish: Dish.fromMap(map['dish']),
      quantity: map['quantity'],
    );
  }
}
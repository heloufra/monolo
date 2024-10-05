import 'package:uuid/uuid.dart';
import 'package:olo/models/order_item.dart';

enum OrderStatus { PENDING, CONFIRMED, PREPARING, OUT_FOR_DELIVERY, DELIVERED, CANCELLED }

class Order {
  final String id;
  List<OrderItem> items;
  OrderStatus status;
  String customerId;
  String restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    String? id,
    required this.items,
    this.status = OrderStatus.PENDING,
    required this.customerId,
    required this.restaurantId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.id = id ?? Uuid().v4(),
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  double get total => items.fold(0, (sum, item) => sum + item.totalPrice);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'status': status.toString().split('.').last,
      'customerId': customerId,
      'restaurantId': restaurantId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      items: (map['items'] as List).map((item) => OrderItem.fromMap(item)).toList(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => OrderStatus.PENDING,
      ),
      customerId: map['customerId'],
      restaurantId: map['restaurantId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
import 'package:olo/models/address.dart';
import 'package:olo/models/order.dart';
import 'package:olo/models/review.dart';
import 'package:olo/models/settings.dart';
import 'package:uuid/uuid.dart';

enum UserRole { CUSTOMER, DELIVERY_PERSON, ADMIN, RESTAURANT }

class UserX {
  final String id;
  String? name;
  String? email;
  String? phoneNumber;
  UserRole? role;
  String? picture;
  Settings? settings;
  List<Address>? addresses;
  List<Order>? orders;
  List<Review>? reviews;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserX({
    String? id,
    String? this.name,
    String? this.email,
    String? this.phoneNumber,
    this.role = UserRole.CUSTOMER,
    String? this.picture,
    Settings? this.settings,
    List<Address>? this.addresses,
    List<Order>? this.orders,
    List<Review>? this.reviews,
    DateTime? this.createdAt,
    DateTime? this.updatedAt,
  }) : this.id = id ?? Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role.toString().split('.').last,
      'picture': picture,
      'settings': settings?.toMap(),
      'addresses': addresses?.map((address) => address.toMap()).toList(),
      'orders': orders?.map((order) => order.toMap()).toList(),
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserX.fromMap(Map<String, dynamic> map) {
    return UserX(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.CUSTOMER,
      ),
      picture: map['picture'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

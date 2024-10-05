import 'package:uuid/uuid.dart';

enum UserRole { CUSTOMER, DELIVERY_PERSON, ADMIN, RESTAURANT }

class User {
  final String id;
  String? name;
  String? email;
  String? phoneNumber;
  String? otp;
  UserRole role;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    String? id,
    this.name,
    this.email,
    this.phoneNumber,
    this.otp,
    this.role = UserRole.CUSTOMER,
    this.picture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.id = id ?? Uuid().v4(),
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'otp': otp,
      'role': role.toString().split('.').last,
      'picture': picture,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      otp: map['otp'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.CUSTOMER,
      ),
      picture: map['picture'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
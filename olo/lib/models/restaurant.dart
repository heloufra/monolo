import 'package:uuid/uuid.dart';

class Restaurant {
  final String id;
  String name;
  String? address;
  String? email;
  String? phoneNumber;
  String? picture;
  double? rating;
  DateTime? createdAt;
  DateTime? updatedAt;

  Restaurant({
    String? id,
    required this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.picture,
    this.rating,
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
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'picture': picture,
      'rating': rating,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      picture: map['picture'],
      rating: map['rating'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
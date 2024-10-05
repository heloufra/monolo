import 'package:uuid/uuid.dart';

class Address {
  final String id;
  String name;
  String? street;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  double? latitude;
  double? longitude;
  String? userId;
  String? restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Address({
    String? id,
    required this.name,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.userId,
    this.restaurantId,
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
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'restaurantId': restaurantId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      name: map['name'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      postalCode: map['postalCode'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userId: map['userId'],
      restaurantId: map['restaurantId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
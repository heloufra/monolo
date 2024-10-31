import 'package:olo/models/dish.dart';
import 'package:olo/models/review.dart';
import 'package:olo/models/address.dart';
import 'package:olo/models/category.dart';
import 'package:olo/models/order.dart';
import 'package:uuid/uuid.dart';

class Restaurant {
  final String id;
  String name;
  String? addressId;
  Address? address;
  String? email;
  String? phoneNumber;
  String? logo;
  List<String>? pictures;
  double? rating;
  String? description;
  List<Dish>? dishes;
  List<Order>? orders;
  List<Review>? reviews;
  List<Category>? categories;
  DateTime? createdAt;
  DateTime? updatedAt;

  Restaurant({
    String? id,
    required this.name,
    this.addressId,
    this.address,
    required this.email,
    this.phoneNumber,
    this.logo,
    this.pictures,
    this.rating,
    this.description,
    this.dishes,
    this.orders,
    this.reviews,
    this.categories,
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
      'addressId': addressId,
      'address': address?.toMap(),
      'email': email,
      'phoneNumber': phoneNumber,
      'logo': logo,
      'pictures': pictures,
      'rating': rating,
      'description': description,
      'dishes': dishes?.map((dish) => dish.toMap()).toList(),
      'orders': orders?.map((order) => order.toMap()).toList(),
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'categories': categories?.map((category) => category.toMap()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      addressId: map['addressId'],
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      logo: map['logo'],
      pictures: map['pictures'] != null ? List<String>.from(map['pictures']) : null,
      rating: map['rating']?.toDouble(),
      description: map['description'],
      dishes: map['dishes'] != null 
        ? List<Dish>.from(map['dishes'].map((dish) => Dish.fromMap(dish)))
        : null,
      orders: map['orders'] != null 
        ? List<Order>.from(map['orders'].map((order) => Order.fromMap(order)))
        : null,
      reviews: map['reviews'] != null 
        ? List<Review>.from(map['reviews'].map((review) => Review.fromMap(review)))
        : null,
      categories: map['categories'] != null 
        ? List<Category>.from(map['categories'].map((category) => Category.fromMap(category)))
        : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Helper method to create a copy of Restaurant with modified fields
  Restaurant copyWith({
    String? name,
    String? addressId,
    Address? address,
    String? email,
    String? phoneNumber,
    String? logo,
    List<String>? pictures,
    double? rating,
    String? description,
    List<Dish>? dishes,
    List<Order>? orders,
    List<Review>? reviews,
    List<Category>? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Restaurant(
      id: this.id,
      name: name ?? this.name,
      addressId: addressId ?? this.addressId,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      logo: logo ?? this.logo,
      pictures: pictures ?? this.pictures,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      dishes: dishes ?? this.dishes,
      orders: orders ?? this.orders,
      reviews: reviews ?? this.reviews,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
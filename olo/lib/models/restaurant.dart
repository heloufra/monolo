import 'package:olo/models/dish.dart';
import 'package:olo/models/review.dart';
import 'package:uuid/uuid.dart';

class Restaurant {
  final String id;
  String name;
  String? address;
  String? email;
  String? phoneNumber;
  String? description;
  List<String>? pictures;
  int? rating;
  List<Dish>? dishes;
  List<Review>? reviews;
  DateTime? createdAt;
  DateTime? updatedAt;

  Restaurant({
    String? id,
    required this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.pictures,
    this.rating,
    this.dishes,
    this.reviews,
    this.description,
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
      'description': description,
      'pictures': pictures?.map((picture) => picture).toList(),
      'rating': rating,
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'dishes': dishes?.map((dish) => dish.toMap()).toList(),
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
      description: map['description'],
      phoneNumber: map['phoneNumber'],
      pictures: map['pictures'] != null ? List<String>.from(map['pictures'].map((picture) => picture)) : null,
      rating: map['rating'],
      reviews: map['reviews'] != null ? List<Review>.from(map['reviews'].map((review) => Review.fromMap(review))) : null,
      dishes: map['dishes'] != null ? List<Dish>.from(map['dishes'].map((dish) => Dish.fromMap(dish))) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
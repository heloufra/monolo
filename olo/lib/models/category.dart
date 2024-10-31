import 'package:uuid/uuid.dart';
import 'package:olo/models/dish.dart';
import 'package:olo/models/restaurant.dart';

class Category {
  final String id;
  String name;

  List<Dish>? dishes;
  List<Restaurant>? restaurants;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    String? id,
    required this.name,
    this.dishes,
    this.restaurants,
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
      'dishes': dishes?.map((dish) => dish.toMap()).toList(),
      'restaurants': restaurants?.map((restaurant) => restaurant.toMap()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      dishes: map['dishes'] != null 
        ? List<Dish>.from(map['dishes'].map((dish) => Dish.fromMap(dish)))
        : null,
      restaurants: map['restaurants'] != null 
        ? List<Restaurant>.from(map['restaurants'].map((restaurant) => Restaurant.fromMap(restaurant)))
        : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Helper method to create a copy of Category with modified fields
  Category copyWith({
    String? name,
    String? description,
    String? picture,
    List<Dish>? dishes,
    List<Restaurant>? restaurants,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: this.id,
      name: name ?? this.name,
      dishes: dishes ?? this.dishes,
      restaurants: restaurants ?? this.restaurants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
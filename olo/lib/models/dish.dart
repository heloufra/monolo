import 'package:olo/models/category.dart';
import 'package:uuid/uuid.dart';

class Dish {
  final String id;
  String name;
  String description;
  double price;
  double rating;
  List<String> pictures;
  String restaurantId;
  Category category;
  DateTime createdAt;
  DateTime updatedAt;

  Dish({
    String? id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.pictures,
    required this.restaurantId,
    required this.category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.id = id ?? Uuid().v4(),
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  // Convert Dish instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'pictures': pictures,
      'restaurantId': restaurantId,
      'category': category.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a Dish instance from a Map
  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      rating: map['rating'],
      category: Category.fromMap(map['category']),
      pictures: List<String>.from(map['pictures']),
      restaurantId: map['restaurantId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
import 'package:uuid/uuid.dart';

class Review {
  final String id;
  int rating;
  String comment;
  String userId;
  String restaurantId;
  String? dishId;
  DateTime createdAt;
  DateTime updatedAt;

  Review({
    String? id,
    this.rating = 1,
    required this.comment,
    required this.userId,
    required this.restaurantId,
    this.dishId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.id = id ?? Uuid().v4(),
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'userId': userId,
      'restaurantId': restaurantId,
      'dishId': dishId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      rating: map['rating'],
      comment: map['comment'],
      userId: map['userId'],
      restaurantId: map['restaurantId'],
      dishId: map['dishId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
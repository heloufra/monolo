import 'package:flutter/foundation.dart';
import 'package:olo/models/review.dart';

class ReviewProvider with ChangeNotifier {
  Map<String, List<Review>> _reviewsByRestaurant = {};
  Map<String, List<Review>> _reviewsByDish = {};

  Map<String, List<Review>> get reviewsByRestaurant => _reviewsByRestaurant;
  Map<String, List<Review>> get reviewsByDish => _reviewsByDish;

  void setReviewsForRestaurant(String restaurantId, List<Review> reviews) {
    _reviewsByRestaurant[restaurantId] = reviews;
    notifyListeners();
  }

  void setReviewsForDish(String dishId, List<Review> reviews) {
    _reviewsByDish[dishId] = reviews;
    notifyListeners();
  }

  Future<void> addReview(Review review) async {
    // Implement the logic to add a review (e.g., API call)
    // After successful addition:
    if (review.dishId != null) {
      _reviewsByDish[review.dishId!] ??= [];
      _reviewsByDish[review.dishId]!.add(review);
    }
    _reviewsByRestaurant[review.restaurantId] ??= [];
    _reviewsByRestaurant[review.restaurantId]!.add(review);
    notifyListeners();
  }

  // Add more review-related methods as needed
}
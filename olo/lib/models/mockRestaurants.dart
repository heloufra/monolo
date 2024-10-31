import 'dart:async';
import 'dart:math';
import 'package:olo/models/restaurant.dart';
import 'package:olo/models/review.dart';
import 'package:olo/services/restaurants.dart';


class MockDataService {
 

  static Future<List<Restaurant>> getRestaurants() async {
    RestaurantService restaurantService = RestaurantService();

     List<Restaurant>? vara = await restaurantService.getAllRestaurants();
  

   
      return vara;
  }

  static Future<List<Review>> getReviews(String restaurantId) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Generate mock reviews
    return List.generate(5, (index) => Review(
      rating: Random().nextInt(5) + 1,
      comment: 'This is a great restaurant! Mock review ${index + 1}',
      userId: 'user${index + 1}',
      restaurantId: restaurantId,
    ));
  }
}
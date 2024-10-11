import 'dart:async';
import 'dart:math';
import 'package:olo/models/restaurant.dart';
import 'package:olo/models/review.dart';
import 'package:olo/services/restaurants.dart';


class MockDataService {
  static final List<Restaurant> _restaurants = [
    Restaurant(
      name: 'Mediterranean Delights',
      address: '123 Sea Street, Oceanview',
      email: 'info@meddelights.com',
      phoneNumber: '+1 234 567 8900',
      pictures: ['https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80'],
      rating: 4,
    ),
    Restaurant(
      name: 'Pasta House',
      address: '456 Noodle Avenue, Pastaville',
      email: 'hello@pastahouse.com',
      phoneNumber: '+1 987 654 3210',
      pictures: ['https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=800&q=80'],
      rating: 4,
    ),
  ];

  static Future<List<Restaurant>> getRestaurants() async {
    // Simulate network delay
    RestaurantService restaurantService = RestaurantService();

     List<Restaurant>? vara = await restaurantService.getAllRestaurants();
    //  print(JsonDecoder().convert(vara.toString()));
    if (vara != null)
      print(vara[0].pictures);
    // await Future.delayed(Duration(seconds: 2));
      
    // // Simulate potential error
    // if (Random().nextInt(10) == 0) {
    //   throw Exception('Failed to fetch restaurants');
    // }

    if (vara != null)
      return vara;
    return _restaurants;
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
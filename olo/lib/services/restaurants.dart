import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olo/utlis/constants.dart';
import 'package:olo/models/restaurant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class RestaurantService {
  Future<List<Restaurant>?> getAllRestaurants() async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/restaurant/all');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Restaurant.fromMap(json)).toList();
      } else {
        throw Exception(_handleError(response.statusCode, response.body));
      }
    } catch (e) {
      throw Exception('Error fetching restaurants: $e');
    }
  }

  Future<Restaurant?> getRestaurantById(String id) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/restaurant/$id');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        return Restaurant.fromMap(json.decode(response.body));
      } else {
        throw Exception(_handleError(response.statusCode, response.body));
      }
    } catch (e) {
      throw Exception('Error fetching restaurant: $e');
    }
  }

  Future<Restaurant?> updateRestaurant(String id, Map<String, dynamic> updateData) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/restaurant/update');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return Restaurant.fromMap(json.decode(response.body));
      } else {
        throw Exception(_handleError(response.statusCode, response.body));
      }
    } catch (e) {
      throw Exception('Error updating restaurant: $e');
    }
  }

  String _handleError(int statusCode, String responseBody) {
    switch (statusCode) {
      case 400:
        return 'Invalid data provided. Please check your input.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 404:
        return 'Restaurant not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred: $statusCode';
    }
  }
}
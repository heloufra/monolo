import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:olo/models/restaurant.dart';
import 'package:olo/utlis/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// restaurant_exception.dart
class RestaurantException implements Exception {
  final String message;
  final int? statusCode;
  
  RestaurantException(this.message, [this.statusCode]);
  
  @override
  String toString() => 'RestaurantException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

// restaurant_service.dart

class RestaurantService {
  final Duration timeout = const Duration(seconds: 10);

  /// Handles HTTP response status codes
  String _handleError(int statusCode, String body) {
    switch (statusCode) {
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'You don\'t have permission to access this resource.';
      case 404:
        return 'Restaurants data not found.';
      case 500:
        return 'Internal server error. Please try again later.';
      default:
        try {
          final error = json.decode(body);
          return error['message'] ?? 'Unknown error occurred.';
        } catch (_) {
          return 'Error occurred while fetching restaurants.';
        }
    }
  }

  /// Validates the JWT token
  String _validateToken() {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;
    
    if (jwtToken == null) {
      throw RestaurantException('Authentication token missing. Please log in again.');
    }
    return jwtToken;
  }

  /// Gets all restaurants with proper error handling and type safety
  Future<List<Restaurant>> getAllRestaurants() async {
    try {
      final jwtToken = _validateToken();
      final url = Uri.parse('${Constants.baseUrl}/restaurant/all');
      
      final response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $jwtToken',
            },
          )
          .timeout(
            timeout,
            onTimeout: () => throw RestaurantException('Request timed out. Please try again.'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        
        // Validate and transform the data
        return jsonList.map((json) {
          try {
            return Restaurant.fromMap(json);
          } catch (e) {
            throw RestaurantException('Invalid restaurant data format: $e');
          }
        }).toList();
      } else {
        throw RestaurantException(
          _handleError(response.statusCode, response.body),
          response.statusCode,
        );
      }
    } on TimeoutException {
      throw RestaurantException('Connection timed out. Please check your internet connection.');
    } on http.ClientException catch (e) {
      throw RestaurantException('Network error: ${e.message}');
    } catch (e) {
      if (e is RestaurantException) rethrow;
      throw RestaurantException('Unexpected error: $e');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olo/utlis/constants.dart';
import 'package:olo/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class UserService {
  Future<String?> registerCoordinates(Map<String, dynamic> userData) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      return 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/register/coordinates');
    try {

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return null; // Success, no error
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
    }
  }

  
  Future<String?> addNewAddress(Map<String, dynamic> userData) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      return 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/register/coordinates');
    try {

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return null; // Success, no error
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
    }
  }

    Future<String?> register(Map<String, dynamic> userData) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      return 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/register');
    try {

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return null; // Success, no error
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
    }
  }

  Future<UserX> getMe() async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/user/me');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        return UserX.fromMap(json.decode(response.body));
      } else {
        print(response.body);
        print(response.statusCode);
        throw Exception('Error fetching user data, try again later.');
      }
    } catch (e) {
      throw Exception('Error fetching user data, try again later. $e');
    }
  }

  Future<UserX> updateUser(Map<String, dynamic> userData) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/user/update');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return UserX.fromMap(json.decode(response.body));
      } else {
        throw Exception('Error fetching user data, try again later.');
      }
    } catch (e) {
      throw Exception('Error fetching user data, try again later.');
    }
  }

  String _handleError(int statusCode, String responseBody) {
    switch (statusCode) {
      case 400:
        return 'Invalid data provided. Please check your input.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred: $statusCode';
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olo/utlis/constants.dart';
import 'package:olo/models/address.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressService {
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
        return null;
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

    final url = Uri.parse('${Constants.baseUrl}/address/create/coordinates');
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
        return null; 
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
    }
  }

  Future<List<Address>> getAddresses() async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/self');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Address.fromMap(e)).toList();
      } else {
        throw _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      throw 'Error fetching user data: $e';
    }
  }

  Future<String?> updateAddress(Map<String, dynamic> userData, String id) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      return 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/$id');
    try {

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
    }
  }

  Future<String?> deleteAddress(String id) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      return 'Authentication token missing. Please log in again.';
    }

    final url = Uri.parse('${Constants.baseUrl}/address/$id');
    try {

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return _handleError(response.statusCode, response.body);
      }
    } catch (e) {
      return 'Error sending user data: $e';
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
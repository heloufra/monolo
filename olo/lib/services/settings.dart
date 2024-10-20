import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olo/utlis/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsService {
  Future<Map<String, dynamic>> getSettings() async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/settings');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load settings');
    }
  }

  Future<void> updatePrivacySettings(
      Map<String, dynamic> privacySettings) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/settings/privacy');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(privacySettings),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update privacy settings');
    }
  }

  Future<void> updateNotificationSettings(
      Map<String, dynamic> notificationSettings) async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/settings/notifications');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(notificationSettings),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update notification settings');
    }
  }

  Future<void> deleteUserAccount() async {
    final supabase = Supabase.instance.client;
    final jwtToken = supabase.auth.currentSession?.accessToken;

    if (jwtToken == null) {
      throw Exception('Authentication token missing. Please log in again.');
    }

    final url = Uri.parse('${Constants.baseUrl}/settings/delete');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user account');
    }
  }
}

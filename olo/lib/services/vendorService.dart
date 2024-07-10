import 'package:http/http.dart' as http;
import 'package:olo/services/authService.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:olo/types/Vendor.dart';


class VendorService {
  final String apiUrl = 'http://127.0.0.1:3000';
  AuthService authService = AuthService();
  final storage = new FlutterSecureStorage();
  // var prefs;
  var token;


  Future<List<Vendor>> getVendors() async {
    token = await storage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('$apiUrl/vendor/all'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
    );
    
    if (response.statusCode == 200) {
      
      List<dynamic> body = json.decode(response.body);
     
      List<Vendor> vendors = body.map((dynamic item) => Vendor.fromJson(item)).toList();
   print(response.body);
 
      return vendors;

    } else {
      throw Exception('Failed to load Restaurants');
    }
  }

}

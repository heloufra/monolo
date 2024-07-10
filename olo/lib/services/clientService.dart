import 'package:http/http.dart' as http;
import 'package:olo/services/authService.dart';
import 'package:olo/types/Address.dart';
import 'package:olo/types/User.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ClientService {
  final String apiUrl = 'http://127.0.0.1:3000';
  AuthService authService = AuthService();
  final storage = new FlutterSecureStorage();
  // var prefs;
  var token;

  ClientService() {
    // prefs = SharedPreferences.getInstance();
    
    

  }

  Future<(bool, String)> newAddressRegister(String name, String address, String phone, double lat, double lon) async {
     token = await storage.read(key: 'jwt');
    final response = await http.post(
      Uri.parse('$apiUrl/client/addresss/newaddressRegister'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
      body: json.encode({'name': name, 'address': address, 'phone': phone, 'latitude': lat, 'longitude': lon}),
    );

    return (response.statusCode == 201 ? true : false, response.body);
  }

  Future<(bool, String)> newAddress(String name, String address) async {
    token = await storage.read(key: 'jwt');
    final response = await http.post(
      Uri.parse('$apiUrl/client/addresss/newaddress'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
      body: json.encode({ 'name': name, 'address': address}),
    );

    return (response.statusCode == 201 ? true : false, response.body);
  }

 Future<List<Address>> getAddress() async {
    token = await storage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('$apiUrl/client/addresss/getAddress'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
    );

    if (response.statusCode == 200) {
       List<dynamic> body = json.decode(response.body);
      List<Address> addresses = body.map((dynamic item) => Address.fromJson(item)).toList();
      return addresses;
    } else {

      return [];
    }
  }

  Future<User> getUser() async {
    token = await storage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('$apiUrl/client/profile'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<(bool, String)> updateAccount(String name, String email, String phone) async {
    token = await storage.read(key: 'jwt');
    final response = await http.put(
      Uri.parse('$apiUrl/client/update'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
      body: json.encode({'name': name, 'email': email, 'phone': phone}),
    );

    return (response.statusCode == 200 ? true : false, response.body);
  }

  Future<(bool, String)> updateAddress(String id, String name, String address) async {
    token = await storage.read(key: 'jwt');
    final response = await http.put(
      Uri.parse('$apiUrl/client/addresss/updateAddress/$id'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
      body: json.encode({'id': id, 'name': name, 'address': address, 'phone': '123'}),
    );

    return (response.statusCode == 200 ? true : false, response.body);
  }

  Future<(bool, String)> notification(bool enable, String preference) async {
    token = await storage.read(key: 'jwt');

    final response = await http.post(
      Uri.parse('$apiUrl/client/notification/update'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
      body: json.encode({'enable': enable, 'preference': preference}),
    );

    return (response.statusCode == 201 ? true : false, response.body);
  }

  Future<(bool, String)> deleteAccount() async {
       token = await storage.read(key: 'jwt');

    final response = await http.post(
      Uri.parse('$apiUrl/client/privacy/deleteAccount'),
      headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${token}'},
    );

    return (response.statusCode == 201 ? true : false, response.body);
  }
}

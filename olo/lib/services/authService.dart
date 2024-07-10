import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthService {
  final String apiUrl = 'http://127.0.0.1:3000';
  static const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
  final storage = new FlutterSecureStorage();
//   if (Platform.isIOS || Platform.isMacOS) {

// }

  AuthService() {
//If current device IOS or MacOS, We have to declare clientID
//Please, look STEP 2 for how to get Client ID for IOS
if (Platform.isIOS || Platform.isMacOS) {
  _googleSignIn = GoogleSignIn(
    clientId:
        "731647113845-hc1hnm4hel8o078jsmam1ppivuq4jfh2.apps.googleusercontent.com",
    scopes: [
      'email',
    ],
  );
}
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      print(googleUser);
      print(googleAuth.accessToken);
    } catch (error) {
      print(error);
    }
  }


  Future<(bool, String)> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );
    print(response.statusCode);
    return (response.statusCode == 201, "Error");
  }

  Future<(bool, String)> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/verifyOtp'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      String token = data['access_token'];

      await storage.write(key: 'jwt', value: token);


      return (true, response.body);
    } else {
      return (false, response.body);
    }
  }
  Future<String> getJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token') ?? '';
  }

  Future<(bool, String)> register(String name, String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/register/email'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email}),
    );

    return response.statusCode == 201 ? (true, '') : (false, response.body);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('jwt_token');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt_token');
  }
}

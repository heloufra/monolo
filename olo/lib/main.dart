import 'package:flutter/material.dart';
import 'package:olo/homepage.dart';
import 'package:olo/pagess/settings/markEntrance.dart';
import 'package:olo/services/authService.dart';
import 'package:olo/pagess/auth/welcome.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   AuthService authService = AuthService();

  bool isLoggedIn = await authService.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
   final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: !isLoggedIn ?  Welcome() :  MyHomePage(),
    );
  }
}

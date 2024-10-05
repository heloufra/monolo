import 'package:flutter/material.dart';
import 'package:olo/screens/auth/login.dart';
import 'package:olo/screens/auth/register.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Image(
              image: AssetImage('assets/images/logo.png'),
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                color: const Color.fromARGB(255, 15, 13, 26),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Order food free and help small businesses in your neighborhood.',
              style: TextStyle(
                color: const Color.fromARGB(255, 15, 13, 26),
                fontSize: 14,
                // fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color.fromARGB(255, 233, 231, 240),
                ),
                padding: const EdgeInsets.fromLTRB(150, 14, 150, 14),
                shadowColor: const Color.fromARGB(255, 73, 70, 89),
                surfaceTintColor: const Color.fromARGB(255, 73, 70, 89),
                overlayColor: const Color.fromARGB(255, 73, 70, 89),
                foregroundColor: const Color.fromARGB(255, 15, 13, 26),
                iconColor: const Color.fromARGB(255, 73, 70, 89),
              ),
              child: const Text('Sign in'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color.fromARGB(255, 233, 231, 240),
                ),
                padding: const EdgeInsets.fromLTRB(150, 14, 150, 14),
                shadowColor: const Color.fromARGB(255, 73, 70, 89),
                surfaceTintColor: const Color.fromARGB(255, 73, 70, 89),
                overlayColor: const Color.fromARGB(255, 73, 70, 89),
                foregroundColor: const Color.fromARGB(255, 15, 13, 26),
                iconColor: const Color.fromARGB(255, 73, 70, 89),
              ),
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

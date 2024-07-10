import 'package:flutter/material.dart';
import 'package:olo/services/authService.dart';
import 'package:olo/components/apple.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/components/email_textfield.dart';
import 'package:olo/components/google.dart';
import 'package:olo/components/name_textfield.dart';
import 'package:olo/pagess/auth/login.dart';
import 'package:olo/pagess/auth/otp.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final AuthService authService = AuthService();
  bool showError = false;
  String errorMessage = '';
  bool enable = false;
  bool isLoading = false;

  Future<void> signUserUp() async {
    if (enable) {
      setState(() {
        enable = false;
        isLoading = true;
      });
      var (success, msg) = await authService.register(
          usernameController.text, emailController.text);

      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtpPage(email: emailController.text, isRegister: true)),
        );
      } else {
        setState(() {
          showError = true;
          errorMessage = msg;
        });
      }
    }
  }

  usernameChange(String username) {
    if (username.isEmpty || emailController.text.isEmpty) {
      setState(() {
        enable = false;
      });
      return;
    }
  }

  emailChange(String email) {
    setState(() {
      showError = false;
      errorMessage = '';
    });
    if (email.isEmpty || usernameController.text.isEmpty) {
      setState(() {
        enable = false;
      });
      return;
    }

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      setState(() {
        enable = true;
      });
      return;
    } else {
      setState(() {
        enable = false;
      });
      return;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    setState(() {
      showError = false;
      errorMessage = '';
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 100,
              ),

              const Text(
                "Let’s get started.",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 15, 13, 26)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please enter your name and email address below to get started.',
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color.fromARGB(255, 15, 13, 26)),
              ),

              const SizedBox(height: 25),
              new NameTextField(
                controller: usernameController,
                hintText: 'Name',
                obscureText: false,
                onChanged: usernameChange,
              ),
              const SizedBox(height: 16),

              // username textfield
              EmailTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                onChanged: emailChange,
              ),
              const SizedBox(height: 16),

              // show error
              showError
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : const SizedBox(),

              const SizedBox(height: 24),
              const Text(
                'Or continue with',
                style: TextStyle(color: const Color.fromARGB(255, 15, 13, 26)),
              ),
              const SizedBox(height: 24),

              Google(onTap: null),
              const SizedBox(height: 12),
              Apple(onTap: null),

              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  'Already have an accont?',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 15, 13, 26),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(
            onTap: enable
                ? () async {
                    await signUserUp();
                  }
                : null,
            enable: enable,
            textbutton: 'Continue'),
        elevation: 0,
      ),
    );
  }
}

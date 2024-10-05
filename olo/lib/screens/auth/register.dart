import 'package:flutter/material.dart';
import 'package:olo/main.dart';
import 'package:olo/components/apple.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/components/email_textfield.dart';
import 'package:olo/components/google.dart';
import 'package:olo/components/name_textfield.dart';
import 'package:olo/screens/auth/login.dart';
import 'package:olo/screens/auth/otp.dart';
import 'package:olo/utlis/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  bool enable = false;
  bool isLoading = false;

  Future<void> _signUpSupabse() async {
    if (!enable) return;

    setState(() {
      enable = false;
      isLoading = true;
    });

    try {
      await supabase.auth.signInWithOtp(
          email: emailController.text.trim(),
          data: {"name": usernameController.text.trim(), "role": "CUSTOMER"});

      if (mounted) {
        showToast(context, "Check Your Email", "we have sent OTP",
            ToastificationType.success);
        String email = emailController.text.trim();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtpPage(email: email, isRegister: true)),
        );
      }
    } on AuthException catch (error) {
      if (mounted) {
        showToast(context, "Error", error.message, ToastificationType.error);
      }
    } catch (error) {
      if (mounted) {
        showToast(context, "Error", "Unexpected error occurred, try later.",
            ToastificationType.error);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
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
                    await _signUpSupabse();
                  }
                : null,
            enable: enable,
            textbutton: 'Continue'),
        elevation: 0,
      ),
    );
  }
}

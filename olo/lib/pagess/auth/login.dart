import 'package:flutter/material.dart';
import 'package:olo/main.dart';
import 'package:olo/pagess/auth/otp.dart';
import 'package:olo/components/apple.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/components/google.dart';
import 'package:olo/components/email_textfield.dart';
import 'package:olo/pagess/auth/register.dart';
import 'package:olo/utlis/toast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  bool enable = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _signInSupabse() async {
    if (!enable) return;

    setState(() {
      enable = false;
      isLoading = true;
    });

    try {
        await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        shouldCreateUser: false
      );

      if (mounted) {
        showToast(context, "Check Your Email", "we have sent OTP", ToastificationType.success);
        String email = _emailController.text.trim();
         Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtpPage(email: email, isRegister: false)),
        );
      }
    } on AuthException catch (error) {
      if (mounted) {
        if (error.statusCode == "422") {
          showToast(context, "Error", "no user with this email exists", ToastificationType.error);
        } else {
          showToast(context, "Error", error.message, ToastificationType.error);
        }
        
      }
    } catch (error) {
      if (mounted) {
        showToast(context, "Error", "Unexpected error occurred, try later.", ToastificationType.error);
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  Future<void> signInWithGoogle() async {
  }

  emailChange(String email) {

    if (email.isEmpty) {
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
    // _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),

            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 150,
            ),

            const Text(
              'Sign in.',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 13, 26)),
            ),

            const SizedBox(height: 16),

            const Text(
              'Please enter your email address below to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 15, 13, 26)),
            ),

            const SizedBox(height: 25),

            // username textfield
            EmailTextField(
              controller: _emailController,
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

            Google(onTap: signInWithGoogle),
            const SizedBox(height: 12),
            Apple(onTap: null),

            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text(
                'Create new account!',
                style: TextStyle(
                  color: const Color.fromARGB(255, 15, 13, 26),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(
            onTap: enable
                ? () async {
                    await _signInSupabse();
                  }
                : null,
            enable: enable,
            textbutton: 'Continue'),
        elevation: 0,
      ),
    );
  }
}

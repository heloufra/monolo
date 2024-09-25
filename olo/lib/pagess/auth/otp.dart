import 'package:flutter/material.dart';
import 'package:olo/homepage.dart';
import 'package:olo/main.dart';
import 'package:olo/pagess/settings/saveAddress.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/pagess/auth/login.dart';
import 'package:olo/utlis/toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

class OtpPage extends StatefulWidget {
  final String email;
  final bool isRegister;

  OtpPage({required this.email, required this.isRegister});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  int timer = 60;
  bool enable = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = 60;
    Future.doWhile(() async {
      if (timer > 0) {
        await Future.delayed(const Duration(seconds: 1));
        if (mounted)
          setState(() {
            timer--;
          });

        return true;
      }
      showToast(context, "Time ended", "OTP is no longer valid send another one again", ToastificationType.warning);
      return false;
    });
  }

  Future<void> _resendOtp() async {
    try {
      if (widget.isRegister) {
        await supabase.auth.resend(
          type: OtpType.signup,
          email: widget.email,
        );
      } else {
        await supabase.auth.resend(
          type: OtpType.magiclink,
          email: widget.email,
        );
      }
    } on AuthException catch (error) {
      showToast(context, "Error", error.message, ToastificationType.error);
    } catch (error) {
      showToast(context, "Error", "Unexpected error occurred, try later.",
          ToastificationType.error);
    } finally {
      startTimer();
    }
  }

  Future<bool> _verifyOtpSupabase() async {
    setState(() {
      isLoading = false;
      enable = false;
    });

    try {
      if (!widget.isRegister) {
        await supabase.auth.verifyOTP(
            type: OtpType.magiclink,
            token: otpController.text,
            email: widget.email);
      } else {
        await supabase.auth.verifyOTP(
            type: OtpType.signup,
            token: otpController.text,
            email: widget.email);
      }

      if (widget.isRegister) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SaveAddressPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } on AuthException catch (error) {
      showToast(context, "Error", error.message, ToastificationType.error);
    } catch (error) {
      showToast(context, "Error", "Unexpected error occurred, try later.",
          ToastificationType.error);
    } finally {
      setState(() {
        isLoading = false;
        enable = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 150,
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Enter OTP code.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Enter the 4-digit code sent to your email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  TextButton(
                    onPressed: timer == 0 ? _resendOtp : null,
                    child: Text(
                      'Didn\'t get the code? Resend',
                      style: TextStyle(
                          color: timer == 0 ? Colors.blue : Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 40,
                        activeFillColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledBorderWidth: 1,
                        activeColor: Colors.grey,
                        selectedColor: Colors.grey,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: const Color.fromARGB(255, 202, 200, 200),
                      ),
                      mainAxisAlignment: MainAxisAlignment.start,
                      animationDuration: const Duration(milliseconds: 300),
                      controller: otpController,
                      onCompleted: (v) {
                        setState(() {
                          enable = true;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          enable = false;
                        });
                      },
                      appContext: context,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  // white container
                  Container(
                    height: 40,
                    width: 84,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        timer > 0
                            ? '00:${timer.toString().padLeft(2, '0')}'
                            : '00:00',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Change email address?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
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
                    await _verifyOtpSupabase();
                  }
                : null,
            enable: enable,
            textbutton: 'Continue'),
        elevation: 0,
      ),
    );
  }
}

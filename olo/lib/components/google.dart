import 'package:flutter/material.dart';

class Google extends StatelessWidget {
  final Function()? onTap;

  const Google({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // minimumSize: Size(319, 48),
         minimumSize: Size(369, 58),
      ),
      onPressed: () {
        onTap!();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Image(
            //   image: AssetImage("assets/images/google.png"),
            //   // height: 18.0,
            //   width: 24,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

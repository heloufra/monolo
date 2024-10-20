import 'package:flutter/material.dart';

class Continue extends StatelessWidget {
  final Function()? onTap;
  final bool enable;
  final String textbutton;

  const Continue({super.key, required this.onTap, required this.enable, required this.textbutton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(27, 14, 27, 14),
            decoration: BoxDecoration(
              color: enable ? Colors.black : Colors.grey,
              borderRadius: BorderRadius.circular(250),
            ),
            child:  Center(
              child: Text(
                textbutton,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
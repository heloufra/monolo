import 'package:flutter/material.dart';

Widget SaveButton({
  required VoidCallback onPressed,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 3, 14, 24),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(25),
      textStyle: const TextStyle(fontSize: 15),
    ),
    onPressed: onPressed,
    child: Container(
      width: double.infinity,
      child: Center(
        child: const Text('Save'),
      ),
    ),
  );
}

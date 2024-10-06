import 'package:flutter/material.dart';

Widget simpleListTile(
  String title,
  String subtitle,
  VoidCallback onPressed,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    margin: const EdgeInsets.only(bottom: 8.0),
    child: ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.black,
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

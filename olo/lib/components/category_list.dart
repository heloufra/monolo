import 'package:flutter/material.dart';

Widget categoryList({
  required BuildContext context,
  required Widget catImage,
  required String title,
  required String subtitle,
  required Widget page,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: ListTile(
        shape: const BeveledRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: catImage,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        dense: true,
        trailing: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
    ),
  );
}

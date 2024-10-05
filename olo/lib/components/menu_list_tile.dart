import 'package:flutter/material.dart';

Widget customListTile({
  required BuildContext context,
  required String title,
  required Widget page,
}) {
  return ListTile(
    leading: const Icon(
      Icons.shopping_bag_outlined,
      color: Colors.black,
      size: 20,
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';

Widget addButton({
  required BuildContext context,
  required String title,
  required Widget page,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
            size: 20,
          ),
        ),
        Text(title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
      ],
    ),
  );
}

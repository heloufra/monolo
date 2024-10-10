import 'package:flutter/material.dart';

Widget OrderListItem({
  required Widget image,
  required String title,
  required String price,
  required GestureTapCallback onTap,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: image,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          price,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    ),
  );
}

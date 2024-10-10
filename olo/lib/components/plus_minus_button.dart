import 'package:flutter/material.dart';

Widget PlusMinusButton({
  required int count,
  required VoidCallback onPressedPlus,
  required VoidCallback onPressedMinus,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.only(bottom: 8),
              icon: Icon(
                Icons.minimize,
                color: Colors.black,
              ),
              onPressed: onPressedMinus,
            ),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: onPressedPlus,
            ),
          ),
        ),
      ],
    ),
  );
}

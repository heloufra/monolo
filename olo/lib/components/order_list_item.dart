import 'package:flutter/material.dart';
import 'package:olo/components/plus_minus_button.dart';

Widget OrderListItem({
  required Widget image,
  required String title,
  required String price,
  required int count,
  required GestureTapCallback onTap,
  required VoidCallback onPressedPlus,
  required VoidCallback onPressedMinus,
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
        contentPadding: EdgeInsets.only(left: 8),
        trailing: count == 0
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
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
              )
            : PlusMinusButton(
                count: count,
                onPressedPlus: onPressedPlus,
                onPressedMinus: onPressedMinus,
              ),
      ),
    ),
  );
}

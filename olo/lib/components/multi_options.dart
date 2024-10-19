import 'package:flutter/material.dart';

Widget multiOptions({
  required String title,
  required int price,
  required List<String> options,
  required List<String> selectedOptions,
  required ValueChanged<String?> onOptionChangedTrue,
  required ValueChanged<String?> onOptionChangedFalse,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...options.map((String option) {
              return Column(
                children: [
                  CheckboxListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "+$price Dhs",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    value: selectedOptions.contains(option),
                    onChanged: (bool? isChecked) {
                      if (isChecked!) {
                        onOptionChangedTrue(option);
                      } else {
                        onOptionChangedFalse(option);
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  if (option != options.last)
                    Container(
                      color: Colors.grey,
                      height: 0.3,
                    ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    ],
  );
}

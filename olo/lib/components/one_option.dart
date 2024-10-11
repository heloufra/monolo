import 'package:flutter/material.dart';

Widget oneOption({
  required String title,
  required int price,
  required List<String> options,
  required String? selectedOption,
  required ValueChanged<String?> onOptionChanged,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              return Column(
                children: [
                  RadioListTile<String>(
                    activeColor: Colors.black,
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
                    value: option,
                    groupValue: selectedOption,
                    onChanged: onOptionChanged,
                  ),
                  if (idx != options.length - 1)
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

import 'package:flutter/material.dart';
import 'package:olo/components/order_list_item.dart';
import 'package:olo/screens/pass_on_order/meal_details.dart';

String mealName = 'Classic Burger';
int mealCount = 0;

class AddOrderContent extends StatefulWidget {
  const AddOrderContent({super.key});

  @override
  State<AddOrderContent> createState() => _AddOrderContentState();
}

class _AddOrderContentState extends State<AddOrderContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          OrderListItem(
              image: Icon(
                Icons.fastfood,
                size: 30,
              ),
              title: mealName,
              price: '28 Dhs',
              count: mealCount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MealDetails(),
                  ),
                );
              },
              onPressedMinus: () {
                setState(() {
                  mealCount--;
                });
              },
              onPressedPlus: () {
                setState(() {
                  mealCount++;
                });
              }),
        ],
      ),
    );
  }
}

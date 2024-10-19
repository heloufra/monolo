import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/components/order_list_item.dart';
import 'package:olo/screens/restaurants/meal_details.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              OrderListItem(
                image: Icon(
                  Icons.fastfood,
                  size: 30,
                ),
                title: mealName,
                price: '27 Dhs',
                count: mealCount,
                onTap: () {
                   context.go("/restaurants/dish/details");
                },
                onPressedMinus: () {
                  setState(() {
                    mealCount--;
                  });
                },
                onPressedPlus: () {
                  context.go("/restaurants/dish/details");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/screens/pass_on_order/add_order.dart';
import 'package:olo/components/plus_minus_button.dart';

String mealName = 'Classic Burger';
int mealCount = 0;

class MealDetails extends StatefulWidget {
  const MealDetails({super.key});

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          title: Text(
            mealName,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.go("/restaurants/dish/details");
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Icon(Icons.fastfood, size: 180),
              ),
              ListTile(
                title: Text(
                  mealName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '28 Dhs',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                trailing: mealCount == 0
                    ? Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    : PlusMinusButton(
                        count: mealCount,
                        onPressedPlus: () {
                          setState(() {
                            mealCount++;
                          });
                        },
                        onPressedMinus: () {
                          setState(() {
                            mealCount--;
                          });
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'The Description',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

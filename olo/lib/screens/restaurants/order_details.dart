import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/components/one_option.dart';
import 'package:olo/components/multi_options.dart';
import '../admin_dashboard/options_page.dart' show options;

import 'package:olo/screens/restaurants/add_order_content.dart'
    show mealName, mealCount;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<String> saucess = ['Ketchup', 'Mayo', 'Mustard'];
  String? selectedOption;
  String? selectedSauce;
  List<String> selectedOptions = [];
  List<String> selectedExtras = [
    'Extra Cheese',
    'Extra Bacon',
    'Extra Pickles'
  ];
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                oneOption(
                  title: 'Select Size',
                  price: 0,
                  options: options,
                  selectedOption: selectedOption,
                  onOptionChanged: (String? value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                oneOption(
                  title: 'Select Sauce',
                  price: 0,
                  options: saucess,
                  selectedOption: selectedSauce,
                  onOptionChanged: (String? value) {
                    setState(() {
                      selectedSauce = value;
                    });
                  },
                ),
                multiOptions(
                  title: 'Add Extras',
                  price: 0,
                  options: options,
                  selectedOptions: selectedOptions,
                  onOptionChangedTrue: (String? value) {
                    setState(() {
                      selectedOptions.add(value!);
                    });
                  },
                  onOptionChangedFalse: (String? value) {
                    setState(() {
                      selectedOptions.remove(value!);
                    });
                  },
                ),
                SizedBox(height: 50),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 14, 24),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(25),
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    setState(() {
                      mealCount++;
                    });
                  },
                  child: GestureDetector(
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: const Text('Add to Cart'),
                      ),
                      
                    ),
                    onTap: () {
                       context.go("/restaurants/dish/details");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

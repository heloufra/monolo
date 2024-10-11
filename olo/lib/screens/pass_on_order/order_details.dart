import 'package:flutter/material.dart';
import 'package:olo/screens/pass_on_order/add_order.dart';
import 'package:olo/components/one_option.dart';
import '../admin_dashboard/options_page.dart' show options;
import 'package:olo/screens/pass_on_order/add_order_content.dart' show mealName;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddOrder(),
                  ),
                );
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: oneOption(
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
        ),
      ),
    );
  }
}

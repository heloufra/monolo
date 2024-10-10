import 'package:flutter/material.dart';
import 'package:olo/components/order_list_item.dart';

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
            title: 'Classic Burger',
            price: '28 Dhs',
            onTap: () {},
            onPressed: () {},
          ),
          OrderListItem(
            image: Icon(
              Icons.fastfood,
              size: 30,
            ),
            title: 'Aristoctate Burger',
            price: '26 Dhs',
            onTap: () {},
            onPressed: () {},
          ),
          OrderListItem(
            image: Icon(
              Icons.fastfood,
              size: 30,
            ),
            title: 'Bacon and Cheese',
            price: '25 Dhs',
            onTap: () {},
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

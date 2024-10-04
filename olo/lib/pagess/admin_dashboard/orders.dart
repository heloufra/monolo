import 'package:flutter/material.dart';
import 'drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        width: 270,
        child: DrawerPage(),
      ),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        leadingWidth: 25,
        title: const Text(
          'Ordres',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}

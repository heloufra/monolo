import 'package:flutter/material.dart';
import 'drawer.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: DrawerPage(),
      ),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        leadingWidth: 25,
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}

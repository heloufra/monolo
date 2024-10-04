import 'package:flutter/material.dart';
import 'drawer.dart';

class Availablity extends StatefulWidget {
  const Availablity({super.key});

  @override
  State<Availablity> createState() => _AvailablityState();
}

class _AvailablityState extends State<Availablity> {
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
          'Availablity',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}

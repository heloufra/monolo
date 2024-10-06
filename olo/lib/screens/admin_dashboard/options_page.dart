import 'package:flutter/material.dart';
import 'item_details.dart' show modifierName;

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          leadingWidth: 25,
          title: Text(
            modifierName,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

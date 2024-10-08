import 'package:flutter/material.dart';

class ItemEdit extends StatefulWidget {
  const ItemEdit({super.key});

  @override
  State<ItemEdit> createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          
          Text('Hello World'),
          Container(),
        ],
      ),
    );
  }
}
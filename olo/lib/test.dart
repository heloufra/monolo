import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int itemCount;

  const CustomBottomNavBar({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          SizedBox(width: 48), // Space for the floating button
          IconButton(icon: Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final int itemCount = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Center(child: Text('App Content')),
      bottomNavigationBar: CustomBottomNavBar(itemCount: 1),
      floatingActionButton: FloatingActionButton(
        child: itemCount > 0 
          ? Text('$itemCount', style: TextStyle(fontSize: 22))
          : Text('Olo', style: TextStyle(fontSize: 16)),
        onPressed: () {
          // Handle button press
        },
        backgroundColor: Colors.black87,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
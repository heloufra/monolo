import 'package:flutter/material.dart';
import 'package:olo/screens/restaurants/dish.dart';

class MenuTab extends StatefulWidget {
  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  @override
  Widget build(BuildContext context) {
    // Menu tab implementation (unchanged)
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        childAspectRatio: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildMenuItem('Pizza',
              'https://img.icons8.com/color/48/000000/pizza.png'), // Pizza icon
          _buildMenuItem('Burgers',
              'https://img.icons8.com/color/48/000000/hamburger.png'), // Burgers icon
          _buildMenuItem('Sandwiches',
              'https://img.icons8.com/color/48/000000/sandwich.png'), // Sandwich icon
          _buildMenuItem('Tacos',
              'https://img.icons8.com/color/48/000000/taco.png'), // Tacos icon
          _buildMenuItem('Pasta',
              'https://img.icons8.com/color/48/000000/pasta.png'), // Pasta icon
          _buildMenuItem('Salad',
              'https://img.icons8.com/color/48/000000/salad.png'), // Salad icon
          _buildMenuItem('Drinks',
              'https://img.icons8.com/color/48/000000/drinks.png'), // Drinks icon
          _buildMenuItem('Tea',
              'https://img.icons8.com/color/48/000000/tea.png'), // Tea icon
        ],
      ),
    );
  }

 Widget _buildMenuItem(String name, String imageUrl) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Dish()));
    },
    child: Container(
      width: 162.0, // Set the width
      height: 162.0, // Set the height
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(6.0), // Corner radius
        border: Border.all(
          color: Colors.black, // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0), // Match the container's radius
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
}

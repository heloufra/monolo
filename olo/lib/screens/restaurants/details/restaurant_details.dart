import 'package:flutter/material.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/details/about.dart';
import 'package:olo/screens/restaurants/dish.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String id;
  final String restaurantName;
  final String logoUrl;
  final Restaurant restaurant;

  RestaurantDetailsScreen({
    required this.id,
    required this.restaurantName,
    required this.logoUrl,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(restaurantName,
              style: TextStyle(color: Colors.black, fontSize: 24)),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Menu'),
              Tab(text: 'About'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          children: [
            MenuTab(),
            AboutTab(restaurant: restaurant),
          ],
        ),
      ),
    );
  }
}

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
              'https://img.icons8.com/color/100/000000/pizza.png'), // Pizza icon
          _buildMenuItem('Burgers',
              'https://img.icons8.com/color/100/000000/hamburger.png'), // Burgers icon
          _buildMenuItem('Sandwiches',
              'https://img.icons8.com/color/100/000000/sandwich.png'), // Sandwich icon
          _buildMenuItem('Tacos',
              'https://img.icons8.com/color/100/000000/taco.png'), // Tacos icon
          _buildMenuItem('Salad',
              'https://img.icons8.com/color/100/000000/salad.png'), // Salad icon
          _buildMenuItem(
              'Tea', 'https://img.icons8.com/color/100/000000/tea.png'), // Te
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
            color: Color.fromRGBO(243, 244, 248, 1), // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(6.0), // Match the container's radius
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

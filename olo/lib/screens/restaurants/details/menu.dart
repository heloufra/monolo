import 'package:flutter/material.dart';
import 'package:olo/models/dish.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/details/dish.dart';


class MenuTab extends StatefulWidget {
  Restaurant restaurant;

  MenuTab({required this.restaurant});
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
          ... widget.restaurant.dishes?.map((dish) => _buildMenuItem(dish, dish.name, dish.pictures[0])).toList() ?? [],
        ],
      ),
    );
  }

  Widget _buildMenuItem(Dish dish, String name, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DishScreen(dish: dish)));
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

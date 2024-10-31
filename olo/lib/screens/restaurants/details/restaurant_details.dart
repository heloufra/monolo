import 'package:flutter/material.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/details/about.dart';
import 'package:olo/screens/restaurants/details/menu.dart';

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
            MenuTab(restaurant: restaurant),
            AboutTab(restaurant: restaurant),
          ],
        ),
      ),
    );
  }
}


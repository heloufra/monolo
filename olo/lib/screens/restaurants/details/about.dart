import 'package:flutter/material.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/details/image_carouse.dart';
import 'package:olo/screens/restaurants/details/info.dart';


class AboutTab extends StatelessWidget {
  final Restaurant restaurant;

  AboutTab({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RestaurantInfoWidget(restaurant: restaurant),
            SizedBox(height: 16),
            ImageCarousel(images: restaurant.pictures ?? []),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                restaurant.description ?? '',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

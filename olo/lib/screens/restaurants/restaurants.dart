import 'package:flutter/material.dart';
import 'package:olo/models/mockRestaurants.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/restaurant_details.dart';

class RestaurantScreen extends StatelessWidget {
  final String selectedAddress =
      "Residence Le Rubis, Boulevard du 18 Novembre, Marrakech Maroc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Restaurants',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Address bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 24, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedAddress,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Restaurant list
          Expanded(
            child: FutureBuilder<List<Restaurant>>(
              future: MockDataService.getRestaurants(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print("error");

                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No restaurants found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final restaurant = snapshot.data![index];
                      return RestaurantWidget(
                        name: restaurant.name,
                        description:
                            'A great place to eat!', // You might want to add a description field to your Restaurant model
                        distance:
                            '${(index + 1) * 100} meters', // This is mock data, you'd calculate this in a real app
                        deliveryTime:
                            '${20 + (index * 5)}-${35 + (index * 5)} min',
                        deliveryFee: 'Free Delivery',
                        imagePath: restaurant.pictures?[0] ??
                            'https://via.placeholder.com/150',
                        logoPath:
                            'https://cdn-icons-png.flaticon.com/512/3081/3081692.png', // You might want to add a logo field to your Restaurant model
                        restaurant: restaurant,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   // backgroundColor: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(icon: Icon(Icons.home), onPressed: () {}),
      //       IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
      //       SizedBox(width: 32), // Space for the FAB
      //       IconButton(icon: Icon(Icons.shopping_bag), onPressed: () {}),
      //       IconButton(icon: Icon(Icons.person), onPressed: () {}),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: Text('OLO', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      //   onPressed: () {},
      //   backgroundColor: Colors.black,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  final String name;
  final String description;
  final String distance;
  final String deliveryTime;
  final String deliveryFee;
  final String imagePath;
  final String logoPath;
  final Restaurant restaurant;

  const RestaurantWidget({
    Key? key,
    required this.name,
    required this.description,
    required this.distance,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.imagePath,
    required this.logoPath,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsScreen(
              restaurantName: name,
              logoUrl: logoPath,
              restaurant: restaurant,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant image with logo
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: -20,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.network(
                        logoPath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant name
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  // Restaurant description
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  // Delivery details row
                  Row(
                    children: [
                      _buildInfoChip(
                          deliveryFee, Colors.green[50]!, Colors.green[700]!),
                      SizedBox(width: 8),
                      _buildInfoChip(
                          deliveryTime, Colors.grey[200]!, Colors.black),
                      SizedBox(width: 8),
                      _buildInfoChip(distance, Colors.grey[200]!, Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}

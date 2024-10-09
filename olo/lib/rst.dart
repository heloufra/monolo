import 'package:flutter/material.dart';
import 'package:olo/rstd.dart';

class RestaurantScreen extends StatelessWidget {
  final String selectedAddress =
      "Residence Le Rubis, Boulevard du 18 Novembre, Marrakech Maroc.";

  final List<Map<String, String>> restaurants = [
    {
      'name': 'Mediterranean Delights',
      'description':
          'Welcome to our fish restaurant, where we pride ourselves on serving the freshest and most delicious seafood dishes in town.',
      'distance': '246 meters',
      'deliveryTime': '20-35 min',
      'deliveryFee': 'Free Delivery',
      'image':
          'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80',
      'logo':
          'https://cdn-icons-png.flaticon.com/512/3081/3081692.png'
    },
    {
      'name': 'Pasta House',
      'description':
          'Welcome to our fish restaurant, where we pride ourselves on serving the freshest and most delicious seafood dishes in town.',
      'distance': '300 meters',
      'deliveryTime': '25-40 min',
      'deliveryFee': 'Free Delivery',
      'image':
          'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=800&q=80',
      'logo':
          'https://cdn-icons-png.flaticon.com/512/3081/3081692.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
            child: ListView.builder(
              
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantWidget(
                  name: restaurant['name']!,
                  description: restaurant['description']!,
                  distance: restaurant['distance']!,
                  deliveryTime: restaurant['deliveryTime']!,
                  deliveryFee: restaurant['deliveryFee']!,
                  imagePath: restaurant['image']!,
                  logoPath: restaurant['logo']!,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
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

  const RestaurantWidget({
    Key? key,
    required this.name,
    required this.description,
    required this.distance,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.imagePath,
    required this.logoPath,
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
                      _buildInfoChip(deliveryFee, Colors.green[50]!, Colors.green[700]!),
                      SizedBox(width: 8),
                      _buildInfoChip(deliveryTime, Colors.grey[200]!, Colors.black),
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
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/providers/restaurant.dart';
import 'package:olo/screens/restaurants/address.dart';
import 'package:provider/provider.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/screens/restaurants/details/restaurant_details.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final String selectedAddress =
      "Residence Le Rubis, Boulevard du 18 Novembre, Marrakech Maroc.";

  @override
  void initState() {
    super.initState();
    // Fetch restaurants only if needed when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RestaurantProvider>().fetchRestaurantsIfNeeded();
      context.read<AddressProvider>().fetchAddressesIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
          child: const Text('Restaurants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.3), // Height of the border
          child: Container(
            color: Colors.grey, // Border color
            height: 0.3, // Border height
          ),
        ),
      ),
      body: Column(
        children: [
          // Address bar (unchanged)
          AddressWidget(),
          const SizedBox(height: 16),
          // Restaurant list
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.error != null) {
                  return Center(child: Text('Error: ${provider.error}'));
                } else if (provider.restaurants == null ||
                    provider.restaurants!.isEmpty) {
                  return Center(child: Text('No restaurants found'));
                } else {
                  return ListView.builder(
                    itemCount: provider.restaurants!.length,
                    itemBuilder: (context, index) {
                      final restaurant = provider.restaurants![index];
                      return RestaurantWidget(
                        id: restaurant.id,
                        name: restaurant.name,
                        description: restaurant.description ?? '',
                        distance: '${(index + 1) * 100} meters',
                        deliveryTime:
                            '${20 + (index * 5)}-${35 + (index * 5)} min',
                        deliveryFee: 'Free Delivery',
                        imagePath: restaurant.pictures?[0] ??
                            'https://via.placeholder.com/150',
                        logoPath:
                            'https://cdn-icons-png.flaticon.com/512/3081/3081692.png',
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
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  final String id;
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
    required this.id,
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
              id: id,
              restaurantName: name,
              logoUrl: logoPath,
              restaurant: restaurant,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 4,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    imagePath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Restaurant details
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16, 40, 16, 16), // Moved down to fit logo positioning
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant name
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      // Restaurant description
                      Text(
                        description,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),
                      // Delivery details row
                      Row(
                        children: [
                          _buildInfoChip(
                              "Free Delivery", Colors.green[50]!, Colors.black),
                          SizedBox(width: 8),
                          _buildInfoChip(
                              distance, Colors.grey[200]!, Colors.black),
                          SizedBox(width: 8),
                          _buildInfoChip(
                              deliveryTime, Colors.grey[200]!, Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned logo at center-left, half on image and half on text
            Positioned(
              left: 16,
              top: 140, // Adjusted to place the logo between the image and text
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Colors.black, width: 2), // Black border
                ),
                child: CircleAvatar(
                  radius: 36, // Adjusted size of the logo
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.network(
                      logoPath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: textColor, fontWeight: FontWeight.normal, fontSize: 12),
      ),
    );
  }
}

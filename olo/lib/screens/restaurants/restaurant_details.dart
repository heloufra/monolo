import 'package:flutter/material.dart';
import 'package:olo/models/restaurant.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantName;
  final String logoUrl;
  final Restaurant restaurant;

  RestaurantDetailsScreen({
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
          title: Text(restaurantName, style: TextStyle(color: Colors.black, fontSize: 24)),
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

class MenuTab extends StatelessWidget {
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
          _buildMenuItem('Pizza', 'https://via.placeholder.com/150?text=Pizza'),
          _buildMenuItem('Burgers', 'https://via.placeholder.com/150?text=Burgers'),
          _buildMenuItem('Sandwiches', 'https://via.placeholder.com/150?text=Sandwiches'),
          _buildMenuItem('Tacos', 'https://via.placeholder.com/150?text=Tacos'),
          _buildMenuItem('Pasta', 'https://via.placeholder.com/150?text=Pasta'),
          _buildMenuItem('Salad', 'https://via.placeholder.com/150?text=Salad'),
          _buildMenuItem('Drinks', 'https://via.placeholder.com/150?text=Drinks'),
          _buildMenuItem('Tea', 'https://via.placeholder.com/150?text=Tea'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String imageUrl) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

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

class RestaurantInfoWidget extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantInfoWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(restaurant.pictures?.first ?? 'https://via.placeholder.com/60?text=Logo'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip('Free Delivery', Colors.green[50]!, Colors.green[700]!),
                    _buildInfoChip('20-35 min', Colors.grey[200]!, Colors.black),
                    _buildInfoChip('246 meters', Colors.grey[200]!, Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  ImageCarousel({required this.images});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Positioned(
          bottom: 8,
          left: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String restaurantName;
  final String logoUrl;

  RestaurantDetailsScreen({
    required this.restaurantName,
    required this.logoUrl,
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
            AboutTab(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
              SizedBox(width: 32), // Space for the FAB
              IconButton(icon: Icon(Icons.shopping_bag), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('OLO', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {},
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class MenuTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      childAspectRatio: 1,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildMenuItem('Pizza', 'https://via.placeholder.com/150?text=Pizza'),
        _buildMenuItem('Burgers', 'https://via.placeholder.com/150?text=Burgers'),
        _buildMenuItem('Sandwichs', 'https://via.placeholder.com/150?text=Sandwichs'),
        _buildMenuItem('Tacos', 'https://via.placeholder.com/150?text=Tacos'),
        _buildMenuItem('Pasta', 'https://via.placeholder.com/150?text=Pasta'),
        _buildMenuItem('Salad', 'https://via.placeholder.com/150?text=Salad'),
        _buildMenuItem('Drinks', 'https://via.placeholder.com/150?text=Drinks'),
        _buildMenuItem('Tea', 'https://via.placeholder.com/150?text=Tea'),
      ],
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantInfoWidget(),
          SizedBox(height: 16),
          Text(
            'Founded over 50 years ago, Ristorante Adria is probably the oldest Italian specialty restaurant in Karlsruhe. Since February 1, 2020, Felice and Giuseppe have taken over the Adria restaurant. They will continue the concept of Italian cuisine and thus maintain the Italian charm of the restaurant.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class RestaurantInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://via.placeholder.com/60?text=Logo'),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fish Magic', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildInfoChip('Free Delivery', Colors.green[50]!, Colors.green[700]!),
                  SizedBox(width: 8),
                  _buildInfoChip('20-35 min', Colors.grey[200]!, Colors.black),
                  SizedBox(width: 8),
                  _buildInfoChip('246 meters', Colors.grey[200]!, Colors.black),
                ],
              ),
            ],
          ),
        ),
      ],
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
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/logo.png'), // Update with actual image path
          ),
          SizedBox(height: 10),
          Text(
            'Khalid Fadil',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'khalidfadil@icloud.com',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text('Account'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Account Page
            },
          ),
          ListTile(
            title: Text('Address'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Address Page
            },
          ),
          ListTile(
            title: Text('Notifications'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Notifications Page
            },
          ),
          ListTile(
            title: Text('Privacy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Privacy Page
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
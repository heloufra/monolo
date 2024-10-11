import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/go.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'OLO Food Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final int itemCount = 0;
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Restaurants'),
          NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Orders'),
          // SizedBox(width: 48),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Notifications'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: _goBranch,
      ),
      floatingActionButton: FloatingActionButton(
        child: itemCount > 0 
          ? Text('$itemCount', style: TextStyle(fontSize: 22, color: Colors.white))
          : Text('Olo', style: TextStyle(fontSize: 16, color: Colors.white)),
        onPressed: () {
          // Handle button press
        },
        backgroundColor: Colors.black87,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
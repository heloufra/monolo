import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/models/mockRestaurants.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/models/user.dart';
import 'package:olo/services/user.dart';



class ScaffoldWithBottomNavBar extends StatefulWidget {
  final Widget child;

  ScaffoldWithBottomNavBar({Key? key, required this.child}) : super(key: key);

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  List<Restaurant>? restaurants;

  UserX? user;

  UserService userService = UserService();

  fetch() async {
    print('fetching');
    restaurants = await MockDataService.getRestaurants() as List<Restaurant>?;
    user = await userService.getMe() as UserX?;
  }

  @override
  Widget build(BuildContext context) {
    final String? location = GoRouterState.of(context).fullPath;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, Icons.home_outlined, 0, location),
            _buildNavItem(context, Icons.shopping_bag_outlined, 2, location),
            SizedBox(width: 20), 
            _buildNavItem(context, Icons.notifications_outlined, 1, location),
            _buildNavItem(context, Icons.person_outline, 3, location),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(bottom: 0,), // Raise FAB above the navbar
        child: FittedBox(
          child: FloatingActionButton(
            child: const Text('OLO',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              // Handle button press
            },
            backgroundColor: Color(0xFF282828), // Dark grey color
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, String? location) {
    final isSelected = _calculateSelectedIndex(location ?? '/restaurants') == index;
    return IconButton(
      icon: Icon(icon, 
        color: isSelected ? Color(0xFF282828) : Colors.grey,
        size: 28,
      ),
      onPressed: () {
        switch (index) {
          case 0:
            context.go('/restaurants', extra: restaurants);
            break;
          case 1:
            context.go('/notifications');
            break;
          case 2:
            context.go('/orders');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/restaurants')) return 0;
    if (location.startsWith('/notifications')) return 1;
    if (location.startsWith('/orders')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }
}

class ScaffoldWithoutNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithoutNavBar({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
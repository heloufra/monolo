// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:olo/go.dart';
// import 'package:olo/screens/profile/account.dart';

// class MainApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: goRouter,
//       title: 'OLO Food Delivery',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//     );
//   }
// }

// class ScaffoldWithBottomNavBar extends StatelessWidget {
//   final Widget child;

//   const ScaffoldWithBottomNavBar({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final String? location = GoRouterState.of(context).fullPath;
   
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: true
//           ? NavigationBar(
//               destinations: const [
//                 NavigationDestination(icon: Icon(Icons.home), label: 'Restaurants'),
//                 NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Orders'),
//                 NavigationDestination(icon: Icon(Icons.notifications), label: 'Notifications'),
//                 NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//               ],
//               onDestinationSelected: (index) {
//                 switch (index) {
//                   case 0:
//                     context.go('/restaurants');
//                     break;
//                   case 1:
//                     context.go('/orders');
//                     break;
//                   case 2:
//                     context.go('/notifications');
//                     break;
//                   case 3:
//                     context.go('/profile');
//                     break;
//                 }
//               },
//               selectedIndex: _calculateSelectedIndex(location ?? '/restaurants'),
//             )
//           : null,
//       floatingActionButton: false
//           ? FloatingActionButton(
//               child: const Text('Olo', style: TextStyle(fontSize: 16, color: Colors.white)),
//               onPressed: () {
//                 // Handle button press
//               },
//               backgroundColor: Colors.black87,
//             )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   int _calculateSelectedIndex(String location) {
//     if (location.startsWith('/restaurants')) return 0;
//     if (location.startsWith('/orders')) return 1;
//     if (location.startsWith('/notifications')) return 2;
//     if (location.startsWith('/profile')) return 3;
//     return 0;
//   }
// }



// class ScaffoldWithoutNavBar extends StatelessWidget {
//   final Widget child;

//   const ScaffoldWithoutNavBar({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//     );
//   }
// }
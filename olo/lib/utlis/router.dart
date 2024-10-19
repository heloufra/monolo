import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/loading.dart';
import 'package:olo/providers/auth.dart';
import 'package:olo/screens/notification.dart';
import 'package:olo/screens/orders.dart';
import 'package:olo/screens/profile/profile.dart';
import 'package:olo/screens/restaurants/restaurants.dart';
import 'package:olo/services/data.dart';
import 'package:olo/utlis/shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final _authNotifier = AuthNotifier();

final goRouter = GoRouter(
  initialLocation: '/restaurants',
  navigatorKey: _rootNavigatorKey,
  refreshListenable: _authNotifier,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // DataFetchingService(context).fetchAllData();
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/loading',
          builder: (context, state) => LoadingPage(),
        ),

        /// restaurants
        GoRoute(
          path: '/restaurants',
          builder: (context, state) => const RestaurantScreen(),
        ),

        /// orders
        GoRoute(
          path: '/orders',
          builder: (context, state) => OrdersScreen(),
        ),

        /// notifications
        GoRoute(
          path: '/notifications',
          builder: (context, state) => NotificationScreen(),
        ),

        /// profile
        GoRoute(
          path: '/profile',
          builder: (context, state) => ProfileScreen(),
        ),
      ],
    ),
  ],
);

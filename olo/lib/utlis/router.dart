import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/loading.dart';
import 'package:olo/models/address.dart';
import 'package:olo/models/user.dart';
import 'package:olo/providers/auth.dart';
import 'package:olo/screens/appinit.dart';
import 'package:olo/screens/auth/welcome.dart';
import 'package:olo/screens/notification.dart';
import 'package:olo/screens/orders.dart';
import 'package:olo/screens/profile/account.dart';
import 'package:olo/screens/profile/address/address.dart';
import 'package:olo/screens/profile/address/edit.dart';
import 'package:olo/screens/profile/address/new.dart';
import 'package:olo/screens/profile/notifications.dart';
import 'package:olo/screens/profile/policy.dart';
import 'package:olo/screens/profile/privacy.dart';
import 'package:olo/screens/profile/profile.dart';
import 'package:olo/screens/restaurants/restaurants.dart';
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
  // redirect: (context, state) {
  //   final bool loggedIn = _authNotifier.isLoggedIn;
  //   final bool loggingIn = state.uri.toString() == '/login';

  //   // If the user is not logged in and not on the login page, redirect to login
  //   if (!loggedIn && !loggingIn) {
  //     return '/login';
  //   }

  //   // If the user is logged in and tries to access the login page, redirect to restaurants
  //   if (loggedIn && loggingIn) {
  //     return '/restaurants';
  //   }

  //   // No need to redirect
  //   return null;
  // },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        // DataFetchingService(context).fetchAllData();
        // return AppInitializationWidget(child: ScaffoldWithBottomNavBar(child: child));
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/login',
          //  parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => Welcome(), // Your login page here
        ),
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
            routes: [
              GoRoute(
                  path: '/account',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final UserX? user = state.extra as UserX;
                    if (user == null) {
                      return ProfileScreen();
                    }
                    return Account(user: user);
                  }),
              GoRoute(
                path: '/address',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => AddressPage(),
                routes: [
                  GoRoute(
                    path: '/edit',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final Address? address = state.extra as Address;
                      if (address == null) {
                        return AddressPage();
                      }
                      return EditAddressPage(address: address);
                    },
                  ),
                  GoRoute(
                    path: '/new',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => NewAddressPage(),
                  ),
                ]
              ),
              GoRoute(
                  path: '/privacy',
                  builder: (context, state) => PrivacyScreen(),
                  routes: [
                    GoRoute(
                        path: '/privacy-policy',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) => PolicyScreen()),
                  ]),
              GoRoute(
                  path: '/notifications',
                  builder: (context, state) => NotificationsScreen()),
            ]),
      ],
    ),
  ],
);

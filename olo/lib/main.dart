import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olo/mainApp.dart';
import 'package:olo/models/mockRestaurants.dart';
import 'package:olo/models/restaurant.dart';
import 'package:olo/models/user.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/providers/auth.dart';
import 'package:olo/providers/restaurant.dart';
import 'package:olo/providers/user.dart';
import 'package:olo/screens/admin_dashboard/orders.dart';
import 'package:olo/screens/auth/markEntrance.dart';
import 'package:olo/screens/auth/saveaddress.dart';
import 'package:olo/screens/notification.dart';
import 'package:olo/screens/orders.dart';
import 'package:olo/screens/profile/account.dart';
import 'package:olo/screens/profile/address/address.dart';
import 'package:olo/screens/profile/profile.dart';
import 'package:olo/screens/restaurants/restaurants.dart';
import 'package:olo/screens/auth/welcome.dart';
import 'package:olo/services/user.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toastification/toastification.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final _authNotifier = AuthNotifier();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  refreshListenable: _authNotifier,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        if (state.fullPath == '/login' ||
            state.fullPath == '/saveaddress' ||
            state.fullPath == '/markentrance' ||
            state.fullPath == '/profile/account' ||
            state.fullPath == '/profile/address' ||
            state.fullPath == '/orders/details') {
          return ScaffoldWithoutNavBar(child: child);
        }
        return ScaffoldWithBottomNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/login',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const Welcome(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => RestaurantScreen(),
          redirect: (context, state) {
            if (!_authNotifier.isLoggedIn) {
              return '/login';
            }
            return null;
          },
        ),
        GoRoute(
            path: '/saveaddress',
            builder: (context, state) {
              final center = state.extra as LatLng?;
              if (center == null) {
                return SaveAddressPage();
              }
              return SaveAddressPage(center: center);
            }),
        GoRoute(
            path: '/markentrance',
            builder: (context, state) =>
                MapScreen(center: state.extra as LatLng)),
        GoRoute(
          path: '/restaurants',
          builder: (context, state) => RestaurantScreen(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => OrdersScreen(),
          routes: [
            GoRoute(
              path: 'details',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                // final order = state.extra as Order?;

                // if (order == null) {
                //   return const Center(
                //       child: Text("Error: Order data not found"));
                // }

                return OrderDetailsScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) =>  NotificationScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'account',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                final user = state.extra as UserX?;

                if (user == null) {
                  return const Center(
                      child: Text("Error: User data not found"));
                }

                return Account(user: user);
              },
            ),
            GoRoute(
              path: 'address',
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => AddressPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);


final supabase = Supabase.instance.client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get("SUPABASE_ANON_KEY"),
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ChangeNotifierProvider(create: (context) => RestaurantProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => AddressProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp.router(
  //     routerConfig: goRouter,
  //     title: 'GoRouter Example',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Olo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrdersPage(),
    );
  }
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;
  List<Restaurant>? restaurants;
  UserX? user;
  UserService userService = UserService();
  ScaffoldWithBottomNavBar({Key? key, required this.child}) : super(key: key);

  fetch() async {
    print('fetching');
    restaurants = await MockDataService.getRestaurants() as List<Restaurant>?;
    user = await userService.getMe() as UserX?;
  }

  @override
  Widget build(BuildContext context) {
    final String? location = GoRouterState.of(context).fullPath;
    fetch();

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Restaurants'),
          NavigationDestination(
              icon: Icon(Icons.shopping_bag), label: 'Orders'),
          NavigationDestination(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/restaurants', extra: restaurants);
              break;
            case 1:
              context.go('/orders');
              break;
            case 2:
              context.go('/notifications');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        selectedIndex: _calculateSelectedIndex(location ?? '/restaurants'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text('Olo',
            style: TextStyle(fontSize: 16, color: Colors.white)),
        onPressed: () {
          // Handle button press
        },
        backgroundColor: Colors.black87,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/restaurants')) return 0;
    if (location.startsWith('/orders')) return 1;
    if (location.startsWith('/notifications')) return 2;
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

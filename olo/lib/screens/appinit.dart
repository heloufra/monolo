import 'package:flutter/material.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/providers/auth.dart';
import 'package:olo/providers/restaurant.dart';
import 'package:olo/providers/settings.dart';
import 'package:olo/providers/user.dart';
import 'package:provider/provider.dart';

class AppInitializationWidget extends StatelessWidget {
  final Widget child;

  const AppInitializationWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error initializing app')),
          );
        }
        return child;
      },
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    // Start with auth check
    // await authNotifier.checkAuthStatus();

    // If authenticated, fetch other data
    if (authNotifier.isLoggedIn) {
      await Future.wait([
        restaurantProvider.fetchRestaurantsIfNeeded(),
        userProvider.fetchUserIfNeeded(),
        addressProvider.fetchAddressesIfNeeded(),
        settingsProvider.fetchSettings(),
      ]);
    }
  }
}
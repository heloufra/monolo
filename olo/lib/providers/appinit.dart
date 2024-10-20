import 'package:flutter/material.dart';
import 'package:olo/providers/address.dart';
import 'package:olo/providers/auth.dart';
import 'package:olo/providers/restaurant.dart';
import 'package:olo/providers/settings.dart';
import 'package:olo/providers/user.dart';
import 'package:provider/provider.dart';


class AppInitializationService {
  static Future<void> initialize(BuildContext context) async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    // Start with auth check, as it might be required for other data fetching
    // await authNotifier.();

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

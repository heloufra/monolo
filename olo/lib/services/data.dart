import 'package:flutter/material.dart';
import 'package:olo/providers/restaurant.dart';
import 'package:olo/providers/user.dart';
import 'package:provider/provider.dart';

class DataFetchingService {
  final BuildContext context;

  DataFetchingService(this.context);

  Future<void> fetchAllData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final orderProvider = Provider.of<RestaurantProvider>(context, listen: false);

    await Future.wait([
      userProvider.fetchUserIfNeeded(),
      orderProvider.fetchRestaurantsIfNeeded(),
    ]);
  }
}
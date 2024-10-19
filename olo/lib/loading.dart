import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/providers/api.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appInitProvider = Provider.of<AppInitializationProvider>(context);

    // If the app is initialized, redirect to home
    if (appInitProvider.isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go('/restaurants');
      });
    }

    // Keep showing the splash screen until the data is ready
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Or use your splash package here
    );
  }
}

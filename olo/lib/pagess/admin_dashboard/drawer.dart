import 'package:flutter/material.dart';
import 'orders.dart';
import 'availablity.dart';
import '../settings/settings.dart';
import 'menu.dart';
import 'menu_list_tile.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        shadowColor: Colors.grey,
        leadingWidth: 50,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            //backgroundImage: AssetImage('assetName'),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Fish Magic',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                '32 Dhs',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const OrdersPage(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_sharp),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customListTile(
              context: context,
              title: 'Orders',
              page: const OrdersPage(),
            ),
            customListTile(
              context: context,
              title: 'Availablity',
              page: const Availablity(),
            ),
            customListTile(
              context: context,
              title: 'Menu',
              page: const Menu(),
            ),
            customListTile(
              context: context,
              title: 'Settings',
              page: SettingsPage(),
            )
          ],
        ),
      ),
    );
  }
}

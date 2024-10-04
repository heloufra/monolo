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
  bool isDeliveryAvailable = false;
  bool acceptingOrders = false;

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
          children: [
            Column(
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Delivering Available?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            "Only Pick up.",
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 16),
                          ),
                        ],
                      ),
                      Switch(
                        value: isDeliveryAvailable,
                        activeColor: const Color.fromARGB(255, 70, 118, 72),
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: Colors.black,
                        onChanged: (bool value) {
                          setState(
                            () {
                              isDeliveryAvailable = value;
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 75,
              color: acceptingOrders
                  ? const Color.fromARGB(255, 52, 90, 55)
                  : const Color.fromARGB(255, 127, 53, 47),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(60, 255, 255, 255),
                          ),
                          child: Center(
                            child: Container(
                              height: 13,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                acceptingOrders ? 'Accepting Orders' : 'Paused',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                acceptingOrders
                                    ? 'Accepting new Orders'
                                    : 'Not accepting new Orders',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          acceptingOrders
                              ? Icons.pause_outlined
                              : Icons.play_arrow_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            acceptingOrders = !acceptingOrders;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

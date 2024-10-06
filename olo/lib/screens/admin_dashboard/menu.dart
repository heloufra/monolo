import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:olo/components/add_button.dart';
import 'package:olo/components/category_list.dart';
import 'package:olo/screens/admin_dashboard/category_items.dart';
import 'new_category.dart';

String categoryName = 'Pizza';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: DrawerPage(),
        ),
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          leadingWidth: 25,
          title: const Text(
            'Menu',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            children: [
              categoryList(
                context: context,
                catImage: const Icon(Icons.local_pizza_sharp),
                title: categoryName,
                subtitle: '2 Items',
                page: const CategoryItems(),
              ),
              addButton(
                context: context,
                title: 'New Category',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewCategory(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

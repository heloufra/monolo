import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:olo/components/add_button.dart';
import 'package:olo/components/category_list.dart';
import 'new_item.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          leadingWidth: 25,
          title: const Text(
            'Pizza',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          color: Colors.white,
          child: Column(
            children: [
              categoryList(
                context: context,
                catImage: const Icon(Icons.local_pizza_outlined),
                title: 'Margarita',
                subtitle: '32 Dhs',
                page: const DrawerPage(),
              ),
              addButton(
                  context: context,
                  title: 'New Item',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewItem(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

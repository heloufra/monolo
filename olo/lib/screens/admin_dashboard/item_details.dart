import 'package:flutter/material.dart';
import '/components/simple_list_tile.dart';
import 'package:olo/components/add_button.dart';
import 'options_page.dart';
import 'item_edit.dart';
import 'new_modifier.dart';
import 'category_items.dart';

String modifierName = 'Size';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String concatenatedOptions = options.join(' - ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        leadingWidth: 25,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryItems(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          itemName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemEdit(),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            simpleListTile(
              modifierName,
              concatenatedOptions,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OptionsPage(),
                  ),
                );
              },
            ),
            addButton(
              context: context,
              title: 'New Modifier',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewModifier(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

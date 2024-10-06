import 'package:flutter/material.dart';
import '/components/simple_list_tile.dart';
import 'package:olo/components/add_button.dart';
import 'options_page.dart';
import 'category_items.dart' show itemName;

String modifierName = 'Size';
String options = 'Normal';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          leadingWidth: 25,
          title: Text(
            itemName,
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
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              simpleListTile(
                modifierName,
                options,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

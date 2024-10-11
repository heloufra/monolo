import 'package:flutter/material.dart';
import 'package:olo/screens/admin_dashboard/category_items.dart';
import 'item_details.dart';
import 'package:olo/components/save_button.dart';

class ItemEdit extends StatefulWidget {
  const ItemEdit({super.key});

  @override
  State<ItemEdit> createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: const Text(
          'Category Edit',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ItemDetails(),
                ),
              );
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Available?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Turn off to hide the menu.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Switch(
                    activeColor: Colors.grey,
                    inactiveTrackColor: Colors.white,
                    inactiveThumbColor: Colors.black,
                    value: isAvailable,
                    onChanged: (bool value) {
                      setState(
                        () {
                          isAvailable = value;
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: itemName,
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Price',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  hintText: '28.00',
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextField(
                maxLines: 4,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'The description',
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Cover Image',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    child: Icon(
                      Icons.image,
                      size: 40,
                    ),
                  ),
                  title: Text(
                    'Upload Image',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Icon(
                    Icons.cancel_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Cover Image',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 70,
                          color: Colors.amber.shade100,
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 70,
                          color: Colors.amber.shade100,
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: Icon(Icons.cancel_rounded),
                        )
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SaveButton(
                onPressed: () {
                  // Handle save button tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

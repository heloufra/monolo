import 'package:flutter/material.dart';
import 'category_items.dart';
import 'package:olo/components/add_button.dart';
import 'package:olo/components/save_button.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          title: const Text(
            'New Category',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryItems(),
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
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Item Name',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 209, 208, 208)),
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
                        hintText: 'Add item price',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 209, 208, 208)),
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
                        hintText: 'Add item description',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 209, 208, 208)),
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
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    addButton(
                      context: context,
                      title: 'Upload Image',
                      onPressed: () {
                        // Handle upload image button tap
                      },
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Other Image',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 16, 215, 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 100),
                SaveButton(
                  onPressed: () {
                    // Handle save button tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

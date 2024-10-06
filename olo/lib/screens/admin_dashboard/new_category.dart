import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:olo/components/add_button.dart';
import 'package:olo/components/save_button.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final TextEditingController _nameController = TextEditingController();

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
                    builder: (context) => const Menu(),
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
        body: Container(
          padding: const EdgeInsets.all(20.0),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
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
                  hintText: 'Pizza',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 209, 208, 208)),
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
              Spacer(),
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

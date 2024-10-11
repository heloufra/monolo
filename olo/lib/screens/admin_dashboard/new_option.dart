import 'package:flutter/material.dart';
import 'options_page.dart';
import 'package:olo/components/save_button.dart';

class NewOption extends StatefulWidget {
  const NewOption({super.key});

  @override
  State<NewOption> createState() => _NewOptionState();
}

class _NewOptionState extends State<NewOption> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: const Text(
          'New Option',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OptionsPage(),
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
                hintText: 'Option Name',
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
                'Additional Cost',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: _addCostController,
              decoration: const InputDecoration(
                hintText: 'Add option cost',
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
            Spacer(),
            SaveButton(
              onPressed: () {
                // Handle save button tap
              },
            ),
          ],
        ),
      ),
    );
  }
}

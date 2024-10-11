import 'package:flutter/material.dart';
import 'item_details.dart';
import 'package:olo/components/save_button.dart';

class NewModifier extends StatefulWidget {
  const NewModifier({super.key});

  @override
  State<NewModifier> createState() => _NewModifierState();
}

class _NewModifierState extends State<NewModifier> {
  final TextEditingController _nameController = TextEditingController();
  String selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: const Text(
          'New Modifier',
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
                hintText: 'Modifier Name',
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
                'Max Selectable options',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: selectedOption,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 160),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ),
                items: <String>['Option 1', 'Option 2', 'Option 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      selectedOption = newValue!;
                    },
                  );
                },
                elevation: 1,
                underline: const SizedBox(),
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

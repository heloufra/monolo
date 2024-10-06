import 'package:flutter/material.dart';
import 'package:olo/components/save_button.dart';
import 'options_page.dart' show options, price;

class OptionDetails extends StatefulWidget {
  const OptionDetails({super.key});

  @override
  State<OptionDetails> createState() => _OptionDetailsState();
}

class _OptionDetailsState extends State<OptionDetails> {
  bool isAvailable = true;
  final TextEditingController _nameController1 = TextEditingController();
  final TextEditingController _nameController2 = TextEditingController();

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
            options.first,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
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
                controller: _nameController1,
                decoration: InputDecoration(
                  hintText: options.first,
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  'Additional Cost',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              TextField(
                controller: _nameController2,
                decoration: InputDecoration(
                  hintText: price.toString(),
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
      ),
    );
  }
}

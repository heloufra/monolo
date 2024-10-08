import 'package:flutter/material.dart';
import 'package:olo/components/simple_list_tile.dart';
import 'package:olo/components/add_button.dart';
import 'item_details.dart' show modifierName;
import 'option_details.dart';
import 'new_option.dart';

final List<String> options = ['Normal', 'Large', 'Extra Large'];
double price = 0.0;

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  double price = 0.0;
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
            modifierName,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              simpleListTile(
                options.first,
                '$price Dhs',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OptionDetails(),
                    ),
                  );
                },
              ),
              addButton(
                context: context,
                title: 'New Option',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewOption(),
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

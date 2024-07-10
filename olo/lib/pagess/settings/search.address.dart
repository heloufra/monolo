import 'package:flutter/material.dart';

class SearchAddressPage extends StatefulWidget {
  @override
  _SearchAddressPageState createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  final _formKey = GlobalKey<FormState>();
  // late String _address;

  // void _search() {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter an address',
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) => value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
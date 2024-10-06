import 'dart:async';
import 'package:flutter/material.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/services/clientService.dart';
import 'package:olo/types/User.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late Future<User> user;
  late var current;
  bool once = true;
  ClientService clientService = ClientService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = true;
  bool enable = false;
  bool showErrorEmail = false;
  String errorMessageEmail = '';
  bool showErrorPhone = false;
  String errorMessagePhone = '';
  bool showErrorSave = false;
  String errorMessageSave = '';

  _AccountState() {
    super.initState();

    user = _getUser();
  }

  Future<User> _getUser() async {
    User data = await clientService.getUser();

    return data;
  }

  void setData() async {
    current = await user;
    nameController.text = current.name;
    emailController.text = current.email;
    phoneController.text = current.phone;

    setState(() {
      once = false;
    });
  }

  void checkErrorEmail() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    if (emailValid || emailController.text.isEmpty) {
      setState(() {
        showErrorEmail = false;
        errorMessageEmail = '';
      });
    } else {
      setState(() {
        showErrorEmail = true;
        errorMessageEmail = 'Invalid email';
      });
    }
    checkEnableSave();
  }

  void checkErrorPhone() {
    final phoneValid = RegExp(r'^\d+$').hasMatch(phoneController.text);

    if (phoneValid || phoneController.text.isEmpty) {
      setState(() {
        showErrorPhone = false;
        errorMessagePhone = '';
      });
    } else {
      setState(() {
        showErrorPhone = true;
        errorMessagePhone = 'Phone number must contain only digits';
      });
    }
    checkEnableSave();
  }

  void checkEnableSave() {
    if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            !showErrorEmail &&
            !showErrorPhone
        // &&
        // !(current.name == nameController.text &&
        //     current.email == emailController.text &&
        //     current.phone == phoneController.text)
        ) {
      setState(() {
        enable = true;
      });
    } else {
      setState(() {
        enable = false;
      });
    }
  }

  Future<void> save() async {
    if (enable) {
      setState(() {
        enable = false;
      });
    }

    var (success, msg) = await clientService.updateAccount(
      nameController.text,
      emailController.text,
      phoneController.text,
    );

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      setState(() {
        showErrorSave = true;
        errorMessageSave = msg;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    setState(() {
      once = true;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Account Settings',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (once) {
                setData();
              }

              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Full Name',
                      ),
                      onChanged: (value) => checkEnableSave(),
                    ),
                    SizedBox(height: 16),
                    Text('Email', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      onChanged: (value) => checkErrorEmail(),
                    ),
                    SizedBox(height: 10),
                    showErrorEmail
                        ? Text(
                            errorMessageEmail,
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(),
                    SizedBox(height: 6),
                    Text('Phone number', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 90,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: '+212',
                            items: ['+212'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) => checkErrorEmail(),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone number',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    showErrorPhone
                        ? Text(
                            errorMessagePhone,
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(),
                    SizedBox(height: 6),
                    Spacer(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        color: Colors.transparent,
        child: Continue(
            onTap: enable
                ? () async {
                    await save();
                  }
                : null,
            enable: enable,
            textbutton: 'Save'),
        elevation: 0,
      ),
    );
  }
}

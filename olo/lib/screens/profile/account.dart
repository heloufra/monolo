import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/main.dart';
import 'package:olo/models/user.dart';
import 'package:olo/providers/user.dart';
import 'package:olo/screens/profile/profile.dart';
import 'package:olo/services/user.dart';
import 'package:olo/utlis/toast.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class Account extends StatefulWidget {
  final UserX user;

  const Account({Key? key, required this.user}) : super(key: key);
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late var current;
  bool once = true;
  var userService = UserService();

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

  @override
  void initState() {
    super.initState();
    if (once) {
      setData();
    }
  }

  void setData() async {
    print(widget.user);
    current =  widget.user;
    nameController.text = current.name;
    emailController.text = current.email;
    phoneController.text = current.phoneNumber;
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
     final userProvider = await Provider.of<UserProvider>(context, listen: false);
    
    try {
      await userProvider.updateUser({
        "name": nameController.text,
        "email": emailController.text,
        "phoneNumber": phoneController.text,
        "pictureURL": userProvider.user?.picture ?? '',}
      );


      showToast(context, "Success", "Account updated successfully!",
          ToastificationType.success);
    } catch (e) {
      showToast(
          context, "Error", "Something went wrong!", ToastificationType.error);
    }
    Navigator.pop(context);
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
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
      ),
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

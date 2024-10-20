import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olo/components/continue.dart';
import 'package:olo/models/user.dart';
import 'package:olo/providers/user.dart';
import 'package:olo/services/user.dart';
import 'package:olo/utlis/toast.dart';
import 'package:olo/widgets/textfield.dart';
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
    current = widget.user;
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
        !showErrorPhone) {
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
    final userProvider =
        await Provider.of<UserProvider>(context, listen: false);

    try {
      await userProvider.updateUser({
        "name": nameController.text,
        "email": emailController.text,
        "phoneNumber": phoneController.text,
        "pictureURL": userProvider.user?.picture ?? '',
      });

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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            CustomTextField(
              label: 'Full Name',
              controller: nameController,
              onChanged: checkEnableSave,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Email',
              controller: emailController,
              onChanged: checkErrorEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: 'Phone number',
              controller: phoneController,
              isPhoneField: true,
              onChanged: checkErrorPhone,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
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

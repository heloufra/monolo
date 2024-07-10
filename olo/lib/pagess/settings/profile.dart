import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olo/pagess/settings/account.dart';
import 'package:olo/pagess/settings/address.dart';
import 'package:olo/pagess/settings/notification.dart';
import 'package:olo/pagess/settings/privacy.dart';
import 'package:olo/services/clientService.dart';
import 'package:olo/types/User.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> user;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();

    user = _getUser();
  }

  Future<User> _getUser() async {
    User data = await clientService.getUser();

    return data;
  }

  Future<User> getUser(Future<User> user) async {
    var re = User(
      name: (await user).name,
      email: (await user).email,
      phone: (await user).phone,
      notified: (await user).notified,
      notifiedMedia: (await user).notifiedMedia,
    );

    return re;
  }

  Future<void> _showOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              if (_image != null)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _image = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Hide the default app bar
      ),
      body: SafeArea(
        child: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(
                              'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                            ) as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.black),
                            onPressed: () {
                              _showOptions(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshot.data!.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    snapshot.data!.email,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Account',
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              // Handle tap
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Account()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text('Address'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddressPage()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text('Notifications'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              // Handle tap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationSettingsPage()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          ListTile(
                            title: Text('Privacy'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade200, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Privacy()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

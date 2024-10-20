import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olo/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:olo/models/user.dart';

import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUserIfNeeded();
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // TODO: Implement logic to update user's profile picture
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.isLoading) {
              return Center( heightFactor: 12, child: CircularProgressIndicator(), );
            } else if (userProvider.error != null) {
              return Center(child: Text('${userProvider.error}'));
            } else if (userProvider.user == null) {
              return Center(child: Text('No user data found'));
            } else {
              final user = userProvider.user!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : NetworkImage(user.picture ?? "")
                                      as ImageProvider,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.add,
                                      size: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.name ?? "Name",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user.email ?? "Email",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 24, 25, 25),
                    child: Column(
                      children: [
                        _buildListTile('Account', () {
                          GoRouter.of(context)
                              .go('/profile/account', extra: user);
                        }),
                        const SizedBox(height: 12),
                        _buildListTile('Address', () {
                          // Navigate to address screen
                          GoRouter.of(context).go('/profile/address');
                        }),
                        const SizedBox(height: 12),
                        _buildListTile('Notifications', () {
                          // Navigate to notifications screen
                          GoRouter.of(context).go('/profile/notifications');
                        }),
                        const SizedBox(height: 12),
                        _buildListTile('Privacy', () {
                          // Navigate to privacy screen
                          GoRouter.of(context).go('/profile/privacy');
                        }),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      onTap: onTap,
    );
  }
}

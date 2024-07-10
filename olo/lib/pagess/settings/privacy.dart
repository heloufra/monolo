import 'package:flutter/material.dart';
import 'package:olo/pagess/auth/welcome.dart';
import 'package:olo/services/authService.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool _dataVisibility = false;
  bool _appPermissions = false;
  bool _dataCollection = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Manage Data Visibility'),
              value: _dataVisibility,
              onChanged: (bool value) {
                setState(() {
                  _dataVisibility = value;
                });
                // Navigate to data visibility settings
              },
            ),
            SwitchListTile(
              title: Text('App Permissions'),
              value: _appPermissions,
              onChanged: (bool value) {
                setState(() {
                  _appPermissions = value;
                });
                // Navigate to app permissions settings
              },
            ),
            SwitchListTile(
              title: Text('Data Collection and Usage'),
              value: _dataCollection,
              onChanged: (bool value) {
                setState(() {
                  _dataCollection = value;
                });
                // Navigate to information about data collection and usage
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Account'),
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text('Are you sure you want to permanently delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) {
    // Placeholder for account deletion logic

    Navigator.of(context).pop(); // Close the confirmation dialog
    _showDeletionSuccessMessage(context);
  }

  void _showDeletionSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Deleted'),
          content: Text('Your account has been successfully deleted.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst); // Close all dialogs
                // Add your logout logic here
              },
            ),
          ],
        );
      },
    );
  }


    void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Log Out'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Placeholder for account deletion logic
    authService.logout();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Welcome(), // Pass an empty Address object
      ),
    );
    // Close the confirmation dialog
  }
}

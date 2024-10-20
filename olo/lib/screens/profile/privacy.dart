import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olo/providers/settings.dart';
import 'package:provider/provider.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Privacy'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              _buildSwitchListTile(
                'Location',
                'Allow app to access your location',
                settings.locationEnabled,
                (value) => settings.updatePrivacySettings(
                    value, settings.dataSharingEnabled),
              ),
              _buildSwitchListTile(
                'Data Sharing',
                'Share usage data to improve our services',
                settings.dataSharingEnabled,
                (value) => settings.updatePrivacySettings(
                    settings.locationEnabled, value),
              ),
              ListTile(
                title: Text('Delete Account'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => _showDeleteAccountDialog(),
              ),
              ListTile(
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () =>
                    GoRouter.of(context).go('/profile/privacy/privacy-policy'),
              ),
              ListTile(
                title: Text('Log Out'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () => _logOut(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Color(0xFF282828),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // TODO: Implement account deletion logic
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }

  void _logOut() {
    // TODO: Implement log out logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Log Out'),
              onPressed: () {
                // TODO: Implement actual log out logic
                Navigator.of(context).pop();
                // Navigate to login screen or home screen after logout
              },
            ),
          ],
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      },
    );
  }
}

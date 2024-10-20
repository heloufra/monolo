import 'package:flutter/material.dart';
import 'package:flutter_open_app_settings/flutter_open_app_settings.dart';
import 'package:olo/providers/settings.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              _buildSwitchListTile(
                'Order Updates',
                'Receive notifications about your order status',
                settings.orderUpdatesEnabled,
                (value) => settings.updateNotificationSettings(
                    value,
                    settings.promotionsEnabled,
                    settings.emailNotificationsEnabled),
              ),
              _buildSwitchListTile(
                'Promotions and Offers',
                'Get notified about special deals and discounts',
                settings.promotionsEnabled,
                (value) => settings.updateNotificationSettings(
                    settings.orderUpdatesEnabled,
                    value,
                    settings.emailNotificationsEnabled),
              ),
              _buildSwitchListTile(
                'Email Notifications',
                'Enable email notifications',
                settings.emailNotificationsEnabled,
                (value) => settings.updateNotificationSettings(
                    settings.orderUpdatesEnabled,
                    settings.promotionsEnabled,
                    value),
              ),
              ListTile(
                title: Text('Push Notification Settings'),
                subtitle: Text('Manage system-level notification settings'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {

                  FlutterOpenAppSettings.openAppsSettings(settingsCode: SettingsCode.NOTIFICATION,
            onCompletion: null);
                },
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
}

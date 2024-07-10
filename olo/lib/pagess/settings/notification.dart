import 'package:flutter/material.dart';
import 'package:olo/services/clientService.dart';
import 'package:olo/types/User.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late Future<NotificationSettings> futureSettings;


  ClientService clientService = ClientService();
  bool enableSave = false;
  bool showError = false;
  String errorMessage = '';
  late User user;

  @override
  void initState() {
    super.initState();
    futureSettings = fetchNotificationSettings();
  }



 

  Future<NotificationSettings> fetchNotificationSettings() async {
    // Simulate a network call with a delay
    // await Future.delayed(Duration(seconds: 2));
     user = await clientService.getUser();
    // Return fake data
    print(user.notifiedMedia);
    return NotificationSettings(
      orderUpdates: user.notified,
      notificationPreference: user.notifiedMedia,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notification Settings'),
      ),
      body: FutureBuilder<NotificationSettings>(
        future: futureSettings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            NotificationSettings settings = snapshot.data!;
            return NotificationSettingsForm(settings: settings);
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class NotificationSettingsForm extends StatefulWidget {
  final NotificationSettings settings;

  NotificationSettingsForm({required this.settings});

  @override
  _NotificationSettingsFormState createState() => _NotificationSettingsFormState();
}

class _NotificationSettingsFormState extends State<NotificationSettingsForm> {
  late bool orderUpdates;

  late String notificationPreference;
  ClientService clientService = ClientService();

  @override
  void initState() {
    super.initState();
    orderUpdates = widget.settings.orderUpdates;

    notificationPreference = widget.settings.notificationPreference;
    print(orderUpdates);
  }

  Future<void> onChange() async {
    print('Enter onChange');
    if (orderUpdates != widget.settings.orderUpdates ||
        notificationPreference != widget.settings.notificationPreference) {

      await clientService.notification(
        orderUpdates,
        notificationPreference,
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Push Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: Text('Order Updates'),
            value: orderUpdates,
            onChanged: (bool value) {
              setState(() {
                orderUpdates = value;
              });
              onChange();
            },
          ),

          SizedBox(height: 20),
          Text(
            'Notification Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              ListTile(
                title: Text('Email'),
                leading: Radio<String>(
                  value: 'email',
                  groupValue: notificationPreference,
                  onChanged: (String? value) {
                    setState(() {
                      notificationPreference = value!;
                    });
                    onChange();
                  },
                ),
              ),
              ListTile(
                title: Text('SMS'),
                leading: Radio<String>(
                  value: 'sms',
                  groupValue: notificationPreference,
                  onChanged: (String? value) {
                    setState(() {
                      notificationPreference = value!;
                    });
                     onChange();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationSettings {
  final bool orderUpdates;
  final String notificationPreference;

  NotificationSettings({
    required this.orderUpdates,
    required this.notificationPreference,
  });
}
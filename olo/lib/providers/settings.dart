import 'package:flutter/material.dart';
import 'package:olo/services/settings.dart';


class SettingsProvider with ChangeNotifier {
  final SettingsService settingsService = SettingsService();

  bool locationEnabled = true;
  bool dataSharingEnabled = true;
  bool orderUpdatesEnabled = true;
  bool promotionsEnabled = true;
  bool emailNotificationsEnabled = true;

  SettingsProvider() {
    fetchSettings();
  }

  Future<void> fetchSettings() async {
    try {
      final settings = await settingsService.getSettings();
      locationEnabled = settings['locationEnabled'];
      dataSharingEnabled = settings['dataSharingEnabled'];
      orderUpdatesEnabled = settings['orderUpdates'];
      promotionsEnabled = settings['promotions'];
      emailNotificationsEnabled = settings['emailNotifications'];
      notifyListeners();
    } catch (error) {
      print('Error fetching settings : $error');
    }
  }

  Future<void> updatePrivacySettings(bool location, bool dataSharing) async {
    try {
      await settingsService.updatePrivacySettings({
        'locationEnabled': location,
        'dataSharingEnabled': dataSharing,
      });
      locationEnabled = location;
      dataSharingEnabled = dataSharing;

      notifyListeners();
    } catch (error) {
      print('Error updating privacy settings: $error');
    }
  }

  Future<void> updateNotificationSettings(bool orderUpdates, bool promotions, bool emailNotifications) async {
    try {
      await settingsService.updateNotificationSettings({
        'orderUpdates': orderUpdates,
        'promotions': promotions,
        'emailNotifications': emailNotifications,
      });
      orderUpdatesEnabled = orderUpdates;
      promotionsEnabled = promotions;
      emailNotificationsEnabled = emailNotifications;
      notifyListeners();
    } catch (error) {
      print('Error updating notification settings: $error');
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      await settingsService.deleteUserAccount();
      notifyListeners();
    } catch (error) {
      print('Error deleting user account: $error');
    }
  }
}

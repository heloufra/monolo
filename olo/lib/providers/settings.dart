import 'package:flutter/foundation.dart';
import 'package:olo/models/settings.dart';

class SettingsProvider with ChangeNotifier {
  Settings? _settings;

  Settings? get settings => _settings;

  void setSettings(Settings settings) {
    _settings = settings;
    notifyListeners();
  }

  Future<void> updateSettings(Map<String, dynamic> newSettings) async {
    // Implement the logic to update settings (e.g., API call)
    // After successful update:
    _settings = Settings.fromMap({..._settings!.toMap(), ...newSettings});
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    if (_settings != null) {
      await updateSettings({'darkMode': !_settings!.darkMode});
    }
  }

  Future<void> setNotificationPreference(NotificationPreference preference) async {
    if (_settings != null) {
      await updateSettings({'notificationPreference': preference.toString().split('.').last});
    }
  }

  // Add more settings-related methods as needed
}
import 'package:flutter/foundation.dart';
import 'package:olo/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  // Add more user-related methods as needed, for example:
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    // Implement the logic to update user profile
    // This might involve making an API call
    // After successful update:
    _user = User.fromMap({..._user!.toMap(), ...data});
    notifyListeners();
  }
}
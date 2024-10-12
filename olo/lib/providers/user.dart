import 'package:flutter/foundation.dart';
import 'package:olo/models/user.dart';
import 'package:olo/services/user.dart';

class UserProvider extends ChangeNotifier {
  UserX? _user;
  bool _isLoading = false;
  String? _error;
  DateTime? _lastFetchTime;

  UserService _userService = UserService();

  UserX? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUserIfNeeded() async {
    if (_shouldFetchData()) {
      await _fetchUser();
    }
  }

  bool _shouldFetchData() {
    if (_user == null || _lastFetchTime == null) {
      return true;
    }
    final fiveMinutesAgo = DateTime.now().subtract(Duration(minutes: 15));
    return _lastFetchTime!.isBefore(fiveMinutesAgo);
  }

  Future<void> _fetchUser() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _userService.getMe() as UserX;
      _lastFetchTime = DateTime.now();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forceRefresh() async {
    _lastFetchTime = null;
    await _fetchUser();
  }

  Future<void> updateUser(Map<String, dynamic> userData) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _userService.updateUser(userData);
      forceRefresh();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
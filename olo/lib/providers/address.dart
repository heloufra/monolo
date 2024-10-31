import 'package:flutter/foundation.dart';
import 'package:olo/models/address.dart';
import 'package:olo/services/address.dart';

class AddressProvider extends ChangeNotifier {
  List<Address>? _addresses;
  Address? _selectedAddress;
  bool _isLoading = false;
  String? _error;
  DateTime? _lastFetchTime;

  final AddressService _addressService = AddressService();

  List<Address>? get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress;

  set selectedAddress(Address? address) {
    _selectedAddress = address;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAddressesIfNeeded() async {
    if (_shouldFetchData()) {
      await _fetchAddresses();
    }
  }

  bool _shouldFetchData() {
    if (_addresses == null || _lastFetchTime == null) {
      return true;
    }
    final fifteenMinutesAgo = DateTime.now().subtract(Duration(minutes: 15));
    return _lastFetchTime!.isBefore(fifteenMinutesAgo);
  }

  Future<void> _fetchAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _addresses = await _addressService.getAddresses();
      _lastFetchTime = DateTime.now();
      _selectedAddress = _addresses!.first;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> forceRefresh() async {
    _lastFetchTime = null;
    await _fetchAddresses();
  }

  Future<void> addAddress(Map<String, dynamic> addressData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final error = await _addressService.addNewAddress(addressData);
      if (error != null) {
        _error = error;
      } else {
        await forceRefresh();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress(Map<String, dynamic> addressData, String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final error = await _addressService.updateAddress(addressData, id);
      if (error != null) {
        _error = error;
      } else {
        await forceRefresh();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAddress(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final error = await _addressService.deleteAddress(id);
      if (error != null) {
        _error = error;
      } else {
        await forceRefresh();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

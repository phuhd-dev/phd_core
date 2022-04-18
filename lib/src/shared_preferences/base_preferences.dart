import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BasePreference {
  late FlutterSecureStorage _secureStorage;
  AndroidOptions? _androidOptions;
  IOSOptions? _iosOptions;

  BasePreference({AndroidOptions? androidOptions, IOSOptions? iosOptions}) {
    _secureStorage = FlutterSecureStorage();
    _androidOptions = androidOptions;
    _iosOptions = iosOptions;
  }

  Future getValue(String key, {bool isSecure = false}) async {
    if (isSecure) return await _secureStorage.read(key: key, aOptions: _androidOptions, iOptions: _iosOptions);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> setValue(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      throw Exception("Value type is not supported");
    }
  }

  Future setSecureValue(String key, String value) async {
    return await _secureStorage.write(key: key, value: value, aOptions: _androidOptions, iOptions: _iosOptions);
  }

  Future<bool> remove(String key, {bool isSecure = false}) async {
    if (isSecure) await _secureStorage.delete(key: key, aOptions: _androidOptions, iOptions: _iosOptions);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  Future<bool> cleanUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _secureStorage.deleteAll(aOptions: _androidOptions, iOptions: _iosOptions);
    return await prefs.clear();
  }
}

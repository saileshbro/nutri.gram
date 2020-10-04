import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/datamodels/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesService {
  final _logger = getLogger("SharedPreferencesService");
  static const String userKey = "USERKEY";
  static const String totalScannedKey = "TOTALSCANNEDKEY";
  static const String onboardingKey = "ONBOARDINGKEY";
  static const String tokenKey = "TOKENKEY";
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  User get user {
    final userJson = _getFromDisk(userKey);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(
        jsonDecode(userJson as String) as Map<String, dynamic>);
  }

  int get totalScanned => _getFromDisk(totalScannedKey) as int ?? 0;

  Future<void> setUser(User userToSave) async {
    await _saveToDisk(userKey, json.encode(userToSave.toJson()));
  }

  Future<void> incremenntTotalScanned() async {
    await _saveToDisk(totalScannedKey, 1 + totalScanned);
  }

  String get token {
    final String tokenVal = _getFromDisk(tokenKey) as String;
    if (tokenVal == null || tokenVal.isEmpty) {
      return null;
    }
    return tokenVal;
  }

  Future<void> setToken(String token) async {
    await _saveToDisk(tokenKey, token);
  }

  bool get onboardingVisited {
    final visited = _getFromDisk(onboardingKey);
    if (visited != null) {
      return visited as bool && true;
    }
    return false;
  }

  Future<void> setOnboardingVisited() async {
    await _saveToDisk(onboardingKey, true);
  }

  dynamic _getFromDisk(String key) => _preferences.get(key);

  Future<void> _saveToDisk<T>(String key, T content) async {
    _logger.d('_saveStringToDisk called key: $key returned value: $content');

    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  Future<void> removeUser() async {
    _logger.d("removeUser called");
    await _preferences.remove(userKey);
    _logger.d("User removed");
  }

  Future<void> removeToken() async {
    _logger.d("removeToken called");
    await _preferences.remove(tokenKey);
    _logger.d("Token removed");
  }
}

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _tokenKey = "TOKENKEY";
const String _nameKey = "NAMEKEY";
const String _phoneKey = "PHONEKEY";

@lazySingleton
class SharedPreferencesService {
  final SharedPreferences _preferences;
  SharedPreferencesService(this._preferences);
  String get token => _preferences.getString(_tokenKey) ?? "";
  String get name => _preferences.getString(_nameKey) ?? "";
  String get phone => _preferences.getString(_phoneKey) ?? "";
  Future<void> saveData(String token, String name, String phone) async {
    _preferences.setString(_tokenKey, token);
    _preferences.setString(_nameKey, name);
    _preferences.setString(_phoneKey, phone);
  }

  void removeToken() {
    _preferences.remove(_tokenKey);
  }

  void removeName() {
    _preferences.remove(_nameKey);
  }

  void removePhone() {
    _preferences.remove(_phoneKey);
  }
}

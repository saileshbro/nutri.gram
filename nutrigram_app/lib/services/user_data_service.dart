import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/user.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';

@lazySingleton
class UserDataService {
  String _token;
  User _user;
  // ignore: unused_field
  bool _isLoggedIn;

  UserDataService(this._sharedPreferencesService);
  String get token => _token ?? "";
  User get user => _user;

  final SharedPreferencesService _sharedPreferencesService;
  Future<bool> saveData(String token, User user) async {
    await saveToken(token);
    await saveUser(user);
    _isLoggedIn = true;
    return true;
  }

  Future<bool> saveUser(User user) async {
    _user = user;
    await _sharedPreferencesService.setUser(user);
    return true;
  }

  Future<bool> saveToken(String token) async {
    _token = token;
    await _sharedPreferencesService.setToken(token);
    _isLoggedIn = true;
    return true;
  }

  bool getData() {
    _token = _sharedPreferencesService.token;
    _user = _sharedPreferencesService.user;
    return true;
  }

  Future<bool> clearData() async {
    _token = null;
    _user = null;
    _isLoggedIn = false;
    await _sharedPreferencesService.removeUser();
    return true;
  }

  bool get isLoggedIn {
    getData();
    if (_token != null && _token.isNotEmpty && _user != null) {
      _isLoggedIn = true;
      return true;
    }
    _isLoggedIn = false;
    return false;
  }
}

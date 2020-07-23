import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';

@lazySingleton
class UserDataService {
  String _token;
  String _name;
  String _phone;
  // ignore: unused_field
  bool _isLoggedIn;

  UserDataService(this._sharedPreferencesService);
  String get token => _token;
  String get name => _name;

  final SharedPreferencesService _sharedPreferencesService;
  Future<bool> saveData(String token, String name, String phone) async {
    _token = token;
    _name = name;
    _phone = phone;
    await _sharedPreferencesService.saveData(token, name, phone);
    _isLoggedIn = true;
    return true;
  }

  bool getData() {
    _token = _sharedPreferencesService.token;
    _name = _sharedPreferencesService.name;
    _phone = _sharedPreferencesService.phone;
    return true;
  }

  bool clearData() {
    _token = null;
    _name = null;
    _isLoggedIn = false;
    _sharedPreferencesService.removeToken();
    _sharedPreferencesService.removeName();
    _sharedPreferencesService.removePhone();
    return true;
  }

  bool get isLoggedIn {
    getData();
    if (_token != null &&
        _token.isNotEmpty &&
        _name != null &&
        _name.isNotEmpty &&
        _phone != null &&
        _phone.isNotEmpty) {
      _isLoggedIn = true;
      return true;
    }
    _isLoggedIn = false;
    return false;
  }
}

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';

@lazySingleton
class UserDataService {
  String _token;
  String _name;
  String _phone;
  String _imageUrl;
  // ignore: unused_field
  bool _isLoggedIn;

  UserDataService(this._sharedPreferencesService);
  String get token => _token ?? "";
  String get name => _name ?? "";
  String get phone => _phone ?? "";
  String get imageUrl => _imageUrl ?? "${kBaseUrl}public/profile.png";
  final SharedPreferencesService _sharedPreferencesService;
  Future<bool> saveData(
      String token, String name, String phone, String imageUrl) async {
    _token = token;
    _name = name;
    _phone = phone;
    _imageUrl = imageUrl;
    await _sharedPreferencesService.saveData(token, name, phone, imageUrl);
    _isLoggedIn = true;
    return true;
  }

  Future<bool> saveName(String name) async {
    _name = name;
    await _sharedPreferencesService.saveName(name);
    return true;
  }

  Future<bool> savePhone(String phone) async {
    _phone = phone;
    await _sharedPreferencesService.savePhone(phone);
    return true;
  }

  Future<bool> saveImage(String image) async {
    _imageUrl = imageUrl;
    await _sharedPreferencesService.saveImage(imageUrl);
    return true;
  }

  bool getData() {
    _token = _sharedPreferencesService.token;
    _name = _sharedPreferencesService.name;
    _phone = _sharedPreferencesService.phone;
    return true;
  }

  Future<bool> clearData() async {
    _token = null;
    _name = null;
    _phone = null;
    _isLoggedIn = false;
    await Future.wait([
      _sharedPreferencesService.removeToken(),
      _sharedPreferencesService.removeName(),
      _sharedPreferencesService.removePhone(),
    ]);
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

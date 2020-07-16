import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesService {
  final SharedPreferences _preferences = locator<SharedPreferences>();
}

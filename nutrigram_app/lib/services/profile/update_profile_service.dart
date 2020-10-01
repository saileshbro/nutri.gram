import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfileService {
  String _tempPhone;
  String get tempPhone => _tempPhone;

  set tempPhone(String value) => _tempPhone = value;
}

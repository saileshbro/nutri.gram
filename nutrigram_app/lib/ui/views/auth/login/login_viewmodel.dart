import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  final IAuthenticationRepository _authenticationRepository;
  final UserDataService _userDataService;
  final NavigationService _navigationService;

  String _phoneNo;
  String _password;
  String get phoneNo => _phoneNo;
  String get password => _password;

  set phoneNo(String val) {
    _phoneNo = val;
  }

  set password(String val) {
    _password = val;
  }

  LoginViewModel(this._authenticationRepository, this._userDataService,
      this._navigationService);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool get isPasswordVisible => _obscurePassword;
  void changePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> doLogin() async {
    if (formKey.currentState.validate()) {}
  }

  String validatePhone(String phone) {
    try {
      int.tryParse(phone, radix: 10);
      if (phone.length < 10) {
        return "Invalid phone number";
      }
      return null;
    } catch (e) {
      return "Invalid phone number";
    }
  }

  String validatePassword(String value) {
    return validators.validatePassword(value);
  }
}

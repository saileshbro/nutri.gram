import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  static const getOtpBusy = "getPasswordRequestBusyObj";
  final IAuthenticationRepository _authenticationRepository;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  final DialogService _dialogService;
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

  LoginViewModel(
    this._authenticationRepository,
    this._userDataService,
    this._navigationService,
    this._dialogService,
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool get isPasswordVisible => _obscurePassword;
  void changePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    setBusy(true);
    final Either<Failure, LoginResponseModel> result =
        await _authenticationRepository.login(
            loginRequestModel:
                LoginRequestModel(phone: _phoneNo, password: _password));
    result.fold(
      (Failure failute) => _showError(failute.message),
      (LoginResponseModel model) async {
        setBusy(false);
        if (model.user.otpVerified) {
          await _userDataService.saveData(model.token, model.user);
          _navigationService.back();
        } else {
          await _showMessage("Verification code is ${model.user.otp}");
          _navigationService.navigateTo(
            Routes.verificationView,
            arguments: VerificationViewArguments(phoneNumber: model.user.phone),
          );
        }
      },
    );
  }

  String validatePhone(String phone) => validators.validatePhone(phone);

  String validatePassword(String value) => validators.validatePassword(value);

  void goToRegister() => _navigationService.navigateTo(Routes.registerView);
  void _showError(String message) {
    _dialogService.showDialog(
      title: "Login Failure",
      description: message,
    );
    setBusy(false);
  }

  Future<void> _showMessage(String message) async {
    await _dialogService.showDialog(
      title: "Verification code",
      description: message,
    );
    setBusy(false);
  }
}

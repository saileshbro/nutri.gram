import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class RegisterViewModel extends BaseViewModel {
  final IAuthenticationRepository _authenticationRepository;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterViewModel(this._authenticationRepository, this._navigationService,
      this._dialogService);
  String _name;
  String get name => _name;
  String _phoneNo;
  String get phoneNo => _phoneNo;
  String _password;
  String get password => _password;
  set name(String val) {
    _name = val;
  }

  set phoneNo(String val) {
    _phoneNo = val;
  }

  set password(String val) {
    _password = val;
  }

  bool _obscurePassword = true;
  bool get isPasswordVisible => _obscurePassword;
  void changePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> register() async {
    setBusy(true);
    final Either<Failure, RegisterResponseModel> result =
        await _authenticationRepository.register(
            registerRequestModel:
                RegisterRequestModel(_name, _phoneNo, _password));
    result.fold((Failure failute) => _showError(failute.message),
        (RegisterResponseModel model) async {
      await _showMessage("Verification code is ${model.user.otp}");
      setBusy(false);
      _navigationService.navigateTo(Routes.verificationView,
          arguments: VerificationViewArguments(phoneNumber: model.user.phone));
    });
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Signup Failure",
      description: message,
    );
    setBusy(false);
  }

  Future<void> _showMessage(String message) async {
    await _dialogService.showDialog(
      title: "Signup Success",
      description: message,
    );
    setBusy(false);
  }

  String validatePhone(String phone) => validators.validatePhone(phone);

  String validatePassword(String value) => validators.validatePassword(value);

  String validateName(String value) => validators.validateName(value);
  void onLoginPressed() {
    _navigationService.back();
  }
}

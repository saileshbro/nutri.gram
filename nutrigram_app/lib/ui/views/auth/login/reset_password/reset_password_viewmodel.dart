import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;
import 'package:stacked_services/stacked_services.dart';

@injectable
class ResetPasswordViewModel extends BaseViewModel {
  bool _passwordHidden = false;

  ResetPasswordViewModel(this._authenticationRepository, this._dialogService,
      this._navigationService, this._userDataService);
  bool get isPasswordHidden => _passwordHidden;
  final IAuthenticationRepository _authenticationRepository;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  void hidePassword() {
    _passwordHidden = !_passwordHidden;
  }

  String validatePassword(String value) => validators.validatePassword(value);
  String validateOtp(String value) => validators.validateOtp(value);
  String validatePhone(String value) => validators.validatePhone(value);
  Future<void> changePassword(
      String phone, String newPassword, String otp) async {
    setBusy(true);
    final Either<Failure, PassswordResetResponseModel> resp =
        await _authenticationRepository.resetPasswordWithOtp(
      PassswordResetRequestModel(
          newPassword: newPassword, otp: otp, phone: phone),
    );
    resp.fold((l) {
      _showError(l.message);
    }, (r) async {
      await _userDataService.clearData();
      _navigationService.popRepeated(2);
    });
    setBusy(false);
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Password Reset Failure",
      description: message,
    );
    setBusy(false);
  }
}

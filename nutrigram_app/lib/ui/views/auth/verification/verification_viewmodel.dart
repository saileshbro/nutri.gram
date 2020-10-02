import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class VerificationViewModel extends BaseViewModel {
  final IAuthenticationRepository _authenticationRepository;
  final DialogService _dialogService;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  static const String verifyingBusy = "verifyingBusy";
  static const String resendVerificationBusy = "resendVerificationBusy";
  String otp;
  String phoneNumber;

  VerificationViewModel(this._authenticationRepository, this._dialogService,
      this._userDataService, this._navigationService);

  Future<void> resendCode() async {
    setBusyForObject(resendVerificationBusy, true);
  }

  Future<void> verify() async {
    setBusyForObject(verifyingBusy, true);
    final Either<Failure, VerificationResponseModel> result =
        await _authenticationRepository.verify(
            verificationRequestModel:
                VerificationRequestModel(otp: otp, phone: phoneNumber));
    result.fold(
      (Failure failute) => _showError(failute.message),
      (VerificationResponseModel model) async {
        setBusyForObject(verifyingBusy, false);
        if (model.user.otpVerified) {
          await _userDataService.saveData(model.token, model.user);
          _navigationService.popRepeated(2);
        }
      },
    );
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Login Failure",
      description: message,
    );
    setBusy(false);
  }
}

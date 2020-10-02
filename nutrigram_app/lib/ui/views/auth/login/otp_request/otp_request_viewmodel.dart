import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/otp_request_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class OtpRequestViewModel extends BaseViewModel {
  final DialogService _dialogService;
  final IAuthenticationRepository _authenticationRepository;

  OtpRequestViewModel(this._dialogService, this._authenticationRepository);
  Future<bool> getForgetPasswordOTP(String phone) async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 3));
    final Either<Failure, OtpRequestResponseModel> resp =
        await _authenticationRepository.getPasswordResetOTP(phone);
    return resp.fold((l) {
      _showError(l.message);
      setBusy(false);
      return false;
    }, (r) async {
      await _showMessage("${r.message}\n${r.otp}");
      setBusy(false);
      return true;
    });
  }

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

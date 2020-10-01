import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/profile/update_profile_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;

@injectable
class VerifyPhoneViewModel extends BaseViewModel {
  final IProfileRepository _profileRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final UpdateProfileService _updateProfileService;
  final UserDataService _userDataService;

  VerifyPhoneViewModel(
    this._profileRepository,
    this._dialogService,
    this._navigationService,
    this._updateProfileService,
    this._userDataService,
  );
  String _otp;

  // ignore: use_setters_to_change_properties
  void onOtpChanged(String value) => _otp = value;
  Future<void> updatePhone() async {
    setBusy(true);
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.updatePhone(UpdatePhoneRequestModel(
            otp: _otp, phone: _updateProfileService.tempPhone));
    response.fold((Failure l) async {
      await _showError(l.message);
    }, (ProfileResponseModel r) async {
      await _userDataService.saveUser(r.user);
      _navigationService.popRepeated(2);
    });
    setBusy(false);
  }

  Future<void> _showError(String message) async {
    await _dialogService.showDialog(
      title: "Login Failure",
      description: message,
    );
    setBusy(false);
  }

  // ignore: unused_element
  Future<void> _showMessage(String message) async {
    await _dialogService.showDialog(
      title: "Verification code",
      description: message,
    );
    setBusy(false);
  }

  String validateOtp(String otp) => validators.validateOtp(otp);
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/profile/update_profile_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;

@injectable
class UpdateProfileFormViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final IProfileRepository _profileRepository;
  final DialogService _dialogService;
  final UpdateProfileService _updateProfileService;
  UpdateProfileFormViewModel(this._userDataService, this._profileRepository,
      this._dialogService, this._updateProfileService) {
    _newName = _userDataService.user.name;
    _newPhone = _userDataService.user.phone;
  }
  String get name => _userDataService.user.name;
  String get phone => _userDataService.user.phone;

  Future<bool> updateProfile() async {
    setBusy(true);
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.updateProfile(UpdateProfileRequestModel(
      name: _newName,
      currentPassword: _currentPassword,
      newPassword: _newPassword,
      phone: _newPhone,
    ));
    return response.fold((Failure l) async {
      setBusy(false);
      await _showError(l.message);
      return false;
    }, (ProfileResponseModel r) async {
      setBusy(false);
      await _userDataService.saveUser(r.user);
      notifyListeners();
      if (phone != _newPhone && r.otp.isNotEmpty) {
        _updateProfileService.tempPhone = _newPhone;
        await _showMessage("Verification code is ${r.otp}");
        return true;
      }
      return false;
    });
  }

  Future<void> _showError(String message) async {
    await _dialogService.showDialog(
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

  String _newName;
  String _newPhone;
  String _newPassword = "";
  String get newPassword => _newPassword;
  String _currentPassword;

  String validatePhone(String phone) => validators.validatePhone(phone);
  String validateName(String name) => validators.validateName(name);
  String validatePassword(String value) {
    return validators.validatePassword(value);
  }

  // ignore: use_setters_to_change_properties
  void onNameChanged(String p1) => _newName = p1;

  // ignore: use_setters_to_change_properties
  void onCurrentPasswordChanged(String p1) => _currentPassword = p1;

  // ignore: use_setters_to_change_properties
  void onPhoneChanged(String p1) => _newPhone = p1;

  // ignore: use_setters_to_change_properties
  void onNewPasswordChanged(String p1) => _newPassword = p1;
}

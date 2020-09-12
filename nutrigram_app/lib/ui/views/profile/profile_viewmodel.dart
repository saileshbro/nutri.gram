import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/common/helpers/validators.dart' as validators;
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final IProfileRepository _profileRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  String get imageUrl =>
      "https://th.bing.com/th/id/OIP.t7coTbCbSZ8gixh06SwCOgHaE8?pid=Api&rs=1";
  String get namme => _userDataService.name;
  String get phone => _userDataService.phone;
  ProfileViewModel(this._userDataService, this._profileRepository,
      this._dialogService, this._navigationService);
  String get totalScans => "200";
  String get totalSaved => "500";
  String get totalCalories => "7000kcal";
  String tempPhone;
  Future<bool> updateProfile({
    String name,
    String phone,
    String currentPassword,
    String password,
  }) async {
    setBusy(true);
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.updateProfile(UpdateProfileRequestModel(
      name: name,
      currentPassword: currentPassword,
      newPassword: password,
      phone: phone,
    ));
    return response.fold((Failure l) async {
      setBusy(false);
      await _showError(l.message);
      return false;
    }, (ProfileResponseModel r) async {
      setBusy(false);
      await _userDataService.saveName(r.user.name);
      notifyListeners();
      if (this.phone != phone && r.otp.isNotEmpty) {
        tempPhone = phone;
        await _showMessage("Verification code is ${r.otp}");
        return true;
      }
      return false;
    });
  }

  Future<void> updatePhone(String otp) async {
    setBusy(true);
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository
            .updatePhone(UpdatePhoneRequestModel(otp: otp, phone: tempPhone));
    response.fold((Failure l) async {
      await _showError(l.message);
    }, (ProfileResponseModel r) async {
      await _userDataService.savePhone(r.user.phone);
    });
    setBusy(false);
  }

  String validatePhone(String phone) => validators.validatePhone(phone);
  String validateName(String name) => validators.validateName(name);
  String validatePassword(String value) {
    return validators.validatePassword(value);
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

  String validateOtp(String otp) => validators.validateOtp(otp);
  Future<void> logout() async {
    await _userDataService.clearData();
    notifyListeners();
    return;
  }
}

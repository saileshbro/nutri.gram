import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  final IProfileRepository _profileRepository;
  String get imageUrl => _userDataService.user.imageUrl;
  bool get isLoggedIn => _userDataService.isLoggedIn;
  String get namme => _userDataService.user.name;
  String get phone => _userDataService.user.phone;
  ProfileViewModel(
    this._userDataService,
    this._navigationService,
    this._profileRepository,
  );
  String get totalScans => "200";
  String get totalSaved => "500";
  String get totalCalories => "7000kcal";

  Future<void> logout() async {
    await _userDataService.clearData();
    notifyListeners();
    return;
  }

  void goToImagePicker() {
    _navigationService.navigateTo(Routes.changeImageView);
  }

  Future<void> getMyProfile() async {
    if (!isLoggedIn) {
      return;
    }
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.getMyProfile();

    response.fold((Failure l) {}, (ProfileResponseModel r) async {
      await _userDataService.saveUser(r.user);
      notifyListeners();
    });
    notifyListeners();
  }
}

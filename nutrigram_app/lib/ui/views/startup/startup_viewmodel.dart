import 'package:dartz/dartz.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;
  final IProfileRepository _profileRepository;
  final UserDataService _userDataService;
  StartUpViewModel(this._navigationService, this._sharedPreferencesService,
      this._userDataService, this._profileRepository);
  Future<void> handleStartupViewLogic() async {
    if (!_sharedPreferencesService.onboardingVisited) {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        _navigationService.clearStackAndShow(Routes.onboardingView);
      });
    } else {
      if (_userDataService.isLoggedIn) {
        await _getMyProfile();
      }
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        _navigationService.clearStackAndShow(Routes.dashboardView);
      });
      notifyListeners();
    }
  }

  Future<void> _getMyProfile() async {
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.getMyProfile();
    response.fold((Failure l) {}, (ProfileResponseModel r) async {
      await _userDataService.saveUser(r.user);
    });
    return;
  }
}

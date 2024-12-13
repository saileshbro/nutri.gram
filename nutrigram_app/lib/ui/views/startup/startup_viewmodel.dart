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

  StartUpViewModel(
    this._navigationService,
    this._sharedPreferencesService,
    this._userDataService,
    this._profileRepository,
  );

  Future<void> handleStartupViewLogic() async {
    if (!_sharedPreferencesService.onboardingVisited) {
      // Navigate to Onboarding
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.clearStackAndShow(const OnboardingView());
      });
    } else {
      if (_userDataService.isLoggedIn) {
        await _getMyProfile();
      }
      // Navigate to Dashboard
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _navigationService.clearStackAndShow(const DashboardView());
      });
    }
    notifyListeners();
  }

  Future<void> _getMyProfile() async {
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.getMyProfile();
    response.fold((Failure failure) {
      // Handle failure
    }, (ProfileResponseModel profile) async {
      await _userDataService.saveUser(profile.user);
    });
  }
}

import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;
  final UserDataService _userDataService;
  StartUpViewModel(this._navigationService, this._sharedPreferencesService,
      this._userDataService);
  Future handleStartupViewLogic() async {
    if (!_sharedPreferencesService.isOnboardingVisited()) {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        _navigationService.clearStackAndShow(Routes.onboardingView);
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timestamp) {
        _navigationService.clearStackAndShow(Routes.loginView);
      });
    }
  }
}

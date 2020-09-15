import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class OnboardingViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;
  OnboardingViewModel(this._navigationService, this._sharedPreferencesService);
  Future<void> onButtonPressed() async {
    await _sharedPreferencesService.setOnboardingVisited();
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }
}

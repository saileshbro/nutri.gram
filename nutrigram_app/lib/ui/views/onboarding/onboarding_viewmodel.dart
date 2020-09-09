import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class OnboardingViewModel extends IndexTrackingViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  void onButtonPressed() {
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}

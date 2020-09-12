import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class HomeViewModel extends BaseViewModel {
  final List<HealthTip> _healthTipList = <HealthTip>[];
  final IHomeRepository _homeRepository;
  final UserDataService userDataService;
  Function _onScanPressed;
  Function _onGotoProfilePressed;
  bool _tipsSliderAutoplay = true;
  bool get tipsSliderAutoplay => _tipsSliderAutoplay;
  final NavigationService _navigationService;
  bool get hasScannedData => false;
  void pauseSlider() {
    _tipsSliderAutoplay = false;
    notifyListeners();
  }

  // ignore: avoid_setters_without_getters
  set onScanPressed(Function f) {
    _onScanPressed = f;
  }

  // ignore: avoid_setters_without_getters
  set onGotoProfilePressed(Function f) {
    _onGotoProfilePressed = f;
  }

  void resumeSlider() {
    _tipsSliderAutoplay = true;
    notifyListeners();
  }

  HomeViewModel(
      this._homeRepository, this.userDataService, this._navigationService);
  List<HealthTip> get healthTipList => _healthTipList;
  Future<void> init() async {
    setBusy(true);
    final Either<Failure, HealthTipsResponseModel> response =
        await _homeRepository.getHealthTips();
    response.fold((Failure f) => setError(f.message),
        (HealthTipsResponseModel r) => _healthTipList.addAll(r.tips));
    setBusy(false);
  }

  void goToScan() {
    _onScanPressed();
  }

  void goToLogin() {
    if (!userDataService.isLoggedIn) {
      _navigationService.navigateTo(Routes.loginView);
    }
  }

  void goToGraph() {}

  void goToProfile() {
    _onGotoProfilePressed();
  }
}

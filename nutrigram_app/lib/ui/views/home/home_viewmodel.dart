import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/services/total_scan_data_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class HomeViewModel extends BaseViewModel {
  final List<HealthTip> _healthTipList = <HealthTip>[];
  final TotalScanDataService _totalScanDataService;
  final IHomeRepository _homeRepository;
  final UserDataService userDataService;
  Function _onScanPressed;
  Function _onGotoProfilePressed;
  bool _tipsSliderAutoplay = true;
  bool get tipsSliderAutoplay => _tipsSliderAutoplay;
  final NavigationService _navigationService;
  bool get hasScannedData => _totalScanDataService.totalScanData.isNotEmpty;
  List<Nutrient> get allScannedData => _totalScanDataService.totalScanData;
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

  HomeViewModel(this._homeRepository, this.userDataService,
      this._navigationService, this._totalScanDataService);
  List<HealthTip> get healthTipList => _healthTipList;
  Future<void> init() async {
    setBusy(true);
    await refresh();
    setBusy(false);
  }

  Future<void> refresh() async {
    await getTotalScanData();
    final Either<Failure, HealthTipsResponseModel> response =
        await _homeRepository.getHealthTips();
    response.fold((Failure f) => setError(f.message),
        (HealthTipsResponseModel r) => _healthTipList.addAll(r.tips));
  }

  void goToScan() {
    _onScanPressed();
  }

  Future goToLogin() async {
    if (!userDataService.isLoggedIn) {
      await _navigationService.navigateTo(Routes.loginView);
      await getTotalScanData();
    }
    return null;
  }

  Future<void> getTotalScanData() async {
    if (!userDataService.isLoggedIn) return;
    final Either<Failure, TotalScanDataResponseModel> response =
        await _homeRepository.getTotalScanData();
    response.fold((Failure f) => setError(f.message),
        (TotalScanDataResponseModel r) {
      _totalScanDataService.totalScanData = r.data;
      notifyListeners();
    });
  }

  void goToGraph() {
    _navigationService.navigateTo(
      Routes.viewMoreGraphView,
      arguments: ViewMoreGraphViewArguments(
        nutrients: allScannedData,
        name: "All scan results",
        date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
        searchTerm: "",
      ),
    );
  }

  void goToProfile() => _onGotoProfilePressed?.call();
}

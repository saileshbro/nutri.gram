import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:nutrigram_app/services/total_scan_data_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;
  final TotalScanDataService _totalScanDataService;
  final IHomeRepository _homeRepository;
  // ignore: avoid_setters_without_getters
  set goToScanPage(VoidCallback gotoHistoryPage) {
    _onGotoScanPressed = gotoHistoryPage;
  }

  bool get hasScannedData => _totalScanDataService.totalScanData.isNotEmpty;
  List<Nutrient> get allScannedData => _totalScanDataService.totalScanData;
  final IProfileRepository _profileRepository;
  String get imageUrl => _userDataService.user.imageUrl;
  bool get isLoggedIn => _userDataService.isLoggedIn;
  String get namme => _userDataService.user.name;
  VoidCallback _onGotoHistoryPressed;
  VoidCallback _onGotoScanPressed;
  String get phone => _userDataService.user.phone;
  ProfileViewModel(
    this._userDataService,
    this._navigationService,
    this._profileRepository,
    this._sharedPreferencesService,
    this._totalScanDataService,
    this._homeRepository,
  );
  String get totalScans => _sharedPreferencesService.totalScanned.toString();
  String get totalSaved => _userDataService.user.totalSaved.toString();
  String get totalCalories => _userDataService.user.totalCalories.toString();

  // ignore: avoid_setters_without_getters
  set gotoHistoryPage(VoidCallback gotoHistoryPage) {
    _onGotoHistoryPressed = gotoHistoryPage;
  }

  Future<void> logout() async {
    _totalScanDataService.totalScanData = [];
    await _userDataService.clearData();
    notifyListeners();
    return;
  }

  Future<void> goToImagePicker() async {
    await _navigationService.navigateTo(Routes.changeImageView);
    await getMyProfile();
  }

  Future<void> getMyProfile() async {
    if (!isLoggedIn) {
      return;
    }
    await getTotalScanData();
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.getMyProfile();
    response.fold((Failure l) {}, (ProfileResponseModel r) async {
      await _userDataService.saveUser(r.user);
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> getTotalScanData() async {
    if (!_userDataService.isLoggedIn) return;
    final Either<Failure, TotalScanDataResponseModel> response =
        await _homeRepository.getTotalScanData();
    response.fold((Failure f) => setError(f.message),
        (TotalScanDataResponseModel r) {
      _totalScanDataService.totalScanData = r.data;
      notifyListeners();
    });
  }

  void goToHistory() => _onGotoHistoryPressed?.call();
  void goToScan() => _onGotoScanPressed?.call();
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

  Future<void> goToLogin() async {
    if (!_userDataService.isLoggedIn) {
      await _navigationService.navigateTo(Routes.loginView);
      await getTotalScanData();
    }
  }
}

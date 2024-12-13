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
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;
  final TotalScanDataService _totalScanDataService;
  final IHomeRepository _homeRepository;
  final IProfileRepository _profileRepository;

  // Callbacks for navigation
  VoidCallback? _onGotoHistoryPressed;
  VoidCallback? _onGotoScanPressed;

  // Getters for data from the services
  bool get hasScannedData => _totalScanDataService.totalScanData.isNotEmpty;
  List<Nutrient> get allScannedData => _totalScanDataService.totalScanData;
  String get imageUrl => _userDataService.user.imageUrl;
  bool get isLoggedIn => _userDataService.isLoggedIn;
  String get name => _userDataService.user.name;
  String get phone => _userDataService.user.phone;
  String get totalScans => _sharedPreferencesService.totalScanned.toString();
  String get totalSaved => _userDataService.user.totalSaved.toString();
  String get totalCalories => _userDataService.user.totalCalories.toString();

  // Constructor
  ProfileViewModel(
    this._userDataService,
    this._navigationService,
    this._profileRepository,
    this._sharedPreferencesService,
    this._totalScanDataService,
    this._homeRepository,
  );

  // Single setter for callbacks
  set goToScanPage(VoidCallback gotoScanPage) {
    _onGotoScanPressed = gotoScanPage;
  }

  set goToHistoryPage(VoidCallback gotoHistoryPage) {
    _onGotoHistoryPressed = gotoHistoryPage;
  }

  // Logout functionality
  Future<void> logout() async {
    _totalScanDataService.totalScanData = [];
    await _userDataService.clearData();
    notifyListeners();
  }

  // Navigate to image picker
  Future<void> goToImagePicker() async {
    await _navigationService.navigateTo(Routes.changeImageView);
    await getMyProfile(); // Refresh profile data after image change
  }

  // Fetch profile data
  Future<void> getMyProfile() async {
    if (!isLoggedIn) return; // Check if user is logged in

    await getTotalScanData(); // Fetch scan data
    final Either<Failure, ProfileResponseModel> response =
        await _profileRepository.getMyProfile();

    response.fold(
      (Failure failure) {
        _showError(failure.message); // Show error on failure
      },
      (ProfileResponseModel profile) async {
        await _userDataService.saveUser(profile.user);
        notifyListeners(); // Notify listeners after saving profile
      },
    );
  }

  // Fetch total scan data
  Future<void> getTotalScanData() async {
    if (!_userDataService.isLoggedIn) return; // Check if user is logged in

    final Either<Failure, TotalScanDataResponseModel> response =
        await _homeRepository.getTotalScanData();

    response.fold(
      (Failure failure) {
        _showError(failure.message); // Show error on failure
      },
      (TotalScanDataResponseModel scanData) {
        _totalScanDataService.totalScanData = scanData.data;
        notifyListeners(); // Notify listeners after fetching scan data
      },
    );
  }

  // Navigation handlers
  void goToHistory() => _onGotoHistoryPressed?.call();
  void goToScan() => _onGotoScanPressed?.call();

  // Navigate to graph view
  void goToGraph() {
    _navigationService.navigateTo(
      ViewMoreGraphView(
        nutrients: allScannedData,
        name: "All scan results",
        date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
      ),
    );
  }

  // Navigate to login screen if not logged in
  Future<void> goToLogin() async {
    if (!_userDataService.isLoggedIn) {
      await _navigationService.navigateTo(Routes.loginView);
      await getTotalScanData(); // Fetch scan data after login
    }
  }

  // Show error dialog
  void _showError(String message) {
    _navigationService.clearStackAndShow(
      title: "Error",
      description: message,
    );
  }
}

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  String get imageUrl => _userDataService.imageUrl;
  String get namme => _userDataService.name;
  String get phone => _userDataService.phone;
  ProfileViewModel(
    this._userDataService,
    this._navigationService,
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
}

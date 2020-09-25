import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class NutrientInfoDisplayViewModel extends BaseViewModel {
  final UserDataService _userDataService;
  final IScanRepository _scanRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  NutrientInfoDisplayViewModel(this._userDataService, this._scanRepository,
      this._dialogService, this._navigationService);
  bool get isLoggedIn => _userDataService.isLoggedIn;
  Future<void> saveScanData(ScanRequestModel model) async {
    setBusy(true);
    final Either<Failure, bool> resp =
        await _scanRepository.saveScanedResult(model);
    resp.fold(
      (Failure l) => _showError(l.message),
      (r) => _navigationService.back(),
    );
    setBusy(false);
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Error while saving",
      description: message,
    );
    setBusy(false);
  }
}

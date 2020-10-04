import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:nutrigram_app/services/total_scan_data_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';

@lazySingleton
class HistoryViewModel extends BaseViewModel {
  List<History> _historyItems = [];
  List<History> get historyItems => _historyItems;
  final IScanRepository _scanRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final TotalScanDataService _totalScanDataService;
  final UserDataService _userDataService;
  final IHomeRepository _homeRepository;
  bool get isLoggedIn => _userDataService.isLoggedIn;
  HistoryViewModel(
      this._scanRepository,
      this._dialogService,
      this._userDataService,
      this._navigationService,
      this._homeRepository,
      this._totalScanDataService);
  Future<void> init() async {
    setBusy(true);
    _historyItems = await _fetch();
    setBusy(false);
  }

  Future<void> refresh() async {
    _historyItems = await _fetch();
    notifyListeners();
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Error while saving",
      description: message,
    );
    setBusy(false);
  }

  Future<void> onDeletePressed(History historyItem) async {
    final DialogResponse response = await _dialogService.showConfirmationDialog(
      confirmationTitle: "DELETE",
      description: "Are you sure want to delete ${historyItem.foodName}?",
      title: "Delete saved",
      cancelTitle: "CANCEL",
    );
    if (response.confirmed) {
      await _scanRepository.removeFromHistory(historyItem);
      _historyItems.remove(historyItem);
      notifyListeners();
    }
  }

  void onHistoryCardPressed(History historyItem) {
    _navigationService.navigateTo(Routes.viewMoreGraphView,
        arguments: ViewMoreGraphViewArguments(
          nutrients: historyItem.data,
          date: historyItem.createdAt,
          name: historyItem.foodName,
          searchTerm: historyItem.searchTerm ?? "",
        ));
  }

  Future<List<History>> _fetch() async {
    await getTotalScanData();
    final Either<Failure, HistoryResponseModel> resp =
        await _scanRepository.getScanHistory();
    return resp.fold((Failure l) {
      _showError(l.message);
      return [];
    }, (r) => r.history);
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
}

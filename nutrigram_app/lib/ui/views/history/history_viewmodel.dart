import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';

import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:nutrigram_app/datamodels/failure.dart';

import '../../../app/router.gr.dart';
import '../../../services/user_data_service.dart';

@lazySingleton
class HistoryViewModel extends BaseViewModel {
  List<History> _historyItems = [];
  List<History> get historyItems => _historyItems;
  final IScanRepository _scanRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final UserDataService _userDataService;
  bool get isLoggedIn => _userDataService.isLoggedIn;
  HistoryViewModel(this._scanRepository, this._dialogService,
      this._userDataService, this._navigationService);
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
    final Either<Failure, HistoryResponseModel> resp =
        await _scanRepository.getScanHistory();
    return resp.fold((Failure l) {
      _showError(l.message);
      return [];
    }, (r) => r.history);
  }
}

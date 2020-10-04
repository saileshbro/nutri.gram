import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';

import 'package:nutrigram_app/datamodels/search/search_response_model.dart';
import 'package:nutrigram_app/repository/search/i_search_repository.dart';

import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:nutrigram_app/datamodels/nutrient.dart';

@lazySingleton
class SearchViewModel extends BaseViewModel {
  final ISearchRepository _searchRepository;
  String _query = "";
  final DialogService _dialogService;
  final NavigationService _navigationService;
  // ignore: avoid_setters_without_getters
  set query(String value) => _query = value;
  SearchResponseModel _responseModel;
  final SharedPreferencesService _sharedPreferencesService;
  String get imageUrl => _responseModel?.imageUrl ?? "";
  List<Nutrient> get nutrients => _responseModel.data;
  String get name => _responseModel?.foodName ?? "";
  bool get hasSearchResult => _responseModel != null;
  SearchViewModel(this._searchRepository, this._dialogService,
      this._navigationService, this._sharedPreferencesService);
  Future<void> getSearchData() async {
    setBusy(true);
    _sharedPreferencesService.incremenntTotalScanned();
    final Either<Failure, SearchResponseModel> resp =
        await _searchRepository.getSearchResults(_query);
    resp.fold((Failure l) => _showError(l.message),
        (SearchResponseModel r) => _responseModel = r);
    setBusy(false);
  }

  String validateQuery(String p1) {
    if (p1.isEmpty) {
      return "Empty search String provided";
    }
    return null;
  }

  void onFoodTap() {
    _navigationService.navigateTo(
      Routes.nutrientInfoDisplayView,
      arguments: NutrientInfoDisplayViewArguments(
        nutrients: nutrients,
        name: name,
        searchTerm: _query,
        showSaveButton: true,
        date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
      ),
    );
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Search Failure",
      description: message,
    );
    setBusy(false);
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/datamodels/search/search_response_model.dart';
import 'package:nutrigram_app/repository/search/i_search_repository.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class SearchViewModel extends BaseViewModel {
  final ISearchRepository _searchRepository;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final SharedPreferencesService _sharedPreferencesService;

  late SearchResponseModel _responseModel; // Initialized later
  String _query = "";

  SearchViewModel(
    this._searchRepository,
    this._dialogService,
    this._navigationService,
    this._sharedPreferencesService,
  );

  // Getter and setter for query
  String get query => _query;
  set query(String value) => _query = value;

  // Computed properties for search result
  String get imageUrl => _responseModel.imageUrl;
  List<Nutrient> get nutrients => _responseModel.data;
  String get name => _responseModel.foodName;
  bool get hasSearchResult => _responseModel.data.isNotEmpty;

  /// Fetches search data
  Future<void> getSearchData() async {
    if (_query.isEmpty) {
      _showError("Please enter a valid search query.");
      return;
    }

    setBusy(true);
    try {
      _sharedPreferencesService.incremenntTotalScanned();
      final Either<Failure, SearchResponseModel> resp =
          await _searchRepository.getSearchResults(_query);

      resp.fold(
        (Failure failure) => _showError(failure.message),
        (SearchResponseModel result) => _responseModel = result,
      );
    } catch (e) {
      _showError("An unexpected error occurred. Please try again.");
      rethrow; // Optionally rethrow for logging
    } finally {
      setBusy(false);
    }
  }

  /// Validates query input
  String? validateQuery(String input) {
    return input.isEmpty ? "Search query cannot be empty." : null;
  }

  /// Navigates to food details
  void onFoodTap() {
    _navigationService.navigateTo(
      NutrientInfoDisplayView(
        nutrients: nutrients,
        name: name,
        searchTerm: _query,
        showSaveButton: true,
        date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
      ),
    );
  }

  /// Handles errors by showing a dialog
  void _showError(String message) {
    _dialogService.showDialog(
      title: "Search Error",
      description: message,
    );
  }
}

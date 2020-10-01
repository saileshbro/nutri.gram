import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/search/search_response_model.dart';
import 'package:nutrigram_app/repository/search/i_search_repository.dart';

import 'package:nutrigram_app/services/api/i_api_service.dart';

@LazySingleton(as: ISearchRepository)
class RSearchRepository implements ISearchRepository {
  final IApiService _apiService;

  RSearchRepository(this._apiService);
  @override
  Future<Either<Failure, SearchResponseModel>> getSearchResults(
      String query) async {
    try {
      final SearchResponseModel respModel =
          await _apiService.getSearchResults(query);
      return right(respModel);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

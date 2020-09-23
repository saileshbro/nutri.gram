import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/search/search_response_model.dart';

@LazySingleton(as: ISearchRepository)
abstract class ISearchRepository {
  Future<Either<Failure, SearchResponseModel>> getSearchResults(String query);
}

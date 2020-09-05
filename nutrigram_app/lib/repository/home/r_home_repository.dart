import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

@LazySingleton(as: IHomeRepository)
class RHomeRepository implements IHomeRepository {
  final IApiService _apiService;

  RHomeRepository(this._apiService);
  @override
  Future<Either<Failure, HealthTipsResponseModel>> getHealthTips() async {
    try {
      final HealthTipsResponseModel model = await _apiService.getHealthTips();
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

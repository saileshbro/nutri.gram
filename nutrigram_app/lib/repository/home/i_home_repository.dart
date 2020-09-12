import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';

abstract class IHomeRepository {
  Future<Either<Failure, HealthTipsResponseModel>> getHealthTips();
}

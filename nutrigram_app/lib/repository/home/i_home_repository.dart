import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';

abstract class IHomeRepository {
  Future<Either<Failure, HealthTipsResponseModel>> getHealthTips();
  Future<Either<Failure, TotalScanDataResponseModel>> getTotalScanData();
}

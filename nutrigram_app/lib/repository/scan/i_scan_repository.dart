import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';

abstract class IScanRepository {
  Future<Either<Failure, bool>> saveScanedResult(ScanRequestModel model);
}

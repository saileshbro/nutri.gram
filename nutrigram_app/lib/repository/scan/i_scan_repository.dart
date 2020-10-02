import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_response_model.dart';

abstract class IScanRepository {
  Future<Either<Failure, bool>> saveScanedResult(ScanRequestModel model);
  Future<Either<Failure, HistoryResponseModel>> getScanHistory();
  Future<Either<Failure, ScanResponseModel>> getScanData(File image);
  Future<Either<Failure, bool>> removeFromHistory(History history);
}

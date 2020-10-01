import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/scan/scan_response_model.dart';
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

@LazySingleton(as: IScanRepository)
class RScanRepository extends IScanRepository {
  final IApiService _apiService;

  RScanRepository(this._apiService);
  @override
  Future<Either<Failure, bool>> saveScanedResult(ScanRequestModel model) async {
    try {
      final bool resp = await _apiService.saveScan(model);
      return right(resp);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, HistoryResponseModel>> getScanHistory() async {
    try {
      final HistoryResponseModel resp = await _apiService.getScanHistory();
      return right(resp);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromHistory(History history) async {
    try {
      final bool resp = await _apiService.removeFromHistory(history);
      return right(resp);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, ScanResponseModel>> getScanData(File image) async {
    try {
      final ScanResponseModel resp =
          await _apiService.getScanResult(image, "scan_image");
      return right(resp);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

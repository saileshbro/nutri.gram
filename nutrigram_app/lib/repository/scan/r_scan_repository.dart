import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:dartz/dartz.dart';
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
}

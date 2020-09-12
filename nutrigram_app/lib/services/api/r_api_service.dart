import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IApiService)
class RApiService implements IApiService {
  final HttpService _httpService;
  RApiService(this._httpService);
  @override
  Future<HealthTipsResponseModel> getHealthTips() async {
    try {
      return _httpService.get(url: '/tips').handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return HealthTipsResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}

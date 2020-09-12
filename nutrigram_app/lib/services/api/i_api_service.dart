import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';

abstract class IApiService {
  Future<HealthTipsResponseModel> getHealthTips();
}

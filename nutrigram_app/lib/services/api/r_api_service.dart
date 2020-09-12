import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IApiService)
class RApiService implements IApiService {
  final HttpService _httpService;
  RApiService(this._httpService);
  @override
  Future<HealthTipsResponseModel> getHealthTips() async {
    try {
      return _httpService.get(url: 'tips').handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return HealthTipsResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ProfileResponseModel> updatePhone(UpdatePhoneRequestModel model) {
    try {
      return _httpService
          .post(url: 'users/update_phone', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return ProfileResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ProfileResponseModel> updateProfile(UpdateProfileRequestModel model) {
    try {
      return _httpService
          .post(url: 'users/update_profile', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return ProfileResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}

import 'dart:io';

import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';

abstract class IApiService {
  Future<HealthTipsResponseModel> getHealthTips();
  Future<ProfileResponseModel> updateProfile(UpdateProfileRequestModel model);
  Future<ProfileResponseModel> updatePhone(UpdatePhoneRequestModel model);
  Future<ProfileResponseModel> getProfile();
  Future<bool> updateAvatar(File image, String fieldName);
}

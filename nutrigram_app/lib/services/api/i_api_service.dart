import 'dart:io';

import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_avatar_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_response_model.dart';
import 'package:nutrigram_app/datamodels/search/search_response_model.dart';

abstract class IApiService {
  Future<HealthTipsResponseModel> getHealthTips();
  Future<ProfileResponseModel> updateProfile(UpdateProfileRequestModel model);
  Future<ProfileResponseModel> updatePhone(UpdatePhoneRequestModel model);
  Future<ProfileResponseModel> getMyProfile();
  Future<SearchResponseModel> getSearchResults(String query);
  Future<UpdateAvatarResponseModel> updateAvatar(File image, String fieldName);
  Future<ScanResponseModel> getScanResult(File image, String fieldName);
  Future<bool> saveScan(ScanRequestModel model);
  Future<HistoryResponseModel> getScanHistory();
  Future<TotalScanDataResponseModel> getTotalScanData();
  Future<bool> removeFromHistory(History history);
}

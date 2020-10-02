import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/history.dart';
import 'package:nutrigram_app/datamodels/history/history_response_model.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/datamodels/home/total_scan_data_response_model.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/datamodels/profile/update_avatar_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/datamodels/scan/scan_response_model.dart';
import 'package:nutrigram_app/datamodels/search/search_response_model.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IApiService)
class RApiService implements IApiService {
  final HttpService _httpService;
  final _logger = getLogger("RApiService");
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

  @override
  Future<UpdateAvatarResponseModel> updateAvatar(
      File image, String fieldName) async {
    try {
      final _ = await _httpService.uploadFile(
          url: 'users/update_avatar', fieldName: fieldName, file: image);
      return UpdateAvatarResponseModel.fromJson(_);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ProfileResponseModel> getMyProfile() {
    try {
      return _httpService.get(url: 'users/me').handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return ProfileResponseModel.fromJson({"user": _});
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<SearchResponseModel> getSearchResults(String query) {
    try {
      return _httpService.get(url: 'search?q=$query').handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return SearchResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<bool> saveScan(ScanRequestModel model) {
    try {
      return _httpService
          .post(
              url: 'scans/save_scan_result',
              encodedJson: jsonEncode(model.toJson()))
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return true;
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<HistoryResponseModel> getScanHistory() {
    try {
      return _httpService
          .get(
        url: 'scans/get_scan_history',
      )
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return HistoryResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<bool> removeFromHistory(History history) {
    try {
      return _httpService
          .post(
              url: 'scans/remove_from_history',
              encodedJson: jsonEncode({
                "_id": history.sId,
                "calories": history.data
                    .firstWhere(
                        (element) => element.unit.toLowerCase() == 'kcal',
                        orElse: () => Nutrient(value: 0))
                    .value
              }))
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return true;
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<TotalScanDataResponseModel> getTotalScanData() {
    try {
      return _httpService
          .get(
        url: 'scans/get_total_scanned',
      )
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return TotalScanDataResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<ScanResponseModel> getScanResult(File image, String fieldName) async {
    try {
      final response = await _httpService.uploadFile(
          url: 'scans/get_scan_result', fieldName: fieldName, file: image);
      return ScanResponseModel.fromJson(response);
    } catch (e) {
      _logger.e(e.toString());
      throw Failure(message: e.toString());
    }
  }
}

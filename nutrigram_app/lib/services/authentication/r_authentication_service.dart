import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/otp_request_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_request_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';
import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IAuthenticationService)
class RAuthenticationService implements IAuthenticationService {
  final HttpService _httpService;

  RAuthenticationService(this._httpService);

  @override
  Future<LoginResponseModel> login({@required LoginRequestModel model}) async {
    try {
      return _httpService
          .post(url: '/users/login', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return LoginResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<RegisterResponseModel> register({RegisterRequestModel model}) async {
    try {
      return _httpService
          .post(url: '/users/signup', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return RegisterResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<VerificationResponseModel> verify(
      {VerificationRequestModel model}) async {
    try {
      return _httpService
          .post(url: '/users/verify_otp', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return VerificationResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<OtpRequestResponseModel> getPasswordResetOTP({String phoneNo}) {
    try {
      return _httpService
          .post(
              url: '/users/forgot_password/get_otp',
              encodedJson: jsonEncode({"phone": phoneNo}))
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return OtpRequestResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<PassswordResetResponseModel> resetPasswordWithOtp(
      PassswordResetRequestModel model) {
    try {
      return _httpService
          .post(
              url: '/users/forgot_password/reset_password',
              encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return PassswordResetResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}

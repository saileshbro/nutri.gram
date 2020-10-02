import 'package:flutter/foundation.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/otp_request_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_response_model.dart';

abstract class IAuthenticationService {
  Future<LoginResponseModel> login({@required LoginRequestModel model});
  Future<RegisterResponseModel> register(
      {@required RegisterRequestModel model});
  Future<VerificationResponseModel> verify(
      {@required VerificationRequestModel model});
  Future<OtpRequestResponseModel> getPasswordResetOTP(
      {@required String phoneNo});
  Future<PassswordResetResponseModel> resetPasswordWithOtp(
      PassswordResetRequestModel model);
}

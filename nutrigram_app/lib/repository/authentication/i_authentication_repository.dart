import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/otp_request_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, LoginResponseModel>> login(
      {LoginRequestModel loginRequestModel});
  Future<Either<Failure, RegisterResponseModel>> register(
      {RegisterRequestModel registerRequestModel});
  Future<Either<Failure, VerificationResponseModel>> verify(
      {VerificationRequestModel verificationRequestModel});
  Future<Either<Failure, OtpRequestResponseModel>> getPasswordResetOTP(
      String phone);
  Future<Either<Failure, PassswordResetResponseModel>> resetPasswordWithOtp(
      PassswordResetRequestModel model);
}

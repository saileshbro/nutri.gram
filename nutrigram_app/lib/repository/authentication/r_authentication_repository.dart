import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/otp_request_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/password_reset/password_reset_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/verification/verification_request_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';

@LazySingleton(as: IAuthenticationRepository)
class RAuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationService _authenticationService;
  RAuthenticationRepository(this._authenticationService);

  @override
  Future<Either<Failure, LoginResponseModel>> login(
      {LoginRequestModel loginRequestModel}) async {
    try {
      final LoginResponseModel model =
          await _authenticationService.login(model: loginRequestModel);
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> register(
      {RegisterRequestModel registerRequestModel}) async {
    try {
      final RegisterResponseModel model =
          await _authenticationService.register(model: registerRequestModel);
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, VerificationResponseModel>> verify(
      {VerificationRequestModel verificationRequestModel}) async {
    try {
      final VerificationResponseModel model =
          await _authenticationService.verify(model: verificationRequestModel);
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, OtpRequestResponseModel>> getPasswordResetOTP(
      String phone) async {
    try {
      final OtpRequestResponseModel model =
          await _authenticationService.getPasswordResetOTP(phoneNo: phone);
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, PassswordResetResponseModel>> resetPasswordWithOtp(
      PassswordResetRequestModel model) async {
    try {
      final PassswordResetResponseModel resp =
          await _authenticationService.resetPasswordWithOtp(model);
      return right(resp);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/register/register_request_model.dart';
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
      print(registerRequestModel.toJson());

      final RegisterResponseModel model =
          await _authenticationService.register(model: registerRequestModel);
      return right(model);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

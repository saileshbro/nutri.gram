import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, LoginResponseModel>> login(
      {LoginRequestModel loginRequestModel});
}

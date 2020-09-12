import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';

@LazySingleton(as: IProfileRepository)
class RProfileRepository implements IProfileRepository {
  final IApiService _apiService;
  RProfileRepository(this._apiService);

  @override
  Future<Either<Failure, ProfileResponseModel>> updatePhone(
      UpdatePhoneRequestModel model) async {
    try {
      final ProfileResponseModel respModel =
          await _apiService.updatePhone(model);
      return right(respModel);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, ProfileResponseModel>> updateProfile(
      UpdateProfileRequestModel model) async {
    try {
      final ProfileResponseModel respModel =
          await _apiService.updateProfile(model);
      return right(respModel);
    } on Failure catch (e) {
      return left(e);
    }
  }
}

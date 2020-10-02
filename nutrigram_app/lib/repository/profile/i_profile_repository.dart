import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_avatar_response_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_phone_request_model.dart';
import 'package:nutrigram_app/datamodels/profile/update_profile_request_model.dart';

abstract class IProfileRepository {
  Future<Either<Failure, ProfileResponseModel>> updateProfile(
      UpdateProfileRequestModel model);
  Future<Either<Failure, ProfileResponseModel>> getMyProfile();
  Future<Either<Failure, ProfileResponseModel>> updatePhone(
      UpdatePhoneRequestModel model);
  Future<Either<Failure, UpdateAvatarResponseModel>> updateAvatar(File image);
}

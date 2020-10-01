import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/enums.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';
import 'package:nutrigram_app/services/media_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ChangeImageViewModel extends BaseViewModel {
  File _image;
  final IProfileRepository _profileRepository;
  final MediaService _mediaService;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  ChangeImageViewModel(this._iApiService, this._profileRepository,
      this._userDataService, this._mediaService, this._navigationService);
  File get image => _image;
  final IApiService _iApiService;

  bool get hasImage => _image != null;
  Future getNewImage() async {
    setBusy(true);
    File image = await _mediaService.getImage(fromGallery: true);
    image = await _mediaService.cropImage(image, ImageCropFormat.png);
    _image = image;
    setBusy(false);
  }

  Future<void> updateImage() async {
    setBusy(true);
    final bool isSuccess = await _iApiService.updateAvatar(image, "avatar");
    if (isSuccess) {
      final Either<Failure, ProfileResponseModel> response =
          await _profileRepository.getMyProfile();

      response.fold((Failure l) async {}, (ProfileResponseModel r) async {
        await _userDataService.saveUser(r.user);
        _navigationService.back();
      });
      notifyListeners();
    }
    setBusy(false);
  }
}

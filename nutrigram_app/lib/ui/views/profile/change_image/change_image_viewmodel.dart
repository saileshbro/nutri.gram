import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/update_avatar_response_model.dart';
import 'package:nutrigram_app/enums.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
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
  ChangeImageViewModel(this._profileRepository, this._userDataService,
      this._mediaService, this._navigationService);
  File get image => _image;

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
    final Either<Failure, UpdateAvatarResponseModel> resp =
        await _profileRepository.updateAvatar(image);
    resp.fold((Failure l) => null, (UpdateAvatarResponseModel r) async {
      await _userDataService.saveUser(r.user);
      _navigationService.back();
    });
    setBusy(false);
  }
}

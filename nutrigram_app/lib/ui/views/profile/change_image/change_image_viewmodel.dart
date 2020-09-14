import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/profile/profile_response_model.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';

@injectable
class ChangeImageViewModel extends BaseViewModel {
  File _image;
  final IProfileRepository _profileRepository;
  final UserDataService _userDataService;
  ChangeImageViewModel(
      this._iApiService, this._profileRepository, this._userDataService);
  File get image => _image;
  final IApiService _iApiService;

  final ImagePicker _imagePicker = ImagePicker();

  bool get hasImage => _image != null;
  Future getNewImage() async {
    setBusy(true);
    final image = await _imagePicker.getImage(source: ImageSource.gallery);
    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
      compressFormat: ImageCompressFormat.png,
    );
    _image = croppedFile;
    setBusy(false);
  }

  Future<void> updateImage() async {
    setBusy(true);
    final bool isSuccess = await _iApiService.updateAvatar(image, "avatar");
    if (isSuccess) {
      final Either<Failure, ProfileResponseModel> response =
          await _profileRepository.getMyProfile();
      response.fold((Failure l) async {}, (ProfileResponseModel r) async {
        await Future.wait([
          _userDataService.saveName(r.user.name),
          _userDataService.saveImage(r.user.imageUrl),
          _userDataService.savePhone(r.user.phone),
        ]);
      });
    }
    setBusy(false);
  }
}

import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';
import 'package:stacked/stacked.dart';

@injectable
class ChangeImageViewModel extends BaseViewModel {
  File _image;

  ChangeImageViewModel(this._iApiService);
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
    await _iApiService.updateAvatar(image, "avatar");
    setBusy(false);
  }
}

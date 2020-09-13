import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class ChangeImageViewModel extends BaseViewModel {
  File _image;
  File get image => _image;

  final ImagePicker _imagePicker = ImagePicker();
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
}

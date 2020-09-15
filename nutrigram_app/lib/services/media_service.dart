import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/enums.dart';

@lazySingleton
class MediaService {
  final ImagePicker _picker = ImagePicker();
  Future<File> getImage({bool fromGallery}) async {
    final PickedFile pickedFile = await _picker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    return File(pickedFile.path);
  }

  Future<File> cropImage(File image, ImageCropFormat compressFormat) async {
    final File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
      compressFormat: _getCompressionFormat(compressFormat),
    );
    return croppedImage;
  }

  ImageCompressFormat _getCompressionFormat(ImageCropFormat format) {
    switch (format) {
      case ImageCropFormat.jpg:
        return ImageCompressFormat.jpg;
        break;
      case ImageCropFormat.png:
        return ImageCompressFormat.png;
        break;
      default:
        return ImageCompressFormat.png;
    }
  }
}

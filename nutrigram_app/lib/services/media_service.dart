import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/enums.dart';

@lazySingleton
class MediaService {
  final Logger _logger = getLogger("MediaService");
  final ImagePicker _picker = ImagePicker();
  Future<File> getImage({bool fromGallery}) async {
    _logger.d("Picking Image");
    try {
      final PickedFile pickedFile = await _picker.getImage(
          source: fromGallery ? ImageSource.gallery : ImageSource.camera);
      _logger.d("Image Picked ${pickedFile.path}");
      return File(pickedFile.path);
    } catch (e) {
      _logger.wtf(e.toString());
      throw Failure(message: "User cancelled picking file", statusCode: 500);
    }
  }

  Future<File> cropImage(File image, ImageCropFormat compressFormat) async {
    try {
      _logger.d("Cropping Image");
      final File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxWidth: 512,
        maxHeight: 512,
        compressFormat: _getCompressionFormat(compressFormat),
      );
      _logger.d("Image Cropped ${croppedImage.path}");
      return croppedImage;
    } catch (e) {
      _logger.wtf(e.toString());
      throw Failure(message: e.toString(), statusCode: 500);
    }
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

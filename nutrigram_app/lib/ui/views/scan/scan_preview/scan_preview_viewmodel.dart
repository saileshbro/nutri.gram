import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/services/edge_detection_service.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ScanPreviewViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final _logger = getLogger("ScanPreviewViewModel");
  final EdgeDetectionService _edgeDetectionService;
  EdgeDetectionResult _edgeDetectionResult;
  File _image;
  EdgeDetectionResult get edgeDetectionResult => _edgeDetectionResult;
  ScanPreviewViewModel(this._navigationService, this._edgeDetectionService);

  Future<void> getScanResults() async {
    final val = await cropImage();
    if (val) {
      imageCache.clearLiveImages();
      imageCache.clear();
    }
    // call to api with the image `_image`
  }

  bool retakePicture() => _navigationService.back();

  Future<void> init(File image) async {
    setBusy(true);
    _image = image;
    _image
        .length()
        .then((value) => _logger.d("Image size before crop: $value"));
    _edgeDetectionResult = await _edgeDetectionService.getEdges(image);
    setBusy(false);
  }

  Future<bool> cropImage() async {
    if (_image == null || _edgeDetectionResult == null) {
      return false;
    }
    final val =
        await _edgeDetectionService.processImage(_image, _edgeDetectionResult);
    _image.length().then((value) => _logger.d("Image size after crop: $value"));
    return val;
  }
}

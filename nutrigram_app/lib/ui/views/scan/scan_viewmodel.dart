import 'dart:io';

import 'package:flutter_better_camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/camera_service.dart';
import 'package:nutrigram_app/services/media_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class ScanViewModel extends BaseViewModel {
  File _image;
  final CameraService _cameraService;
  final NavigationService _navigationService;
  final MediaService _mediaService;
  CameraController get controller => _cameraService.controller;
  ScanViewModel(
      this._cameraService, this._navigationService, this._mediaService);
  Future<void> init() async {
    setBusy(true);
    await _cameraService.initializeCameras();
    setBusy(false);
  }

  Future<void> takePicture() async {
    final File image = await _cameraService.takePicture();
    if (image != null) {
      _image = image;
      _navigationService.navigateTo(Routes.scanPreviewView,
          arguments: ScanPreviewViewArguments(image: _image));
    }
  }

  Future<void> pickPicture() async {
    final File image = await _mediaService.getImage(fromGallery: true);
    if (image != null) {
      _image = image;
      _navigationService.navigateTo(Routes.scanPreviewView,
          arguments: ScanPreviewViewArguments(image: _image));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

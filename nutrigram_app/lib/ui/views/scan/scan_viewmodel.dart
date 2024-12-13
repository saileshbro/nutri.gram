import 'dart:io';

import 'package:flutter_better_camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/services/camera_service.dart';
import 'package:nutrigram_app/services/media_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ScanViewModel extends BaseViewModel {
  File? _image; // Make image nullable
  final CameraService _cameraService;
  final NavigationService _navigationService;
  final MediaService _mediaService;

  CameraController get controller => _cameraService.controller;

  ScanViewModel(
    this._cameraService,
    this._navigationService,
    this._mediaService,
  );

  Future<void> init() async {
    setBusy(true);
    try {
      await _cameraService.initializeCameras();
    } catch (e) {
      print('Error initializing cameras: $e');
    }
    setBusy(false);
  }

  Future<void> takePicture() async {
    try {
      final File image = await _cameraService.takePicture();
      _image = image;
      notifyListeners();
      await _navigationService.navigateTo(
        ScanPreviewView(image: _image!),
      );
    } catch (e) {
      print('Error taking picture: $e');
    } finally {
      await _cameraService.initializeCameras();
    }
  }

  Future<void> pickPicture() async {
    _cameraService.dispose();
    try {
      final File image = await _mediaService.getImage(fromGallery: true);
      _image = image;
      notifyListeners();
      await _navigationService.navigateTo(
        ScanPreviewView(image: _image!),
      );
    } catch (e) {
      print('Error picking picture: $e');
    } finally {
      await _cameraService.initializeCameras();
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
}

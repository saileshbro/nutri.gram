import 'dart:io';

import 'package:flutter_better_camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class CameraService {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isActive = false;
  final Logger _logger = getLogger("CameraService");
  Future<void> initializeCameras() async {
    _logger.d("Initialize Cameras");
    cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.ultraHigh,
      flashMode: FlashMode.autoFlash,
    );
    await controller.initialize();
    isActive = true;
    return;
  }

  Future<File> takePicture() async {
    _logger.d("Taking Picture");
    final Directory exDir = await getApplicationDocumentsDirectory();
    final String dirPath = "${exDir.path}/scans";
    await Directory(dirPath).create(recursive: true);
    final String filePath =
        "$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg";
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.takePicture(filePath);
      _logger.d("Picture Taken");
    } on CameraException catch (e) {
      _logger.wtf(e.description);
      throw Failure(message: e.description, statusCode: 500);
    }
    return File(filePath);
  }

  void dispose() {
    _logger.d("Disposing Cameras");
    cameras = null;
    controller?.dispose();
    controller = null;
    isActive = false;
    return;
  }
}

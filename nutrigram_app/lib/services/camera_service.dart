import 'dart:io';

import 'package:flutter_better_camera/camera.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class CameraService {
  List<CameraDescription> cameras;
  CameraController controller;

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.ultraHigh,
      flashMode: FlashMode.autoFlash,
    );
    await controller.initialize();
  }

  Future<File> takePicture() async {
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
    } on CameraException catch (e) {
      throw Failure(message: e.description, statusCode: 500);
    }
    return File(filePath);
  }

  void dispose() {
    cameras = null;
    controller?.dispose();
    controller = null;
  }
}

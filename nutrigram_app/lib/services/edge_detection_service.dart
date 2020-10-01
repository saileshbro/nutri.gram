import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:simple_edge_detection/edge_detection.dart';

@lazySingleton
class EdgeDetectionService {
  final Logger _logger = getLogger("EdgeDetectionService");
  Future<EdgeDetectionResult> getEdges(File image) async {
    _logger.d("Getting Edges");
    try {
      final res = await EdgeDetection.detectEdges(image.path);
      _logger.d("Edges Received");
      return res;
    } catch (e) {
      _logger.wtf(e.toString());
      throw Failure(message: e.toString(), statusCode: 500);
    }
  }

  Future<bool> processImage(
      File file, EdgeDetectionResult edgeDetectionResult) async {
    if (file == null) {
      return false;
    }
    try {
      _logger.d("Processing Edges");
      final bool res =
          await EdgeDetection.processImage(file.path, edgeDetectionResult);
      _logger.d("Edges processed");
      return res;
    } catch (e) {
      _logger.wtf(e.toString());
      throw Failure(message: e.toString(), statusCode: 500);
    }
  }
}

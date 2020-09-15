import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:simple_edge_detection/edge_detection.dart';

@lazySingleton
class EdgeDetectionService {
  Future<EdgeDetectionResult> getEdges(File image) async {
    try {
      final res = await EdgeDetection.detectEdges(image.path);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}

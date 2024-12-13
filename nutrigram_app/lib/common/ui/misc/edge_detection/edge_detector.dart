import 'dart:async';
import 'dart:isolate';

import 'package:edge_detection/edge_detection.dart';

class EdgeDetector {
  /// Starts an isolate for edge detection.
  static Future<void> startEdgeDetectionIsolate(
    EdgeDetectionInput input,
  ) async {
    final result = await EdgeDetection.detectEdge(input.inputPath);
    input.sendPort.send(result);
  }

  /// Starts an isolate to process an image.
  static Future<void> processImageIsolate(ProcessImageInput input) async {
    await EdgeDetection.processImage(
      input.inputPath,
      input.edgeDetectionResult,
    );
    input.sendPort.send(true);
  }

  /// Detects edges in an image using an isolate.
  Future<EdgeDetectionResult> detectEdges(String filePath) async {
    final port = ReceivePort();
    _spawnIsolate<EdgeDetectionInput>(
      startEdgeDetectionIsolate,
      EdgeDetectionInput(inputPath: filePath, sendPort: port.sendPort),
      port,
    );
    return await _subscribeToPort<EdgeDetectionResult>(port);
  }

  /// Processes an image using the detected edges via an isolate.
  Future<bool> processImage(
    String filePath,
    EdgeDetectionResult edgeDetectionResult,
  ) async {
    final port = ReceivePort();
    _spawnIsolate<ProcessImageInput>(
      processImageIsolate,
      ProcessImageInput(
        inputPath: filePath,
        edgeDetectionResult: edgeDetectionResult,
        sendPort: port.sendPort,
      ),
      port,
    );
    return await _subscribeToPort<bool>(port);
  }

  /// Spawns an isolate with proper error and exit handling.
  void _spawnIsolate<T>(
    FutureOr<void> Function(T) entryPoint,
    T input,
    ReceivePort port,
  ) {
    Isolate.spawn<T>(
      entryPoint,
      input,
      onError: port.sendPort,
      onExit: port.sendPort,
    );
  }

  /// Listens to a [ReceivePort] and retrieves the first message sent through it.
  Future<T> _subscribeToPort<T>(ReceivePort port) async {
    final completer = Completer<T>();
    late final StreamSubscription sub;

    sub = port.listen((result) async {
      await sub.cancel(); // Safely cancel subscription
      if (!completer.isCompleted) {
        completer.complete(result as T);
      }
    });

    return completer.future;
  }
}

/// Input for the edge detection isolate.
class EdgeDetectionInput {
  const EdgeDetectionInput({
    required this.inputPath,
    required this.sendPort,
  });

  final String inputPath;
  final SendPort sendPort;
}

/// Input for the image processing isolate.
class ProcessImageInput {
  const ProcessImageInput({
    required this.inputPath,
    required this.edgeDetectionResult,
    required this.sendPort,
  });

  final String inputPath;
  final EdgeDetectionResult edgeDetectionResult;
  final SendPort sendPort;
}

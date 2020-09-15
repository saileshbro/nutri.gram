import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/services/edge_detection_service.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ScanPreviewViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final EdgeDetectionService _edgeDetectionService;
  EdgeDetectionResult _edgeDetectionResult;
  EdgeDetectionResult get edgeDetectionResult => _edgeDetectionResult;
  ScanPreviewViewModel(this._navigationService, this._edgeDetectionService);

  Function get getScanResults => null;
  bool retakePicture() => _navigationService.back();

  Future<void> init(File image) async {
    setBusy(true);
    _edgeDetectionResult = await _edgeDetectionService.getEdges(image);
    setBusy(false);
  }
}

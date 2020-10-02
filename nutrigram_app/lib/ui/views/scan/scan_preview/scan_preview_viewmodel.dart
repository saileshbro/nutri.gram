import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nutrigram_app/app/logger.dart';
import 'package:nutrigram_app/app/router.gr.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/scan/scan_response_model.dart';
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:nutrigram_app/services/edge_detection_service.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class ScanPreviewViewModel extends BaseViewModel {
  final NavigationService _navigationService;
  final IScanRepository _scanRepository;
  final DialogService _dialogService;
  final _logger = getLogger("ScanPreviewViewModel");
  final EdgeDetectionService _edgeDetectionService;
  final SharedPreferencesService _sharedPreferencesService;
  bool _showEdges = true;
  bool get showEdges => _showEdges;
  EdgeDetectionResult _edgeDetectionResult;
  File _image;
  EdgeDetectionResult get edgeDetectionResult => _edgeDetectionResult;
  ScanPreviewViewModel(
      this._navigationService,
      this._edgeDetectionService,
      this._scanRepository,
      this._dialogService,
      this._sharedPreferencesService);

  Future<void> getScanResults() async {
    _showEdges = false;
    setBusy(true);
    // await cropImage();
    // imageCache.clearLiveImages();
    // imageCache.clear();
    final Either<Failure, ScanResponseModel> resp =
        await _scanRepository.getScanData(_image);
    resp.fold((l) {
      _logger.e(l.message);
      _showError(l.message);
    }, (r) async {
      if (r.data.isEmpty) {
        _showError("Cannot get scan result");
      } else {
        await _sharedPreferencesService.incremenntTotalScanned();
        _navigationService.replaceWith(
          Routes.nutrientInfoDisplayView,
          arguments: NutrientInfoDisplayViewArguments(
            nutrients: r.data,
            showSaveButton: true,
            date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
            searchTerm: "",
          ),
        );
      }
    });
    setBusy(false);
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
    final int length = await _image.length();
    _logger.d("Image size after crop: $length");
    return val;
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Scan Results",
      description: message,
    );
    setBusy(false);
  }
}

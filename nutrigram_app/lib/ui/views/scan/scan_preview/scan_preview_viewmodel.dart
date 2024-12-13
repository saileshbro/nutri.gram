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

  late EdgeDetectionResult
      _edgeDetectionResult; // Use late initialization for non-nullable variables
  File _image;

  EdgeDetectionResult get edgeDetectionResult => _edgeDetectionResult;

  ScanPreviewViewModel(
    this._navigationService,
    this._edgeDetectionService,
    this._scanRepository,
    this._dialogService,
    this._sharedPreferencesService,
  );

  Future<void> getScanResults() async {
    _showEdges = false;
    setBusy(true);

    try {
      // Perform the scan request
      final Either<Failure, ScanResponseModel> resp =
          await _scanRepository.getScanData(_image);

      resp.fold(
        (Failure failure) {
          _logger.e(failure.message); // Log failure message
          _showError(failure.message); // Show error dialog
        },
        (ScanResponseModel result) async {
          if (result.data.isEmpty) {
            _showError("Cannot get scan result");
          } else {
            await _sharedPreferencesService.incremenntTotalScanned();
            _navigationService.replaceWith(
              Routes.nutrientInfoDisplayView,
              arguments: NutrientInfoDisplayViewArguments(
                nutrients: result.data,
                showSaveButton: true,
                date: DateFormat("EEE, d MMM yyyy").format(DateTime.now()),
                searchTerm: "",
              ),
            );
          }
        },
      );
    } catch (e) {
      _logger.e("Unexpected error: $e"); // Log unexpected errors
      _showError("An unexpected error occurred. Please try again.");
    } finally {
      setBusy(false); // Always reset the busy state
    }
  }

  bool retakePicture() => _navigationService.back();

  Future<void> init(File image) async {
    setBusy(true);
    _image = image;

    // Log the image size before processing
    final int imageSize = await _image.length();
    _logger.d("Image size before crop: $imageSize");

    try {
      // Perform edge detection
      _edgeDetectionResult = await _edgeDetectionService.getEdges(image);
    } catch (e) {
      _logger.e("Edge detection failed: $e");
      _showError("Failed to process the image.");
    } finally {
      setBusy(false); // Ensure the busy state is reset
    }
  }

  Future<bool> cropImage() async {
    if (_edgeDetectionResult == null) {
      _showError("No edges detected to crop.");
      return false;
    }

    try {
      final bool result = await _edgeDetectionService.processImage(
        _image,
        _edgeDetectionResult,
      );
      final int length = await _image.length();
      _logger.d("Image size after crop: $length");
      return result;
    } catch (e) {
      _logger.e("Image cropping failed: $e");
      return false;
    }
  }

  void _showError(String message) {
    _dialogService.showDialog(
      title: "Scan Results",
      description: message,
    );
    setBusy(false);
  }
}

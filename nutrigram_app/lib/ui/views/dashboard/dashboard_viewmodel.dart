import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/services/camera_service.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class DashboardViewModel extends IndexTrackingViewModel {
  final CameraService _cameraService;

  DashboardViewModel(this._cameraService);
  @override
  void setIndex(int value) {
    if (value != 2 && _cameraService.controller != null) {
      _cameraService.dispose();
    }
    super.setIndex(value);
  }
}

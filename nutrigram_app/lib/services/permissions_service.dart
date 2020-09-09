import 'package:injectable/injectable.dart';

@lazySingleton
class PermissionsService {
  Future<bool> get hasCameraPermission async => null;
  Future<void> requestCameraPermission() async {}
}

import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

@lazySingleton
class TotalScanDataService {
  List<Nutrient> _totalScanData;
  List<Nutrient> get totalScanData => _totalScanData ?? [];

  set totalScanData(List<Nutrient> value) => _totalScanData = value;
}

import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@injectable
class ViewMoreGraphViewModel extends IndexTrackingViewModel {
  int graphTabIndex = 0;

  // ignore: use_setters_to_change_properties
  void onGraphIndexChanged(int i) {
    graphTabIndex = i;
    notifyListeners();
  }
}

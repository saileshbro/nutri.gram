import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class HomeViewModel extends BaseViewModel {
  final List<HealthTip> _healthTipList = <HealthTip>[];
  final IHomeRepository _homeRepository;

  HomeViewModel(this._homeRepository);
  List<HealthTip> get healthTipList => _healthTipList;
  Future<void> init() async {
    setBusy(true);
    final Either<Failure, HealthTipsResponseModel> response =
        await _homeRepository.getHealthTips();
    response.fold((Failure f) => setError(f.message),
        (HealthTipsResponseModel r) => _healthTipList.addAll(r.tips));
    setBusy(false);
  }
}

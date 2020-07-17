// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:nutrigram_app/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nutrigram_app/services/permissions_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<PermissionsService>(() => PermissionsService());
  final sharedPreferences = await thirdPartyServicesModule.prefs;
  g.registerFactory<SharedPreferences>(() => sharedPreferences);
  g.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}

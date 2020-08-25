// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:nutrigram_app/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nutrigram_app/services/permissions_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:nutrigram_app/services/http_service.dart';
import 'package:nutrigram_app/services/authentication/r_authentication_service.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:nutrigram_app/ui/views/startup/startup_viewmodel.dart';
import 'package:nutrigram_app/repository/authentication/r_authentication_repository.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_viewmodel.dart';
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
      () => SharedPreferencesService(g<SharedPreferences>()));
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  g.registerLazySingleton<UserDataService>(
      () => UserDataService(g<SharedPreferencesService>()));
  g.registerLazySingleton<HttpService>(() => HttpService(g<UserDataService>()));
  g.registerLazySingleton<IAuthenticationService>(
      () => RAuthenticationService(g<HttpService>()));
  g.registerLazySingleton<OnboardingViewModel>(() => OnboardingViewModel(
      g<NavigationService>(), g<SharedPreferencesService>()));
  g.registerLazySingleton<StartUpViewModel>(() => StartUpViewModel(
        g<NavigationService>(),
        g<SharedPreferencesService>(),
        g<UserDataService>(),
      ));
  g.registerLazySingleton<IAuthenticationRepository>(
      () => RAuthenticationRepository(g<IAuthenticationService>()));
  g.registerLazySingleton<LoginViewModel>(() => LoginViewModel(
        g<IAuthenticationRepository>(),
        g<UserDataService>(),
        g<NavigationService>(),
        g<DialogService>(),
      ));
  g.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel(
        g<IAuthenticationRepository>(),
        g<NavigationService>(),
        g<DialogService>(),
      ));
  g.registerLazySingleton<VerificationViewModel>(() => VerificationViewModel(
        g<IAuthenticationRepository>(),
        g<DialogService>(),
        g<UserDataService>(),
        g<NavigationService>(),
      ));
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
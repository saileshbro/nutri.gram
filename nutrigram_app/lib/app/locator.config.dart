// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:nutrigram_app/services/camera_service.dart';
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_viewmodel.dart';
import 'package:nutrigram_app/ui/views/dashboard/dashboard_viewmodel.dart';
import 'package:nutrigram_app/services/edge_detection_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/ui/views/history/history_viewmodel.dart';
import 'package:nutrigram_app/ui/views/home/home_viewmodel.dart';
import 'package:nutrigram_app/services/http_service.dart';
import 'package:nutrigram_app/services/api/i_api_service.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';
import 'package:nutrigram_app/repository/home/i_home_repository.dart';
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart';
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart';
import 'package:nutrigram_app/repository/search/i_search_repository.dart';
import 'package:nutrigram_app/ui/views/auth/login/login_viewmodel.dart';
import 'package:nutrigram_app/services/media_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_viewmodel.dart';
import 'package:nutrigram_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/login/otp_request/otp_request_viewmodel.dart';
import 'package:nutrigram_app/ui/views/profile/profile_viewmodel.dart';
import 'package:nutrigram_app/services/api/r_api_service.dart';
import 'package:nutrigram_app/repository/authentication/r_authentication_repository.dart';
import 'package:nutrigram_app/services/authentication/r_authentication_service.dart';
import 'package:nutrigram_app/repository/home/r_home_repository.dart';
import 'package:nutrigram_app/repository/profile/r_profile_repository.dart';
import 'package:nutrigram_app/repository/scan/r_scan_repository.dart';
import 'package:nutrigram_app/repository/search/r_search_repository.dart';
import 'package:nutrigram_app/ui/views/auth/register/register_viewmodel.dart';
import 'package:nutrigram_app/ui/views/auth/login/reset_password/reset_password_viewmodel.dart';
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_viewmodel.dart';
import 'package:nutrigram_app/ui/views/scan/scan_viewmodel.dart';
import 'package:nutrigram_app/ui/views/search/search_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutrigram_app/services/shared_preferences_service.dart';
import 'package:nutrigram_app/ui/views/startup/startup_viewmodel.dart';
import 'package:nutrigram_app/services/third_party_services_module.dart';
import 'package:nutrigram_app/services/total_scan_data_service.dart';
import 'package:nutrigram_app/ui/views/profile/update_profile_form/update_profile_form_viewmodel.dart';
import 'package:nutrigram_app/services/profile/update_profile_service.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:nutrigram_app/ui/views/auth/verification/verification_viewmodel.dart';
import 'package:nutrigram_app/ui/views/profile/verify_phone_change/verify_phone_change_viewmodel.dart';
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_viewmodel.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<CameraService>(() => CameraService());
  gh.lazySingleton<DashboardViewModel>(
      () => DashboardViewModel(get<CameraService>()));
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<EdgeDetectionService>(() => EdgeDetectionService());
  gh.lazySingleton<MediaService>(() => MediaService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.factory<ScanViewModel>(() => ScanViewModel(
        get<CameraService>(),
        get<NavigationService>(),
        get<MediaService>(),
      ));
  final sharedPreferences = await thirdPartyServicesModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.lazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService(get<SharedPreferences>()));
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<TotalScanDataService>(() => TotalScanDataService());
  gh.lazySingleton<UpdateProfileService>(() => UpdateProfileService());
  gh.lazySingleton<UserDataService>(
      () => UserDataService(get<SharedPreferencesService>()));
  gh.factory<ViewMoreGraphViewModel>(() => ViewMoreGraphViewModel());
  gh.lazySingleton<HttpService>(() => HttpService(get<UserDataService>()));
  gh.lazySingleton<IApiService>(() => RApiService(get<HttpService>()));
  gh.lazySingleton<IAuthenticationService>(
      () => RAuthenticationService(get<HttpService>()));
  gh.lazySingleton<IHomeRepository>(() => RHomeRepository(get<IApiService>()));
  gh.lazySingleton<IProfileRepository>(
      () => RProfileRepository(get<IApiService>()));
  gh.lazySingleton<IScanRepository>(() => RScanRepository(get<IApiService>()));
  gh.lazySingleton<ISearchRepository>(
      () => RSearchRepository(get<IApiService>()));
  gh.factory<NutrientInfoDisplayViewModel>(() => NutrientInfoDisplayViewModel(
        get<UserDataService>(),
        get<IScanRepository>(),
        get<DialogService>(),
        get<NavigationService>(),
        get<IHomeRepository>(),
        get<TotalScanDataService>(),
      ));
  gh.lazySingleton<OnboardingViewModel>(() => OnboardingViewModel(
      get<NavigationService>(), get<SharedPreferencesService>()));
  gh.lazySingleton<ProfileViewModel>(() => ProfileViewModel(
        get<UserDataService>(),
        get<NavigationService>(),
        get<IProfileRepository>(),
        get<SharedPreferencesService>(),
        get<TotalScanDataService>(),
        get<IHomeRepository>(),
      ));
  gh.factory<ScanPreviewViewModel>(() => ScanPreviewViewModel(
        get<NavigationService>(),
        get<EdgeDetectionService>(),
        get<IScanRepository>(),
        get<DialogService>(),
        get<SharedPreferencesService>(),
      ));
  gh.lazySingleton<SearchViewModel>(() => SearchViewModel(
        get<ISearchRepository>(),
        get<DialogService>(),
        get<NavigationService>(),
        get<SharedPreferencesService>(),
      ));
  gh.lazySingleton<StartUpViewModel>(() => StartUpViewModel(
        get<NavigationService>(),
        get<SharedPreferencesService>(),
        get<UserDataService>(),
        get<IProfileRepository>(),
      ));
  gh.factory<UpdateProfileFormViewModel>(() => UpdateProfileFormViewModel(
        get<UserDataService>(),
        get<IProfileRepository>(),
        get<DialogService>(),
        get<UpdateProfileService>(),
      ));
  gh.factory<VerifyPhoneViewModel>(() => VerifyPhoneViewModel(
        get<IProfileRepository>(),
        get<DialogService>(),
        get<NavigationService>(),
        get<UpdateProfileService>(),
        get<UserDataService>(),
      ));
  gh.factory<ChangeImageViewModel>(() => ChangeImageViewModel(
        get<IProfileRepository>(),
        get<UserDataService>(),
        get<MediaService>(),
        get<NavigationService>(),
      ));
  gh.lazySingleton<HistoryViewModel>(() => HistoryViewModel(
        get<IScanRepository>(),
        get<DialogService>(),
        get<UserDataService>(),
        get<NavigationService>(),
        get<IHomeRepository>(),
        get<TotalScanDataService>(),
      ));
  gh.lazySingleton<HomeViewModel>(() => HomeViewModel(
        get<IHomeRepository>(),
        get<UserDataService>(),
        get<NavigationService>(),
        get<TotalScanDataService>(),
      ));
  gh.lazySingleton<IAuthenticationRepository>(
      () => RAuthenticationRepository(get<IAuthenticationService>()));
  gh.lazySingleton<LoginViewModel>(() => LoginViewModel(
        get<IAuthenticationRepository>(),
        get<UserDataService>(),
        get<NavigationService>(),
        get<DialogService>(),
      ));
  gh.factory<OtpRequestViewModel>(() => OtpRequestViewModel(
      get<DialogService>(), get<IAuthenticationRepository>()));
  gh.lazySingleton<RegisterViewModel>(() => RegisterViewModel(
        get<IAuthenticationRepository>(),
        get<NavigationService>(),
        get<DialogService>(),
      ));
  gh.factory<ResetPasswordViewModel>(() => ResetPasswordViewModel(
        get<IAuthenticationRepository>(),
        get<DialogService>(),
        get<NavigationService>(),
        get<UserDataService>(),
      ));
  gh.lazySingleton<VerificationViewModel>(() => VerificationViewModel(
        get<IAuthenticationRepository>(),
        get<DialogService>(),
        get<UserDataService>(),
        get<NavigationService>(),
      ));
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}

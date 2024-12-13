// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart'
    as _i200;
import 'package:nutrigram_app/repository/authentication/r_authentication_repository.dart'
    as _i796;
import 'package:nutrigram_app/repository/home/i_home_repository.dart' as _i52;
import 'package:nutrigram_app/repository/home/r_home_repository.dart' as _i187;
import 'package:nutrigram_app/repository/profile/i_profile_repository.dart'
    as _i406;
import 'package:nutrigram_app/repository/profile/r_profile_repository.dart'
    as _i535;
import 'package:nutrigram_app/repository/scan/i_scan_repository.dart' as _i250;
import 'package:nutrigram_app/repository/scan/r_scan_repository.dart' as _i1070;
import 'package:nutrigram_app/repository/search/i_search_repository.dart'
    as _i89;
import 'package:nutrigram_app/repository/search/r_search_repository.dart'
    as _i691;
import 'package:nutrigram_app/services/api/i_api_service.dart' as _i125;
import 'package:nutrigram_app/services/api/r_api_service.dart' as _i821;
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart'
    as _i840;
import 'package:nutrigram_app/services/authentication/r_authentication_service.dart'
    as _i317;
import 'package:nutrigram_app/services/camera_service.dart' as _i727;
import 'package:nutrigram_app/services/edge_detection_service.dart' as _i617;
import 'package:nutrigram_app/services/http_service.dart' as _i433;
import 'package:nutrigram_app/services/media_service.dart' as _i170;
import 'package:nutrigram_app/services/profile/update_profile_service.dart'
    as _i29;
import 'package:nutrigram_app/services/shared_preferences_service.dart' as _i3;
import 'package:nutrigram_app/services/third_party_services_module.dart'
    as _i269;
import 'package:nutrigram_app/services/total_scan_data_service.dart' as _i403;
import 'package:nutrigram_app/services/user_data_service.dart' as _i198;
import 'package:nutrigram_app/ui/views/auth/login/login_viewmodel.dart'
    as _i748;
import 'package:nutrigram_app/ui/views/auth/login/otp_request/otp_request_viewmodel.dart'
    as _i148;
import 'package:nutrigram_app/ui/views/auth/login/reset_password/reset_password_viewmodel.dart'
    as _i970;
import 'package:nutrigram_app/ui/views/auth/register/register_viewmodel.dart'
    as _i510;
import 'package:nutrigram_app/ui/views/auth/verification/verification_viewmodel.dart'
    as _i941;
import 'package:nutrigram_app/ui/views/dashboard/dashboard_viewmodel.dart'
    as _i605;
import 'package:nutrigram_app/ui/views/history/history_viewmodel.dart' as _i61;
import 'package:nutrigram_app/ui/views/home/home_viewmodel.dart' as _i878;
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_viewmodel.dart'
    as _i961;
import 'package:nutrigram_app/ui/views/onboarding/onboarding_viewmodel.dart'
    as _i940;
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_viewmodel.dart'
    as _i4;
import 'package:nutrigram_app/ui/views/profile/profile_viewmodel.dart' as _i211;
import 'package:nutrigram_app/ui/views/profile/update_profile_form/update_profile_form_viewmodel.dart'
    as _i377;
import 'package:nutrigram_app/ui/views/profile/verify_phone_change/verify_phone_change_viewmodel.dart'
    as _i571;
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_viewmodel.dart'
    as _i328;
import 'package:nutrigram_app/ui/views/scan/scan_viewmodel.dart' as _i326;
import 'package:nutrigram_app/ui/views/search/search_viewmodel.dart' as _i764;
import 'package:nutrigram_app/ui/views/startup/startup_viewmodel.dart'
    as _i1011;
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_viewmodel.dart'
    as _i785;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:stacked_services/stacked_services.dart' as _i1055;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyServicesModule = _$ThirdPartyServicesModule();
    gh.factory<_i785.ViewMoreGraphViewModel>(
        () => _i785.ViewMoreGraphViewModel());
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyServicesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i403.TotalScanDataService>(
        () => _i403.TotalScanDataService());
    gh.lazySingleton<_i727.CameraService>(() => _i727.CameraService());
    gh.lazySingleton<_i170.MediaService>(() => _i170.MediaService());
    gh.lazySingleton<_i617.EdgeDetectionService>(
        () => _i617.EdgeDetectionService());
    gh.lazySingleton<_i1055.NavigationService>(
        () => thirdPartyServicesModule.navigationService);
    gh.lazySingleton<_i1055.DialogService>(
        () => thirdPartyServicesModule.dialogService);
    gh.lazySingleton<_i1055.SnackbarService>(
        () => thirdPartyServicesModule.snackbarService);
    gh.lazySingleton<_i29.UpdateProfileService>(
        () => _i29.UpdateProfileService());
    gh.factory<_i326.ScanViewModel>(() => _i326.ScanViewModel(
          gh<_i727.CameraService>(),
          gh<_i1055.NavigationService>(),
          gh<_i170.MediaService>(),
        ));
    gh.lazySingleton<_i605.DashboardViewModel>(
        () => _i605.DashboardViewModel(gh<_i727.CameraService>()));
    gh.lazySingleton<_i3.SharedPreferencesService>(
        () => _i3.SharedPreferencesService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i198.UserDataService>(
        () => _i198.UserDataService(gh<_i3.SharedPreferencesService>()));
    gh.lazySingleton<_i940.OnboardingViewModel>(() => _i940.OnboardingViewModel(
          gh<_i1055.NavigationService>(),
          gh<_i3.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i433.HttpService>(
        () => _i433.HttpService(gh<_i198.UserDataService>()));
    gh.lazySingleton<_i125.IApiService>(
        () => _i821.RApiService(gh<_i433.HttpService>()));
    gh.lazySingleton<_i840.IAuthenticationService>(
        () => _i317.RAuthenticationService(gh<_i433.HttpService>()));
    gh.lazySingleton<_i52.IHomeRepository>(
        () => _i187.RHomeRepository(gh<_i125.IApiService>()));
    gh.lazySingleton<_i250.IScanRepository>(
        () => _i1070.RScanRepository(gh<_i125.IApiService>()));
    gh.lazySingleton<_i89.ISearchRepository>(
        () => _i691.RSearchRepository(gh<_i125.IApiService>()));
    gh.lazySingleton<_i878.HomeViewModel>(() => _i878.HomeViewModel(
          gh<_i52.IHomeRepository>(),
          gh<_i198.UserDataService>(),
          gh<_i1055.NavigationService>(),
          gh<_i403.TotalScanDataService>(),
        ));
    gh.lazySingleton<_i406.IProfileRepository>(
        () => _i535.RProfileRepository(gh<_i125.IApiService>()));
    gh.lazySingleton<_i764.SearchViewModel>(() => _i764.SearchViewModel(
          gh<_i89.ISearchRepository>(),
          gh<_i1055.DialogService>(),
          gh<_i1055.NavigationService>(),
          gh<_i3.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i200.IAuthenticationRepository>(() =>
        _i796.RAuthenticationRepository(gh<_i840.IAuthenticationService>()));
    gh.factory<_i961.NutrientInfoDisplayViewModel>(
        () => _i961.NutrientInfoDisplayViewModel(
              gh<_i198.UserDataService>(),
              gh<_i250.IScanRepository>(),
              gh<_i1055.DialogService>(),
              gh<_i1055.NavigationService>(),
              gh<_i52.IHomeRepository>(),
              gh<_i403.TotalScanDataService>(),
            ));
    gh.factory<_i970.ResetPasswordViewModel>(() => _i970.ResetPasswordViewModel(
          gh<_i200.IAuthenticationRepository>(),
          gh<_i1055.DialogService>(),
          gh<_i1055.NavigationService>(),
          gh<_i198.UserDataService>(),
        ));
    gh.lazySingleton<_i61.HistoryViewModel>(() => _i61.HistoryViewModel(
          gh<_i250.IScanRepository>(),
          gh<_i1055.DialogService>(),
          gh<_i198.UserDataService>(),
          gh<_i1055.NavigationService>(),
          gh<_i52.IHomeRepository>(),
          gh<_i403.TotalScanDataService>(),
        ));
    gh.factory<_i148.OtpRequestViewModel>(() => _i148.OtpRequestViewModel(
          gh<_i1055.DialogService>(),
          gh<_i200.IAuthenticationRepository>(),
        ));
    gh.lazySingleton<_i1011.StartUpViewModel>(() => _i1011.StartUpViewModel(
          gh<_i1055.NavigationService>(),
          gh<_i3.SharedPreferencesService>(),
          gh<_i198.UserDataService>(),
          gh<_i406.IProfileRepository>(),
        ));
    gh.factory<_i328.ScanPreviewViewModel>(() => _i328.ScanPreviewViewModel(
          gh<_i1055.NavigationService>(),
          gh<_i617.EdgeDetectionService>(),
          gh<_i250.IScanRepository>(),
          gh<_i1055.DialogService>(),
          gh<_i3.SharedPreferencesService>(),
        ));
    gh.lazySingleton<_i941.VerificationViewModel>(
        () => _i941.VerificationViewModel(
              gh<_i200.IAuthenticationRepository>(),
              gh<_i1055.DialogService>(),
              gh<_i198.UserDataService>(),
              gh<_i1055.NavigationService>(),
            ));
    gh.lazySingleton<_i211.ProfileViewModel>(() => _i211.ProfileViewModel(
          gh<_i198.UserDataService>(),
          gh<_i1055.NavigationService>(),
          gh<_i406.IProfileRepository>(),
          gh<_i3.SharedPreferencesService>(),
          gh<_i403.TotalScanDataService>(),
          gh<_i52.IHomeRepository>(),
        ));
    gh.lazySingleton<_i748.LoginViewModel>(() => _i748.LoginViewModel(
          gh<_i200.IAuthenticationRepository>(),
          gh<_i198.UserDataService>(),
          gh<_i1055.NavigationService>(),
          gh<_i1055.DialogService>(),
        ));
    gh.factory<_i571.VerifyPhoneViewModel>(() => _i571.VerifyPhoneViewModel(
          gh<_i406.IProfileRepository>(),
          gh<_i1055.DialogService>(),
          gh<_i1055.NavigationService>(),
          gh<_i29.UpdateProfileService>(),
          gh<_i198.UserDataService>(),
          gh<String>(),
        ));
    gh.factory<_i4.ChangeImageViewModel>(() => _i4.ChangeImageViewModel(
          gh<_i406.IProfileRepository>(),
          gh<_i198.UserDataService>(),
          gh<_i170.MediaService>(),
          gh<_i1055.NavigationService>(),
        ));
    gh.factory<_i377.UpdateProfileFormViewModel>(
        () => _i377.UpdateProfileFormViewModel(
              gh<_i198.UserDataService>(),
              gh<_i406.IProfileRepository>(),
              gh<_i1055.DialogService>(),
              gh<_i29.UpdateProfileService>(),
            ));
    gh.lazySingleton<_i510.RegisterViewModel>(() => _i510.RegisterViewModel(
          gh<_i200.IAuthenticationRepository>(),
          gh<_i1055.NavigationService>(),
          gh<_i1055.DialogService>(),
        ));
    return this;
  }
}

class _$ThirdPartyServicesModule extends _i269.ThirdPartyServicesModule {
  @override
  _i1055.NavigationService get navigationService => _i1055.NavigationService();

  @override
  _i1055.DialogService get dialogService => _i1055.DialogService();

  @override
  _i1055.SnackbarService get snackbarService => _i1055.SnackbarService();
}

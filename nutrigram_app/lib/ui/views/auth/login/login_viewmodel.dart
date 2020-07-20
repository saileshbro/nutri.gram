import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/user_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final IAuthenticationRepository _authenticationRepository;
  final UserDataService _userDataService;
  final NavigationService _navigationService;
  LoginViewModel(this._authenticationRepository, this._userDataService,
      this._navigationService);
}

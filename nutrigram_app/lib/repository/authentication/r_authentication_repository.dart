import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/repository/authentication/i_authentication_repository.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';

// @LazySingleton(as: IAuthenticationRepository)
@LazySingleton(as: IAuthenticationRepository)
class RAuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationService _authenticationService;
  RAuthenticationRepository(this._authenticationService);
}

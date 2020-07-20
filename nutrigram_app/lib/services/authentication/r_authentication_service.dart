import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';
import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IAuthenticationService)
class RAuthenticationService implements IAuthenticationService {
  final HttpService _httpService;

  RAuthenticationService(this._httpService);
}

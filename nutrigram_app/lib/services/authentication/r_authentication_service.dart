import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/failure.dart';
import 'package:nutrigram_app/services/authentication/i_authentication_service.dart';
import 'package:nutrigram_app/services/http_service.dart';

@LazySingleton(as: IAuthenticationService)
class RAuthenticationService implements IAuthenticationService {
  final HttpService _httpService;

  RAuthenticationService(this._httpService);

  @override
  Future<LoginResponseModel> login({@required LoginRequestModel model}) async {
    try {
      return _httpService
          .post(url: '/users/login', encodedJson: model.toJson())
          .handleError((err) {
        throw Failure(message: err.message ?? "Unusual Exception");
      }).map((_) {
        return LoginResponseModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}

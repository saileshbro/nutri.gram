import 'package:flutter/foundation.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_request_model.dart';
import 'package:nutrigram_app/datamodels/authentication/login/login_response_model.dart';

abstract class IAuthenticationService {
  Future<LoginResponseModel> login({@required LoginRequestModel model});
}

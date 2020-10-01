import 'package:nutrigram_app/datamodels/user.dart';

class VerificationResponseModel {
  User user;
  String token;
  String message;

  VerificationResponseModel({this.user, this.token, this.message});

  VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'] as String;
    message = json['message'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}

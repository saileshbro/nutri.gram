import 'package:nutrigram_app/datamodels/user.dart';

class PassswordResetResponseModel {
  String message;
  User user;
  String token;

  PassswordResetResponseModel({this.message, this.user, this.token});

  PassswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['token'] = token;
    return data;
  }
}

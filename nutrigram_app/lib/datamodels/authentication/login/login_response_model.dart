import 'package:nutrigram_app/datamodels/user.dart';

class LoginResponseModel {
  final User? user;
  final String? token;
  final String? message;

  LoginResponseModel({
    this.user,
    this.token,
    this.message,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : user = json['user'] != null ? User.fromJson(json['user']) : null,
        token = json['token'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}

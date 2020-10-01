import 'package:nutrigram_app/datamodels/user.dart';

class RegisterResponseModel {
  User user;

  String message;

  RegisterResponseModel({this.user, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['message'] = message;
    return data;
  }
}

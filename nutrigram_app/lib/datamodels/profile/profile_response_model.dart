import 'package:nutrigram_app/datamodels/user.dart';

class ProfileResponseModel {
  User user;
  String otp;
  String message;

  ProfileResponseModel({this.user, this.otp, this.message});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['otp'] != null) {
      otp = json['otp'] as String;
    }
    message = json['message'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['otp'] = otp;
    data['message'] = message;
    return data;
  }
}

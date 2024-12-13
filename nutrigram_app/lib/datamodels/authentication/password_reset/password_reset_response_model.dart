import 'package:nutrigram_app/datamodels/user.dart';

class PasswordResetResponseModel {
  final String? message;
  final User? user;
  final String? token;

  PasswordResetResponseModel({
    this.message,
    this.user,
    this.token,
  });

  // Factory constructor to create an instance from a JSON map
  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponseModel(
      message: json['message'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'] as String?,
    );
  }

  // Method to convert the object into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['token'] = token;
    return data;
  }
}

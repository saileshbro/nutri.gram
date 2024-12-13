import 'package:nutrigram_app/datamodels/user.dart';

class VerificationResponseModel {
  User? user;
  String? token;
  String? message;

  VerificationResponseModel({this.user, this.token, this.message});

  // Factory constructor to create an instance from JSON
  VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'] as String?;
    message = json['message'] as String?;
  }

  // Convert the instance to JSON format
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson(); // Ensure 'user' is non-null
    }
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}

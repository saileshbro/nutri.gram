import 'package:nutrigram_app/datamodels/user.dart';

class RegisterResponseModel {
  User? user; // Nullable field for user
  String message;

  // Constructor with named parameters and null safety
  RegisterResponseModel({this.user, required this.message});

  // Factory constructor to create the object from JSON
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      message: json['message'] as String,
    );
  }

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['message'] = message;
    return data;
  }
}

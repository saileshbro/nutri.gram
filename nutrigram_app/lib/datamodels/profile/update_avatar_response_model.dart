import 'package:nutrigram_app/datamodels/user.dart';

class UpdateAvatarResponseModel {
  User user;
  String message;

  UpdateAvatarResponseModel({this.user, this.message});

  UpdateAvatarResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class RegisterResponseModel {
  _User user;

  String message;

  RegisterResponseModel({this.user, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? _User.fromJson(json['user']) : null;
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

class _User {
  String passwordResetOtp;
  String otp;
  bool otpVerified;
  String sId;
  String name;
  String phone;
  String createdAt;
  String updatedAt;

  _User({
    this.passwordResetOtp,
    this.otp,
    this.otpVerified,
    this.sId,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  _User.fromJson(Map<String, dynamic> json) {
    passwordResetOtp = json['passwordResetOtp'] as String;
    otp = json['otp'] as String;
    otpVerified = json['otpVerified'] as bool;
    sId = json['_id'] as String;
    name = json['name'] as String;
    phone = json['phone'] as String;
    createdAt = json['createdAt'] as String;
    updatedAt = json['updatedAt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['passwordResetOtp'] = passwordResetOtp;
    data['otp'] = otp;
    data['otpVerified'] = otpVerified;
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

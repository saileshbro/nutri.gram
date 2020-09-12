class User {
  String passwordResetOtp;
  String phoneChangeOtp;
  String otp;
  bool otpVerified;
  int totalSaved;
  int totalCalories;
  String sId;
  String name;
  String phone;
  String createdAt;
  String updatedAt;

  User(
      {this.passwordResetOtp,
      this.phoneChangeOtp,
      this.otp,
      this.otpVerified,
      this.totalSaved,
      this.totalCalories,
      this.sId,
      this.name,
      this.phone,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    passwordResetOtp = json['passwordResetOtp'] as String;
    phoneChangeOtp = json['phoneChangeOtp'] as String;
    otp = json['otp'] as String;
    otpVerified = json['otpVerified'] as bool;
    totalSaved = json['totalSaved'] as int;
    totalCalories = json['totalCalories'] as int;
    sId = json['_id'] as String;
    name = json['name'] as String;
    phone = json['phone'] as String;
    createdAt = json['createdAt'] as String;
    updatedAt = json['updatedAt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passwordResetOtp'] = passwordResetOtp;
    data['phoneChangeOtp'] = phoneChangeOtp;
    data['otp'] = otp;
    data['otpVerified'] = otpVerified;
    data['totalSaved'] = totalSaved;
    data['totalCalories'] = totalCalories;
    data['_id'] = sId;
    data['name'] = name;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

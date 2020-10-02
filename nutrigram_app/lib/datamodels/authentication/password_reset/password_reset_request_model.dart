import 'dart:convert';

class PassswordResetRequestModel {
  String phone;
  String newPassword;
  String otp;
  PassswordResetRequestModel({
    this.phone,
    this.newPassword,
    this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'newPassword': newPassword,
      'otp': otp,
    };
  }

  String toJson() => json.encode(toMap());
}

import 'dart:convert';

class PasswordResetRequestModel {
  final String? phone;
  final String? newPassword;
  final String? otp;

  PasswordResetRequestModel({
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

  // From JSON constructor
  factory PasswordResetRequestModel.fromJson(String source) {
    final Map<String, dynamic> jsonMap =
        json.decode(source) as Map<String, dynamic>;
    return PasswordResetRequestModel(
      phone: jsonMap['phone'] as String?,
      newPassword: jsonMap['newPassword'] as String?,
      otp: jsonMap['otp'] as String?,
    );
  }
}

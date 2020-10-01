import 'dart:convert';

class VerificationRequestModel {
  final String phone;
  final String otp;
  VerificationRequestModel({
    this.phone,
    this.otp,
  });

  VerificationRequestModel copyWith({
    String phone,
    String otp,
  }) {
    return VerificationRequestModel(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }

  factory VerificationRequestModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VerificationRequestModel(
      phone: map['phone'],
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationRequestModel.fromJson(String source) =>
      VerificationRequestModel.fromMap(json.decode(source));

  @override
  String toString() => 'VerificationRequestModel(phone: $phone, otp: $otp)';
}

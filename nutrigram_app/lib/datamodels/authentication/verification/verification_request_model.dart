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

  static VerificationRequestModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return VerificationRequestModel(
      phone: map['phone'],
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  static VerificationRequestModel fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'VerificationRequestModel(phone: $phone, otp: $otp)';
}

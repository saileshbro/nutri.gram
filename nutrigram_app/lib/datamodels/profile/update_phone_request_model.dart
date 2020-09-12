import 'dart:convert';

class UpdatePhoneRequestModel {
  final String otp;
  final String phone;

  UpdatePhoneRequestModel({
    this.otp,
    this.phone,
  });
  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
      'phone': phone,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'UpdatePhoneRequestModel(otp: $otp, phone: $phone)';
}

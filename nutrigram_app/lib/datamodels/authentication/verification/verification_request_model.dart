import 'dart:convert';

class VerificationRequestModel {
  final String phone;
  final String otp;

  // Constructor with named parameters and null safety
  VerificationRequestModel({
    required this.phone,
    required this.otp,
  });

  // Method to copy the object with new values for fields
  VerificationRequestModel copyWith({
    String? phone,
    String? otp,
  }) {
    return VerificationRequestModel(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
    );
  }

  // Convert the object to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }

  // Factory constructor to create an instance from a Map
  factory VerificationRequestModel.fromMap(Map<String, dynamic> map) {
    return VerificationRequestModel(
      phone: map['phone'] ?? '', // Ensure phone is non-null
      otp: map['otp'] ?? '', // Ensure otp is non-null
    );
  }

  // Convert the object to JSON string
  String toJson() => json.encode(toMap());

  // Factory constructor to create an instance from a JSON string
  factory VerificationRequestModel.fromJson(String source) =>
      VerificationRequestModel.fromMap(json.decode(source));

  // Override toString for better debug output
  @override
  String toString() => 'VerificationRequestModel(phone: $phone, otp: $otp)';
}

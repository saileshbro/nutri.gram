import 'dart:convert';

class LoginRequestModel {
  final String phone;
  final String password;

  LoginRequestModel({
    required this.phone,
    required this.password,
  });

  LoginRequestModel copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequestModel(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      phone: map['phone'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) =>
      LoginRequestModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginRequestModel(phone: $phone, password: $password)';
}

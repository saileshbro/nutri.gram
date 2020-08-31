import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String phone;
  final String password;

  RegisterRequestModel(this.name, this.phone, this.password);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return RegisterRequestModel(
      map['name'],
      map['phone'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source));
}

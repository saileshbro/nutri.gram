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

  static RegisterRequestModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegisterRequestModel(
      map['name'],
      map['phone'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static RegisterRequestModel fromJson(String source) =>
      fromMap(json.decode(source));
}

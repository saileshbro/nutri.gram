import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String phone;
  final String password;

  // Constructor
  RegisterRequestModel({
    required this.name,
    required this.phone,
    required this.password,
  });

  // Convert object to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  // Factory constructor to create object from map
  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      throw ArgumentError("Map is empty or null");
    }
    return RegisterRequestModel(
      name: map['name'] ?? '', // Default to empty string if null
      phone: map['phone'] ?? '', // Default to empty string if null
      password: map['password'] ?? '', // Default to empty string if null
    );
  }

  // Convert object to JSON string
  String toJson() => json.encode(toMap());

  // Factory constructor to create object from JSON string
  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source));
}

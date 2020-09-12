import 'dart:convert';

class UpdateProfileRequestModel {
  final String name;
  final String phone;
  final String newPassword;
  final String currentPassword;
  UpdateProfileRequestModel({
    this.currentPassword,
    this.name,
    this.phone,
    this.newPassword,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'newPassword': newPassword,
      'currentPassword': currentPassword,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UpdateProfileRequestModel(name: $name, phone: $phone, newPassword: $newPassword,currentPassword: $currentPassword)';
}

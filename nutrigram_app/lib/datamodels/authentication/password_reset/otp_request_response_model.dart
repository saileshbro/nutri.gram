class OtpRequestResponseModel {
  String message;
  String otp;

  OtpRequestResponseModel({this.message, this.otp});

  OtpRequestResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String;
    otp = json['otp'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['otp'] = otp;
    return data;
  }
}

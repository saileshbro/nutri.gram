import 'package:nutrigram_app/datamodels/nutrient.dart';

class ScanRequestModel {
  String foodName;
  List<Nutrient> data;

  ScanRequestModel({this.foodName, this.data});

  ScanRequestModel.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'] as String;
    if (json['data'] != null) {
      data = <Nutrient>[];
      json['data'].forEach((v) {
        data.add(Nutrient.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodName'] = foodName;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

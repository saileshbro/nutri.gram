import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class ScanResponseModel {
  List<Nutrient> data;

  ScanResponseModel({this.data});

  ScanResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Nutrient>[];
      json['data'].asMap().forEach((index, value) {
        data.add(Nutrient.fromJson(value)..color = progressBarColors[index]);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

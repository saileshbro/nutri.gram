import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class TotalScanDataResponseModel {
  List<Nutrient> data;
  TotalScanDataResponseModel({this.data});
  TotalScanDataResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Nutrient>[];
      json['data'].asMap().forEach((index, value) {
        data.add(Nutrient.fromJson(value)..color = progressBarColors[index]);
      });
    }
  }
}

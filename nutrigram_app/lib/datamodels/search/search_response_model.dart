import 'package:nutrigram_app/datamodels/nutrient.dart';

class SearchResponseModel {
  String foodName;
  List<Nutrient> data;

  SearchResponseModel({this.foodName, this.data});

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
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

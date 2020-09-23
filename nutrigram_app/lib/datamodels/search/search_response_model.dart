import 'package:nutrigram_app/datamodels/nutrient.dart';

class SearchResponseModel {
  String foodName;
  String imageUrl;
  List<Nutrient> data;

  SearchResponseModel({this.foodName, this.data});

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName'] as String;
    imageUrl = json['imageUrl'] as String;
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
    data['imageUrl'] = imageUrl;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class History {
  String searchTerm;
  String sId;
  String userId;
  List<Nutrient> data;
  String foodName;
  String createdAt;

  History(
      {this.searchTerm,
      this.sId,
      this.userId,
      this.data,
      this.foodName,
      this.createdAt});

  History.fromJson(Map<String, dynamic> json) {
    searchTerm = json['searchTerm'] as String;
    sId = json['_id'] as String;
    userId = json['userId'] as String;
    if (json['data'] != null) {
      data = <Nutrient>[].cast<Nutrient>();
      json['data'].asMap().forEach((index, value) {
        data.add(Nutrient.fromJson(value)..color = progressBarColors[index]);
      });
    }
    foodName = json['foodName'] as String;
    createdAt = json['createdAt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchTerm'] = searchTerm;
    data['_id'] = sId;
    data['userId'] = userId;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['foodName'] = foodName;
    data['createdAt'] = createdAt;
    return data;
  }
}

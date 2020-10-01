import 'package:nutrigram_app/datamodels/nutrient.dart';

class ScanRequestModel {
  String foodName;
  String searchTerm;
  List<Nutrient> data;

  ScanRequestModel({this.foodName, this.data, this.searchTerm});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['foodName'] = foodName;
    data['searchTerm'] = searchTerm;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

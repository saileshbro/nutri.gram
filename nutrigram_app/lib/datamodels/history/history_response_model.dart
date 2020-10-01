import 'package:nutrigram_app/datamodels/history.dart';

class HistoryResponseModel {
  List<History> history;

  HistoryResponseModel({this.history});

  HistoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history.add(History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (history != null) {
      data['history'] = history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthTipsResponseModel {
  List<HealthTip> tips;

  HealthTipsResponseModel({this.tips});

  HealthTipsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['tips'] != null) {
      tips = <HealthTip>[];
      json['tips'].forEach((v) {
        tips.add(HealthTip.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tips != null) {
      data['tips'] = tips.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthTip {
  String sId;
  String title;
  String description;
  String imageUrl;
  String createdAt;
  String updatedAt;

  HealthTip(
      {this.sId,
      this.title,
      this.description,
      this.imageUrl,
      this.createdAt,
      this.updatedAt});

  HealthTip.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String;
    title = json['title'] as String;
    description = json['description'] as String;
    imageUrl = json['imageUrl'] as String;
    createdAt = json['createdAt'] as String;
    updatedAt = json['updatedAt'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

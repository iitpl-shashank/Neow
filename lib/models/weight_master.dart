class WeightMaster {
  WeightData? data;
  bool? success;
  String? message;

  WeightMaster({this.data, this.success, this.message});

  WeightMaster.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? WeightData.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class WeightData {
  int? id;
  int? userId;
  String? weight;
  String? weightType;
  String? createdAt;
  String? updatedAt;

  WeightData(
      {this.id,
      this.userId,
      this.weight,
      this.weightType,
      this.createdAt,
      this.updatedAt});

  WeightData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    weight = json['weight'];
    weightType = json['weight_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['weight'] = weight;
    data['weight_type'] = weightType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

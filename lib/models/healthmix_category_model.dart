import 'dart:convert';

HealthMixCategoryModel healthMixCategoryModelFromJson(String str) =>
    HealthMixCategoryModel.fromJson(json.decode(str));

String healthMixCategoryModelToJson(HealthMixCategoryModel data) =>
    json.encode(data.toJson());

class HealthMixCategoryModel {
  final Data? data;
  final bool? success;
  final String? message;

  HealthMixCategoryModel({
    this.data,
    this.success,
    this.message,
  });

  factory HealthMixCategoryModel.fromJson(Map<String, dynamic> json) =>
      HealthMixCategoryModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  final List<Record>? records;
  final int? totalCount;
  final int? startIndex;
  final int? fetchRecord;

  Data({
    this.records,
    this.totalCount,
    this.startIndex,
    this.fetchRecord,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        records: json["records"] == null
            ? []
            : List<Record>.from(
                json["records"]!.map((x) => Record.fromJson(x))),
        totalCount: json["totalCount"],
        startIndex: json["startIndex"],
        fetchRecord: json["fetchRecord"],
      );

  Map<String, dynamic> toJson() => {
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
        "totalCount": totalCount,
        "startIndex": startIndex,
        "fetchRecord": fetchRecord,
      };
}

class Record {
  final int? id;
  final String? name;
  final String? icon;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? iconUrl;

  Record({
    this.id,
    this.name,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "icon_url": iconUrl,
      };
}

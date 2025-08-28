import 'dart:convert';

ForumModel forumModelFromJson(String str) =>
    ForumModel.fromJson(json.decode(str));

String forumModelToJson(ForumModel data) => json.encode(data.toJson());

class ForumModel {
  final List<ForumData>? data;
  final bool? success;
  final String? message;

  ForumModel({
    this.data,
    this.success,
    this.message,
  });

  factory ForumModel.fromJson(Map<String, dynamic> json) => ForumModel(
        data: json["data"] == null
            ? []
            : List<ForumData>.from(
                json["data"]!.map((x) => ForumData.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
      };
}

class ForumData {
  final int? id;
  final ForumCategory? forumCategory;
  final ForumCategory? forumSubCategory;
  final String? title;
  final String? description;
  final String? time;

  ForumData({
    this.id,
    this.forumCategory,
    this.forumSubCategory,
    this.title,
    this.description,
    this.time,
  });

  factory ForumData.fromJson(Map<String, dynamic> json) => ForumData(
        id: json["id"],
        forumCategory: json["forum_category"] == null
            ? null
            : ForumCategory.fromJson(json["forum_category"]),
        forumSubCategory: json["forum_sub_category"] == null
            ? null
            : ForumCategory.fromJson(json["forum_sub_category"]),
        title: json["title"],
        description: json["description"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "forum_category": forumCategory?.toJson(),
        "forum_sub_category": forumSubCategory?.toJson(),
        "title": title,
        "description": description,
        "time": time,
      };
}

class ForumCategory {
  final int? id;
  final String? name;

  ForumCategory({
    this.id,
    this.name,
  });

  factory ForumCategory.fromJson(Map<String, dynamic> json) => ForumCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

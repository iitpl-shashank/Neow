import 'dart:convert';

ForumCategoryModel forumCategoryModelFromJson(String str) =>
    ForumCategoryModel.fromJson(json.decode(str));

String forumCategoryModelToJson(ForumCategoryModel data) =>
    json.encode(data.toJson());

class ForumCategoryModel {
  final List<ForumCategory>? data;
  final bool? success;
  final String? message;

  ForumCategoryModel({
    this.data,
    this.success,
    this.message,
  });

  factory ForumCategoryModel.fromJson(Map<String, dynamic> json) {
    return ForumCategoryModel(
      data: (json["data"] as List<dynamic>?)
              ?.map((x) => ForumCategory.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      success: json["success"] as bool?,
      message: json["message"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.map((x) => x.toJson()).toList() ?? [],
        "success": success,
        "message": message,
      };
}

class ForumCategory {
  final int? id;
  final String? name;
  final List<SubCategory>? subCategories;

  ForumCategory({
    this.id,
    this.name,
    this.subCategories,
  });

  factory ForumCategory.fromJson(Map<String, dynamic> json) {
    return ForumCategory(
      id: json["id"] as int?,
      name: json["name"] as String?,
      subCategories: (json["sub_categories"] as List<dynamic>?)
              ?.map((x) => SubCategory.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_categories": subCategories?.map((x) => x.toJson()).toList() ?? [],
      };
}

class SubCategory {
  final int? id;
  final String? name;

  SubCategory({
    this.id,
    this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json["id"] as int?,
      name: json["name"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

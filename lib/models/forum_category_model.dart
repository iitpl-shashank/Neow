import 'dart:convert';

class ForumCategoryResponse {
  List<Category>? data;
  bool? success;
  String? message;

  ForumCategoryResponse({
    this.data,
    this.success,
    this.message,
  });

  factory ForumCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ForumCategoryResponse(
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"].map((x) => Category.fromJson(x))),
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

  /// Helpers for raw string conversion
  factory ForumCategoryResponse.fromRawJson(String str) =>
      ForumCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Category {
  int? id;
  String? name;
  List<SubCategory>? subCategories;

  Category({
    this.id,
    this.name,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        subCategories: json["sub_categories"] == null
            ? []
            : List<SubCategory>.from(
                json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_categories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class SubCategory {
  int? id;
  String? name;
  bool? isLike;

  SubCategory({
    this.id,
    this.name,
    this.isLike,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        isLike: json["is_like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_like": isLike,
      };
}

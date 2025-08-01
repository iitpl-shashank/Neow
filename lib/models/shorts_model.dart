import 'dart:convert';

ShortsModel shortsModelFromJson(String str) =>
    ShortsModel.fromJson(json.decode(str));

String shortsModelToJson(ShortsModel data) => json.encode(data.toJson());

class ShortsModel {
  final Data? data;
  final bool? success;
  final String? message;

  ShortsModel({
    this.data,
    this.success,
    this.message,
  });

  factory ShortsModel.fromJson(Map<String, dynamic> json) => ShortsModel(
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
  final List<ShortsData>? postsData;
  final Pagination? pagination;

  Data({
    this.postsData,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postsData: json["PostsData"] == null
            ? []
            : List<ShortsData>.from(
                json["PostsData"]!.map((x) => ShortsData.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "PostsData": postsData == null
            ? []
            : List<dynamic>.from(postsData!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  final int? currentPage;
  final int? totalPages;
  final int? perPage;
  final int? total;
  final String? nextPageUrl;
  final dynamic prevPageUrl;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.perPage,
    this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        perPage: json["per_page"],
        total: json["total"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_pages": totalPages,
        "per_page": perPage,
        "total": total,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
      };
}

class ShortsData {
  final int? id;
  final int? shortType;
  final String? description;
  final String? video;
  final String? diffrenceTime;
  final Category? category;
  int? likesCount;
  bool? isLiked;
  final bool? isSaved;
  final String? image;

  ShortsData({
    this.id,
    this.shortType,
    this.description,
    this.video,
    this.diffrenceTime,
    this.category,
    this.likesCount,
    this.isLiked,
    this.isSaved,
    this.image,
  });

  factory ShortsData.fromJson(Map<String, dynamic> json) => ShortsData(
        id: json["id"],
        shortType: json["short_type"],
        description: json["description"],
        video: json["video"],
        diffrenceTime: json["diffrence_time"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        likesCount: json["likes_count"],
        isLiked: json["is_liked"],
        isSaved: json["is_saved"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "short_type": shortType,
        "description": description,
        "video": video,
        "diffrence_time": diffrenceTime,
        "category": category?.toJson(),
        "likes_count": likesCount,
        "is_liked": isLiked,
        "image": image,
        "is_saved": isSaved,
      };
}

class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

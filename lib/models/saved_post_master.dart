import 'dart:convert';

class SavedPostMaster {
  final Data? data;
  final bool? success;
  final String? message;

  SavedPostMaster({
    this.data,
    this.success,
    this.message,
  });

  factory SavedPostMaster.fromRawJson(String str) =>
      SavedPostMaster.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavedPostMaster.fromJson(Map<String, dynamic> json) =>
      SavedPostMaster(
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
  final List<SavedPost>? data;
  final Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<SavedPost>.from(
                json["data"]!.map((x) => SavedPost.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class SavedPost {
  final int? id;
  final String? parentTitle;
  final String? title;
  final String? description;
  final String? posts;
  final String? fileType;
  final String? diffrenceTime;

  SavedPost({
    this.id,
    this.parentTitle,
    this.title,
    this.description,
    this.posts,
    this.fileType,
    this.diffrenceTime,
  });

  factory SavedPost.fromRawJson(String str) =>
      SavedPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SavedPost.fromJson(Map<String, dynamic> json) => SavedPost(
        id: json["id"],
        parentTitle: json["parent_title"],
        title: json["title"],
        description: json["description"],
        posts: json["posts"],
        fileType: json["file_type"],
        diffrenceTime: json["diffrence_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_title": parentTitle,
        "title": title,
        "description": description,
        "posts": posts,
        "file_type": fileType,
        "diffrence_time": diffrenceTime,
      };
}

class Pagination {
  final int? currentPage;
  final String? nextPageUrl;
  final dynamic prevPageUrl;
  final int? total;
  final int? perPage;
  final int? lastPage;

  Pagination({
    this.currentPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.total,
    this.perPage,
    this.lastPage,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        total: json["total"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "total": total,
        "per_page": perPage,
        "last_page": lastPage,
      };
}

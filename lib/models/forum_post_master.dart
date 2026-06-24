import 'dart:convert';

class ForumPostModel {
  List<ForumPost>? data;
  bool? success;
  String? message;
  Pagination? pagination;

  ForumPostModel({
    this.data,
    this.success,
    this.message,
    this.pagination,
  });

  factory ForumPostModel.fromJson(Map<String, dynamic> json) {
    // Handle both data structures
    List<ForumPost> parseData(dynamic jsonData) {
      if (jsonData == null) return [];

      // Handle case where data is wrapped in another "data" object
      if (jsonData is Map && jsonData.containsKey("data")) {
        jsonData = jsonData["data"];
      }

      return List<ForumPost>.from(jsonData.map((x) => ForumPost.fromJson(x)));
    }

    // Handle pagination data if present
    Pagination? parsePagination(dynamic jsonData) {
      if (jsonData is Map &&
          jsonData.containsKey("data") &&
          jsonData["data"] is Map &&
          jsonData["data"].containsKey("pagination")) {
        return Pagination.fromJson(jsonData["data"]["pagination"]);
      }
      return null;
    }

    return ForumPostModel(
      data: parseData(json["data"]),
      success: json["success"],
      message: json["message"],
      pagination: parsePagination(json),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
      };

  factory ForumPostModel.fromRawJson(String str) =>
      ForumPostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Pagination {
  int? currentPage;
  String? nextPageUrl;
  String? prevPageUrl;
  int? total;
  int? perPage;
  int? lastPage;

  Pagination({
    this.currentPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.total,
    this.perPage,
    this.lastPage,
  });

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

class ForumPost {
  int? id;
  ForumCategory? forumCategory;
  ForumCategory? forumSubCategory;
  String? title;
  String? description;
  String? media;
  String? time;
  String? author; // Added
  String? authorImage; // Added
  bool? liked;
  int? totalLike;
  String? saved;
  List<Comment>? comments;
  int? commentCount;

  ForumPost({
    this.id,
    this.forumCategory,
    this.forumSubCategory,
    this.title,
    this.description,
    this.media,
    this.time,
    this.author, // Added
    this.authorImage, // Added
    this.liked,
    this.totalLike,
    this.saved,
    this.comments,
    this.commentCount,
  });

  void copyFrom(ForumPost other) {
    id = other.id;
    forumCategory = other.forumCategory;
    forumSubCategory = other.forumSubCategory;
    title = other.title;
    description = other.description;
    media = other.media;
    time = other.time;
    author = other.author;
    authorImage = other.authorImage;
    liked = other.liked;
    totalLike = other.totalLike;
    saved = other.saved;
    comments = other.comments;
    commentCount = other.commentCount;
  }

  ForumPost copyWith({
    int? id,
    ForumCategory? forumCategory,
    ForumCategory? forumSubCategory,
    String? title,
    String? description,
    String? media,
    String? time,
    String? author,
    String? authorImage,
    bool? liked,
    int? totalLike,
    String? saved,
    List<Comment>? comments,
    int? commentCount,
  }) {
    return ForumPost(
      id: id ?? this.id,
      forumCategory: forumCategory ?? this.forumCategory,
      forumSubCategory: forumSubCategory ?? this.forumSubCategory,
      title: title ?? this.title,
      description: description ?? this.description,
      media: media ?? this.media,
      time: time ?? this.time,
      author: author ?? this.author,
      authorImage: authorImage ?? this.authorImage,
      liked: liked ?? this.liked,
      totalLike: totalLike ?? this.totalLike,
      saved: saved ?? this.saved,
      comments: comments ?? this.comments,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  factory ForumPost.fromJson(Map<String, dynamic> json) => ForumPost(
      id: json["id"],
      forumCategory: json["forum_category"] == null
          ? null
          : ForumCategory.fromJson(json["forum_category"]),
      forumSubCategory: json["forum_sub_category"] == null
          ? null
          : ForumCategory.fromJson(json["forum_sub_category"]),
      title: json["title"],
      description: json["description"],
      media: json["media"],
      time: json["time"],
      author: json["author"], // Added
      authorImage: json["author_image"], // Added
      liked: json["liked"] == "1" ||
          json["liked"] == 1 ||
          json["liked"] == true ||
          (json["liked"] is String && json["liked"].toLowerCase() == "yes"),
      totalLike: json["total_like"] ?? 0,
      saved: json["saved"],
      comments: json["comments"] == null
          ? []
          : List<Comment>.from(
              json["comments"].map((x) => Comment.fromJson(x))),
      commentCount: json["total_comment"] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "forum_category": forumCategory?.toJson(),
        "forum_sub_category": forumSubCategory?.toJson(),
        "title": title,
        "description": description,
        "media": media,
        "time": time,
        "author": author, // Added
        "author_image": authorImage, // Added
        "liked": liked,
        "total_like": totalLike,
        "saved": saved,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  int? id;
  UserDetail? userDetail;
  String? comment;
  String? adminReply;
  String? commentTime;

  Comment({
    this.id,
    this.userDetail,
    this.comment,
    this.adminReply,
    this.commentTime,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        userDetail: json["user_detail"] == null
            ? null
            : UserDetail.fromJson(json["user_detail"]),
        comment: json["comment"],
        adminReply: json["admin_reply"],
        commentTime: json["comment_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_detail": userDetail?.toJson(),
        "comment": comment,
        "admin_reply": adminReply,
        "comment_time": commentTime,
      };
}

class UserDetail {
  int? id;
  String? name;
  dynamic image;

  UserDetail({
    this.id,
    this.name,
    this.image,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class ForumCategory {
  int? id;
  String? name;

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

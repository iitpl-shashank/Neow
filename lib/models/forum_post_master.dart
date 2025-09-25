import 'dart:convert';

class ForumPostModel {
  List<ForumPost>? data;
  bool? success;
  String? message;

  ForumPostModel({
    this.data,
    this.success, 
    this.message,
  });

  factory ForumPostModel.fromJson(Map<String, dynamic> json) => ForumPostModel(
        data: json["data"] == null
            ? []
            : List<ForumPost>.from(
                json["data"].map((x) => ForumPost.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
      };

  /// Helper to parse from JSON string
  factory ForumPostModel.fromRawJson(String str) =>
      ForumPostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class ForumPost {
  int? id;
  ForumCategory? forumCategory;
  ForumCategory? forumSubCategory;
  String? title;
  String? description;
  String? media;
  String? time;
  String? author;        // Added
  String? authorImage;   // Added
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
    this.author,         // Added
    this.authorImage,    // Added
    this.liked,
    this.totalLike,
    this.saved,
    this.comments,
    this.commentCount,
  });

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
        author: json["author"],           // Added
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
        commentCount: json["comments"] == null ? 0 : (json["comments"] as List).length,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "forum_category": forumCategory?.toJson(),
        "forum_sub_category": forumSubCategory?.toJson(),
        "title": title,
        "description": description,
        "media": media,
        "time": time,
        "author": author,            // Added
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

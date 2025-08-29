

import 'dart:convert';

ForumPostLikeDislike forumPostLikeDislikeFromJson(String str) => ForumPostLikeDislike.fromJson(json.decode(str));

String forumPostLikeDislikeToJson(ForumPostLikeDislike data) => json.encode(data.toJson());

class ForumPostLikeDislike {
    final dynamic data;
    final bool? success;
    final String? message;

    ForumPostLikeDislike({
        this.data,
        this.success,
        this.message,
    });

    factory ForumPostLikeDislike.fromJson(Map<String, dynamic> json) => ForumPostLikeDislike(
        data: json["data"],
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
        "success": success,
        "message": message,
    };
}

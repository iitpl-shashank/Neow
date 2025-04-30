class HealthMixLatestPost {
  final Data? data;
  final bool? success;
  final String? message;

  HealthMixLatestPost({
    this.data,
    this.success,
    this.message,
  });

  // fromJson
  factory HealthMixLatestPost.fromJson(Map<String, dynamic> json) {
    return HealthMixLatestPost(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      success: json['success'],
      message: json['message'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'success': success,
      'message': message,
    };
  }
}

class Data {
  final List<HealthMixPost>? healthMixPosts;

  Data({
    this.healthMixPosts,
  });

  // fromJson
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      healthMixPosts: json['HealthMixPosts'] != null
          ? (json['HealthMixPosts'] as List)
              .map((post) => HealthMixPost.fromJson(post))
              .toList()
          : null,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'HealthMixPosts': healthMixPosts?.map((post) => post.toJson()).toList(),
    };
  }
}

class HealthMixPost {
  final int? id;
  final int? healthType;
  final String? media;
  final MediaType? mediaType;
  final String? hashtags;
  final String? thumbnail;
  final String? description;
  final DateTime? createdAt;
  final String? diffrenceTime;
  final Category? category;

  HealthMixPost({
    this.id,
    this.healthType,
    this.media,
    this.mediaType,
    this.hashtags,
    this.thumbnail,
    this.description,
    this.createdAt,
    this.diffrenceTime,
    this.category,
  });

  // fromJson
  factory HealthMixPost.fromJson(Map<String, dynamic> json) {
    return HealthMixPost(
      id: json['id'],
      healthType: json['health_type'],
      media: json['media'],
      mediaType: json['media_type'] == 'image'
          ? MediaType.IMAGE
          : MediaType.LINK, // Convert string to enum
      hashtags: json['hashtags'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      diffrenceTime: json['diffrence_time'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'health_type': healthType,
      'media': media,
      'media_type': mediaType == MediaType.IMAGE ? 'image' : 'link',
      'hashtags': hashtags,
      'thumbnail': thumbnail,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'diffrence_time': diffrenceTime,
      'category': category?.toJson(),
    };
  }
}

class Category {
  final int? id;
  final String? title;
  final String? image;

  Category({
    this.id,
    this.title,
    this.image,
  });

  // fromJson
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }
}

enum MediaType { IMAGE, LINK }

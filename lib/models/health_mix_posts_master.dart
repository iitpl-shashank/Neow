class HealthMixPostMaster {
  Data? _data;
  bool? _success;
  String? _message;

  HealthMixPostMaster({Data? data, bool? success, String? message}) {
    if (data != null) {
      _data = data;
    }
    if (success != null) {
      _success = success;
    }
    if (message != null) {
      _message = message;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  HealthMixPostMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

class Data {
  List<HealthMixPosts>? _healthMixPosts;

  Data({List<HealthMixPosts>? healthMixPosts}) {
    if (healthMixPosts != null) {
      _healthMixPosts = healthMixPosts;
    }
  }

  List<HealthMixPosts>? get healthMixPosts => _healthMixPosts;
  set healthMixPosts(List<HealthMixPosts>? healthMixPosts) =>
      _healthMixPosts = healthMixPosts;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['HealthMixPosts'] != null) {
      _healthMixPosts = <HealthMixPosts>[];
      json['HealthMixPosts'].forEach((v) {
        _healthMixPosts!.add(HealthMixPosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_healthMixPosts != null) {
      data['HealthMixPosts'] =
          _healthMixPosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthMixPosts {
  int? _id;
  int? _healthType;
  String? _media;
  String? _mediaType;
  String? _hashtags;
  String? _description;
  String? _createdAt;
  String? _diffrenceTime;

  HealthMixPosts(
      {int? id,
        int? healthType,
        String? media,
        String? mediaType,
        String? hashtags,
        String? description,
        String? createdAt,
        String? diffrenceTime}) {
    if (id != null) {
      _id = id;
    }
    if (healthType != null) {
      _healthType = healthType;
    }
    if (media != null) {
      _media = media;
    }
    if (mediaType != null) {
      _mediaType = mediaType;
    }
    if (hashtags != null) {
      _hashtags = hashtags;
    }
    if (description != null) {
      _description = description;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (diffrenceTime != null) {
      _diffrenceTime = diffrenceTime;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get healthType => _healthType;
  set healthType(int? healthType) => _healthType = healthType;
  String? get media => _media;
  set media(String? media) => _media = media;
  String? get mediaType => _mediaType;
  set mediaType(String? mediaType) => _mediaType = mediaType;
  String? get hashtags => _hashtags;
  set hashtags(String? hashtags) => _hashtags = hashtags;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get diffrenceTime => _diffrenceTime;
  set diffrenceTime(String? diffrenceTime) => _diffrenceTime = diffrenceTime;

  HealthMixPosts.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _healthType = json['health_type'];
    _media = json['media'];
    _mediaType = json['media_type'];
    _hashtags = json['hashtags'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _diffrenceTime = json['diffrence_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['health_type'] = _healthType;
    data['media'] = _media;
    data['media_type'] = _mediaType;
    data['hashtags'] = _hashtags;
    data['description'] = _description;
    data['created_at'] = _createdAt;
    data['diffrence_time'] = _diffrenceTime;
    return data;
  }
}

class ForumPostMaster {
  List<ForumPostData>? _data;
  bool? _success;
  String? _message;

  ForumPostMaster({List<ForumPostData>? data, bool? success, String? message}) {
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

  List<ForumPostData>? get data => _data;
  set data(List<ForumPostData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  ForumPostMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <ForumPostData>[];
      json['data'].forEach((v) {
        _data!.add(ForumPostData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

class ForumPostData {
  int? _id;
  ForumCategory? _forumCategory;
  ForumCategory? _forumSubCategory;
  String? _title;
  String? _description;
  String? _time;

  ForumPostData(
      {int? id,
        ForumCategory? forumCategory,
        ForumCategory? forumSubCategory,
        String? title,
        String? description,
        String? time}) {
    if (id != null) {
      _id = id;
    }
    if (forumCategory != null) {
      _forumCategory = forumCategory;
    }
    if (forumSubCategory != null) {
      _forumSubCategory = forumSubCategory;
    }
    if (title != null) {
      _title = title;
    }
    if (description != null) {
      _description = description;
    }
    if (time != null) {
      _time = time;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  ForumCategory? get forumCategory => _forumCategory;
  set forumCategory(ForumCategory? forumCategory) =>
      _forumCategory = forumCategory;
  ForumCategory? get forumSubCategory => _forumSubCategory;
  set forumSubCategory(ForumCategory? forumSubCategory) =>
      _forumSubCategory = forumSubCategory;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get time => _time;
  set time(String? time) => _time = time;

  ForumPostData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _forumCategory = json['forum_category'] != null
        ? ForumCategory.fromJson(json['forum_category'])
        : null;
    _forumSubCategory = json['forum_sub_category'] != null
        ? ForumCategory.fromJson(json['forum_sub_category'])
        : null;
    _title = json['title'];
    _description = json['description'];
    _time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_forumCategory != null) {
      data['forum_category'] = _forumCategory!.toJson();
    }
    if (_forumSubCategory != null) {
      data['forum_sub_category'] = _forumSubCategory!.toJson();
    }
    data['title'] = _title;
    data['description'] = _description;
    data['time'] = _time;
    return data;
  }
}

class ForumCategory {
  int? _id;
  String? _name;

  ForumCategory({int? id, String? name}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;

  ForumCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    return data;
  }
}

class WomenNewsMaster {
  List<NewsData>? _data;
  bool? _success;
  String? _message;

  WomenNewsMaster({List<NewsData>? data, bool? success, String? message}) {
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

  List<NewsData>? get data => _data;
  set data(List<NewsData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  WomenNewsMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <NewsData>[];
      json['data'].forEach((v) {
        _data!.add(NewsData.fromJson(v));
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

class NewsData {
  int? _id;
  String? _title;
  String? _description;
  String? _posts;
  String? _fileType;

  NewsData(
      {int? id,
        String? title,
        String? description,
        String? posts,
        String? fileType}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (description != null) {
      _description = description;
    }
    if (posts != null) {
      _posts = posts;
    }
    if (fileType != null) {
      _fileType = fileType;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get posts => _posts;
  set posts(String? posts) => _posts = posts;
  String? get fileType => _fileType;
  set fileType(String? fileType) => _fileType = fileType;

  NewsData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _posts = json['posts'];
    _fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['description'] = _description;
    data['posts'] = _posts;
    data['file_type'] = _fileType;
    return data;
  }
}

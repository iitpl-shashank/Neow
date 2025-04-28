class AllPostsMaster {
  PostData? _data;
  bool? _success;
  String? _message;

  AllPostsMaster({PostData? data, bool? success, String? message}) {
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

  PostData? get data => _data;
  set data(PostData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  AllPostsMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? PostData.fromJson(json['data']) : null;
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

class PostData {
  List<PostsData>? _postsData;

  PostData({List<PostsData>? postsData}) {
    if (postsData != null) {
      _postsData = postsData;
    }
  }

  List<PostsData>? get postsData => _postsData;
  set postsData(List<PostsData>? postsData) => _postsData = postsData;

  PostData.fromJson(Map<String, dynamic> json) {
    if (json['PostsData'] != null) {
      _postsData = <PostsData>[];
      json['PostsData'].forEach((v) {
        _postsData!.add(PostsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_postsData != null) {
      data['PostsData'] = _postsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostsData {
  int? _id;
  String? _parentTitle;
  String? _description;
  String? _posts;
  String? _fileType;
  String? _title;
  String? _diffrenceTime;

  PostsData(
      {int? id,
        String? parentTitle,
        String? description,
        String? posts,
        String? title,
        String? fileType,
        String? diffrenceTime}) {
    if (id != null) {
      _id = id;
    }
    if (parentTitle != null) {
      _parentTitle = parentTitle;
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
    if(title != null) {
      _title = title;
    }
    if(diffrenceTime != null){
      _diffrenceTime = diffrenceTime;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get parentTitle => _parentTitle;
  set parentTitle(String? parentTitle) => _parentTitle = parentTitle;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get posts => _posts;
  set posts(String? posts) => _posts = posts;
  String? get fileType => _fileType;
  set fileType(String? fileType) => _fileType = fileType;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get diffrenceTime => _diffrenceTime;
  set diffrenceTime(String? diffrenceTime) => _diffrenceTime = diffrenceTime;

  PostsData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _parentTitle = json['parent_title'];
    _description = json['description'];
    _posts = json['posts'];
    _fileType = json['file_type'];
    _diffrenceTime = json['diffrence_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['parent_title'] = _parentTitle;
    data['description'] = _description;
    data['posts'] = _posts;
    data['file_type'] = _fileType;
    data['title'] = _title;
    data['diffrence_time'] = _diffrenceTime;
    return data;
  }
}

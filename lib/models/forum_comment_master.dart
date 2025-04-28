class ForumCommentMaster {
  List<CommentData>? _data;
  bool? _success;
  String? _message;

  ForumCommentMaster({List<CommentData>? data, bool? success, String? message}) {
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

  List<CommentData>? get data => _data;
  set data(List<CommentData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  ForumCommentMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <CommentData>[];
      json['data'].forEach((v) {
        _data!.add(CommentData.fromJson(v));
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

class CommentData {
  int? _id;
  UserDetail? _userDetail;
  String? _comment;
  String? _adminReply;
  String? _commentTime;

  CommentData(
      {int? id,
        UserDetail? userDetail,
        String? comment,
        String? adminReply,
        String? commentTime}) {
    if (id != null) {
      _id = id;
    }
    if (userDetail != null) {
      _userDetail = userDetail;
    }
    if (comment != null) {
      _comment = comment;
    }
    if (adminReply != null) {
      _adminReply = adminReply;
    }
    if (commentTime != null) {
      _commentTime = commentTime;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  UserDetail? get userDetail => _userDetail;
  set userDetail(UserDetail? userDetail) => _userDetail = userDetail;
  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;
  String? get adminReply => _adminReply;
  set adminReply(String? adminReply) => _adminReply = adminReply;
  String? get commentTime => _commentTime;
  set commentTime(String? commentTime) => _commentTime = commentTime;

  CommentData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
    _comment = json['comment'];
    _adminReply = json['admin_reply'];
    _commentTime = json['comment_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    if (_userDetail != null) {
      data['user_detail'] = _userDetail!.toJson();
    }
    data['comment'] = _comment;
    data['admin_reply'] = _adminReply;
    data['comment_time'] = _commentTime;
    return data;
  }
}

class UserDetail {
  int? _id;
  String? _name;
  String? _image;

  UserDetail({int? id, String? name, String? image}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (image != null) {
      _image = image;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;

  UserDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['image'] = _image;
    return data;
  }
}

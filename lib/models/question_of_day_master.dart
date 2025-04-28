class QuestionOfDayMaster {
  Data? _data;
  bool? _success;
  String? _message;

  QuestionOfDayMaster({Data? data, bool? success, String? message}) {
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

  QuestionOfDayMaster.fromJson(Map<String, dynamic> json) {
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
  String? _name;
  String? _userQuestion;
  int? _userId;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  Data(
      {String? name,
        String? userQuestion,
        int? userId,
        String? updatedAt,
        String? createdAt,
        int? id}) {
    if (name != null) {
      _name = name;
    }
    if (userQuestion != null) {
      _userQuestion = userQuestion;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (id != null) {
      _id = id;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get userQuestion => _userQuestion;
  set userQuestion(String? userQuestion) => _userQuestion = userQuestion;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  int? get id => _id;
  set id(int? id) => _id = id;

  Data.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _userQuestion = json['user_question'];
    _userId = json['user_id'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['user_question'] = _userQuestion;
    data['user_id'] = _userId;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    data['id'] = _id;
    return data;
  }
}

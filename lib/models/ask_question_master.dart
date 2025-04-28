class AskQuestionMaster {
  List<AnswerData>? _data;
  bool? _success;
  String? _message;

  AskQuestionMaster({List<AnswerData>? data, bool? success, String? message}) {
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

  List<AnswerData>? get data => _data;
  set data(List<AnswerData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  AskQuestionMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <AnswerData>[];
      json['data'].forEach((v) {
        _data!.add(AnswerData.fromJson(v));
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

class AnswerData {
  int? _id;
  int? _userId;
  String? _name;
  String? _userQuestion;
  String? _image;
  String? _fileType;
  String? _questionAnswer;

  AnswerData(
      {int? id,
        int? userId,
        String? name,
        String? userQuestion,
        String? image,
        String? fileType,
        String? questionAnswer}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (name != null) {
      _name = name;
    }
    if (userQuestion != null) {
      _userQuestion = userQuestion;
    }
    if (image != null) {
      _image = image;
    }
    if (fileType != null) {
      _fileType = fileType;
    }
    if (questionAnswer != null) {
      _questionAnswer = questionAnswer;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get userQuestion => _userQuestion;
  set userQuestion(String? userQuestion) => _userQuestion = userQuestion;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get fileType => _fileType;
  set fileType(String? fileType) => _fileType = fileType;
  String? get questionAnswer => _questionAnswer;
  set questionAnswer(String? questionAnswer) =>
      _questionAnswer = questionAnswer;

  AnswerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _userQuestion = json['user_question'];
    _image = json['image'];
    _fileType = json['file_type'];
    _questionAnswer = json['question_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['name'] = _name;
    data['user_question'] = _userQuestion;
    data['image'] = _image;
    data['file_type'] = _fileType;
    data['question_answer'] = _questionAnswer;
    return data;
  }
}

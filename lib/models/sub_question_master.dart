class SubQuestionMaster {
  SubQuestionData? _data;
  bool? _success;
  String? _message;

  SubQuestionMaster({SubQuestionData? data, bool? success, String? message}) {
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

  SubQuestionData? get data => _data;
  set data(SubQuestionData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  SubQuestionMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null
        ? SubQuestionData.fromJson(json['data'])
        : null;
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

class SubQuestionData {
  String? _notification;
  int? _questionId;
  String? _question;
  List<SubQuestionOptions>? _options;

  SubQuestionData(
      {String? notification,
      int? questionId,
      String? question,
      List<SubQuestionOptions>? options}) {
    if (notification != null) {
      _notification = notification;
    }
    if (questionId != null) {
      _questionId = questionId;
    }
    if (question != null) {
      _question = question;
    }
    if (options != null) {
      _options = options;
    }
  }

  String? get notification => _notification;
  set notification(String? notification) => _notification = notification;
  int? get questionId => _questionId;
  set questionId(int? questionId) => _questionId = questionId;
  String? get question => _question;
  set question(String? question) => _question = question;
  List<SubQuestionOptions>? get options => _options;
  set options(List<SubQuestionOptions>? options) => _options = options;

  SubQuestionData.fromJson(Map<String, dynamic> json) {
    _notification = json['notification'];
    _questionId = json['question_id'];
    _question = json['question'];
    if (json['options'] != null) {
      _options = <SubQuestionOptions>[];
      json['options'].forEach((v) {
        _options!.add(SubQuestionOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification'] = _notification;
    data['question_id'] = _questionId;
    data['question'] = _question;
    if (_options != null) {
      data['options'] = _options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubQuestionOptions {
  int? _id;
  String? _optionName;

  SubQuestionOptions({int? id, String? optionName}) {
    if (id != null) {
      _id = id;
    }
    if (optionName != null) {
      _optionName = optionName;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get optionName => _optionName;
  set optionName(String? optionName) => _optionName = optionName;

  SubQuestionOptions.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _optionName = json['option_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['option_name'] = _optionName;
    return data;
  }
}

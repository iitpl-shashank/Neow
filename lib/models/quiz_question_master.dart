class QuizQuestionMaster {
  List<QuestionData>? _data;
  bool? _success;
  String? _message;

  QuizQuestionMaster({List<QuestionData>? data, bool? success, String? message}) {
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

  List<QuestionData>? get data => _data;
  set data(List<QuestionData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  QuizQuestionMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <QuestionData>[];
      json['data'].forEach((v) {
        _data!.add(QuestionData.fromJson(v));
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

class QuestionData {
  int? _id;
  int? _questionTypeId;
  String? _questionName;
  List<Options>? _options;
  AgeGroup? _ageGroup;

  QuestionData(
      {int? id,
        int? questionTypeId,
        String? questionName,
        List<Options>? options,
        AgeGroup? ageGroup}) {
    if (id != null) {
      _id = id;
    }
    if (questionTypeId != null) {
      _questionTypeId = questionTypeId;
    }
    if (questionName != null) {
      _questionName = questionName;
    }
    if (options != null) {
      _options = options;
    }
    if (ageGroup != null) {
      _ageGroup = ageGroup;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get questionTypeId => _questionTypeId;
  set questionTypeId(int? questionTypeId) => _questionTypeId = questionTypeId;
  String? get questionName => _questionName;
  set questionName(String? questionName) => _questionName = questionName;
  List<Options>? get options => _options;
  set options(List<Options>? options) => _options = options;
  AgeGroup? get ageGroup => _ageGroup;
  set ageGroup(AgeGroup? ageGroup) => _ageGroup = ageGroup;

  QuestionData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _questionTypeId = json['questionType_id'];
    _questionName = json['question_name'];
    if (json['options'] != null) {
      _options = <Options>[];
      json['options'].forEach((v) {
        _options!.add(Options.fromJson(v));
      });
    }
    _ageGroup = json['age_group'] != null
        ? AgeGroup.fromJson(json['age_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['questionType_id'] = _questionTypeId;
    data['question_name'] = _questionName;
    if (_options != null) {
      data['options'] = _options!.map((v) => v.toJson()).toList();
    }
    if (_ageGroup != null) {
      data['age_group'] = _ageGroup!.toJson();
    }
    return data;
  }
}

class Options {
  int? _questionId;
  int? _optionId;
  String? _optionName;

  Options({int? questionId, int? optionId, String? optionName}) {
    if (questionId != null) {
      _questionId = questionId;
    }
    if (optionId != null) {
      _optionId = optionId;
    }
    if (optionName != null) {
      _optionName = optionName;
    }
  }

  int? get questionId => _questionId;
  set questionId(int? questionId) => _questionId = questionId;
  int? get optionId => _optionId;
  set optionId(int? optionId) => _optionId = optionId;
  String? get optionName => _optionName;
  set optionName(String? optionName) => _optionName = optionName;

  Options.fromJson(Map<String, dynamic> json) {
    _questionId = json['question_id'];
    _optionId = json['option_id'];
    _optionName = json['option_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = _questionId;
    data['option_id'] = _optionId;
    data['option_name'] = _optionName;
    return data;
  }
}

class AgeGroup {
  int? _id;
  String? _name;

  AgeGroup({int? id, String? name}) {
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

  AgeGroup.fromJson(Map<String, dynamic> json) {
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

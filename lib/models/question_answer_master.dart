class QuestionAnswerMaster {
  List<AnswerData>? _data;
  String? _pms;
  String? _pco;
  String? _anemia;
  String? _message;
  bool? _success;

  QuestionAnswerMaster(
      {List<AnswerData>? data,
      String? pms,
      String? pco,
      String? anemia,
      String? message,
      bool? success}) {
    if (data != null) {
      _data = data;
    }
    if (pms != null) {
      _pms = pms;
    }
    if (pco != null) {
      _pco = pco;
    }
    if (anemia != null) {
      _anemia = anemia;
    }
    if (message != null) {
      _message = message;
    }
    if (success != null) {
      _success = success;
    }
  }

  List<AnswerData>? get data => _data;
  set data(List<AnswerData>? data) => _data = data;
  String? get pms => _pms;
  set pms(String? pms) => _pms = pms;
  String? get pco => _pco;
  set pco(String? pco) => _pco = pco;
  String? get anemia => _anemia;
  set anemia(String? anemia) => _anemia = anemia;
  String? get message => _message;
  set message(String? message) => _message = message;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  QuestionAnswerMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <AnswerData>[];
      json['data'].forEach((v) {
        _data!.add(AnswerData.fromJson(v));
      });
    }
    _pms = json['pms'];
    _pco = json['pco'];
    _anemia = json['anemia'];
    _message = json['message'];
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    data['pms'] = _pms;
    data['pco'] = _pco;
    data['anemia'] = _anemia;
    data['message'] = _message;
    data['success'] = _success;
    return data;
  }
}

class AnswerData {
  int? _questionId;
  int? _optionId;

  AnswerData({int? questionId, int? optionId}) {
    if (questionId != null) {
      _questionId = questionId;
    }
    if (optionId != null) {
      _optionId = optionId;
    }
  }

  int? get questionId => _questionId;
  set questionId(int? questionId) => _questionId = questionId;
  int? get optionId => _optionId;
  set optionId(int? optionId) => _optionId = optionId;

  AnswerData.fromJson(Map<String, dynamic> json) {
    _questionId = json['question_id'];
    _optionId = json['option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = _questionId;
    data['option_id'] = _optionId;
    return data;
  }
}

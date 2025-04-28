class QuizMaster {
  List<QuizData>? _data;
  bool? _success;
  String? _message;

  QuizMaster({List<QuizData>? data, bool? success, String? message}) {
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

  List<QuizData>? get data => _data;
  set data(List<QuizData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  QuizMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <QuizData>[];
      json['data'].forEach((v) {
        _data!.add(QuizData.fromJson(v));
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

class QuizData {
  int? _id;
  String? _name;
  String? _icon;
  String? _description;

  QuizData({int? id, String? name, String? icon,String? description}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (icon != null) {
      _icon = icon;
    }
    if (description != null) {
      _description = description;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;
  String? get description => _description;
  set description(String? description) => _description = description;

  QuizData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['icon'] = _icon;
    data['description'] = _description;
    return data;
  }
}

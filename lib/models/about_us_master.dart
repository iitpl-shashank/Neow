class AboutUsMaster {
  AboutData? _data;
  bool? _success;
  String? _message;

  AboutUsMaster({AboutData? data, bool? success, String? message}) {
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

  AboutData? get data => _data;
  set data(AboutData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  AboutUsMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? AboutData.fromJson(json['data']) : null;
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

class AboutData {
  String? _termAndCondition;
  String? _description;
  String? _aboutUs;

  AboutData({String? termAndCondition, String? description, String? aboutUs}) {
    if (termAndCondition != null) {
      _termAndCondition = termAndCondition;
    }
    if (description != null) {
      _description = description;
    }
    if (aboutUs != null) {
      _aboutUs = aboutUs;
    }
  }

  String? get termAndCondition => _termAndCondition;
  set termAndCondition(String? termAndCondition) =>
      _termAndCondition = termAndCondition;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get aboutUs => _aboutUs;
  set aboutUs(String? aboutUs) => _aboutUs = aboutUs;

  AboutData.fromJson(Map<String, dynamic> json) {
    _termAndCondition = json['term_and_condition'];
    _description = json['description'];
    _aboutUs = json['about_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_and_condition'] = _termAndCondition;
    data['description'] = _description;
    data['about_us'] = _aboutUs;
    return data;
  }
}

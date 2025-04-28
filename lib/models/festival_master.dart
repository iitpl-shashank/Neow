class FestivalMaster {
  List<String>? _data;
  bool? _success;
  String? _message;

  FestivalMaster({List<String>? data, bool? success, String? message}) {
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

  List<String>? get data => _data;
  set data(List<String>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  FestivalMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'].cast<String>();
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = _data;
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

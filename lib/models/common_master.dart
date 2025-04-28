class CommonMaster {
  bool? _success;
  String? _message;
  String? _data;

  CommonMaster({bool? result, String? message}) {
    if (result != null) {
      _success = result;
    }
    if (message != null) {
      _message = message;
    }
  }


  String? get data => _data;

  set data(String? value) {
    _data = value;
  }

  bool? get success => _success;

  set success(bool? success) => _success = success;

  String? get message => _message;

  set message(String? message) => _message = message;



  CommonMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = _success;
    data['message'] = _message;
    data['data'] = _data;
    return data;
  }
}

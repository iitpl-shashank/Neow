class CheckDeviceTokenMaster {
  String? _data;
  bool? _success;
  String? _message;

  CheckDeviceTokenMaster({String? data, bool? success, String? message}) {
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

  String? get data => _data;
  set data(String? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  CheckDeviceTokenMaster.fromJson(Map<String, dynamic> json) {
    _data = (json['data'] ?? json['data '])?.toString();
    final successValue = json['success'] ?? json['success '];
    if (successValue is bool) {
      _success = successValue;
    } else if (successValue is String) {
      _success = successValue == 'true';
    } else if (successValue is num) {
      _success = successValue == 1;
    } else {
      _success = null;
    }
    _message = (json['message'] ?? json['message '])?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = _data;
    data['success'] = _success;
    data['message'] = _message;
    return data;
  }
}

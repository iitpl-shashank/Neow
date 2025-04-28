import 'login_master.dart';

class UserDetailMaster {
  UserMaster? _data;
  bool? _success;
  String? _message;
  bool? _isSessionExpired;

  UserDetailMaster({
    UserMaster? data,
    bool? success,
    String? message,
    bool? isSessionExpired,
  }) {
    if (data != null) {
      _data = data;
    }
    if (success != null) {
      _success = success;
    }
    if (message != null) {
      _message = message;
    }
    if (isSessionExpired != null) {
      _isSessionExpired = isSessionExpired;
    }
  }

  UserMaster? get data => _data;
  set data(UserMaster? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  bool? get isSessionExpired => _isSessionExpired;
  set isSessionExpired(bool? isSessionExpired) =>
      _isSessionExpired = isSessionExpired;
  String? get message => _message;
  set message(String? message) => _message = message;

  UserDetailMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? UserMaster.fromJson(json['data']) : null;
    _success = json['success'];
    _message = json['message'];
    _isSessionExpired = json['isSessionExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    data['success'] = _success;
    data['message'] = _message;
    data['isSessionExpired'] = _isSessionExpired;
    return data;
  }
}

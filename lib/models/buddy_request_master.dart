class BuddyRequestMaster {
  List<BuddyRequestData>? _data;
  bool? _success;
  String? _message;

  BuddyRequestMaster(
      {List<BuddyRequestData>? data, bool? success, String? message}) {
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

  List<BuddyRequestData>? get data => _data;
  set data(List<BuddyRequestData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  BuddyRequestMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <BuddyRequestData>[];
      json['data'].forEach((v) {
        _data!.add(BuddyRequestData.fromJson(v));
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

class BuddyRequestData {
  String? _id;
  String? _name;
  String? _mobile;
  int? _notificationId;
  String? _notificationStatus;

  BuddyRequestData(
      {String? id,
      String? name,
      String? mobile,
      int? notificationId,
      String? notificationStatus}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (mobile != null) {
      _mobile = mobile;
    }
    if (notificationId != null) {
      _notificationId = notificationId;
    }
    if (notificationStatus != null) {
      _notificationStatus = notificationStatus;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;
  int? get notificationId => _notificationId;
  set notificationId(int? notificationId) => _notificationId = notificationId;
  String? get notificationStatus => _notificationStatus;
  set notificationStatus(String? notificationStatus) =>
      _notificationStatus = notificationStatus;

  BuddyRequestData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _notificationId = json['notification_id'];
    _notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['mobile'] = _mobile;
    data['notification_id'] = _notificationId;
    data['notification_status'] = _notificationStatus;
    return data;
  }
}

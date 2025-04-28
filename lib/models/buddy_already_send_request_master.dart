class BuddyAlreadySendRequestMaster {
  List<BuddyAlreadySendRequestData>? _data;
  bool? _success;
  String? _message;

  BuddyAlreadySendRequestMaster(
      {List<BuddyAlreadySendRequestData>? data,
      bool? success,
      String? message}) {
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

  List<BuddyAlreadySendRequestData>? get data => _data;
  set data(List<BuddyAlreadySendRequestData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  BuddyAlreadySendRequestMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <BuddyAlreadySendRequestData>[];
      json['data'].forEach((v) {
        _data!.add(BuddyAlreadySendRequestData.fromJson(v));
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

class BuddyAlreadySendRequestData {
  String? _uniqueId;
  String? _name;
  String? _mobile;
  int? _notificationId;
  String? _notificationStatus;

  BuddyAlreadySendRequestData(
      {String? uniqueId,
      String? name,
      String? mobile,
      int? notificationId,
      String? notificationStatus}) {
    if (uniqueId != null) {
      _uniqueId = uniqueId;
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

  String? get uniqueId => _uniqueId;
  set uniqueId(String? uniqueId) => _uniqueId = uniqueId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;
  int? get notificationId => _notificationId;
  set notificationId(int? notificationId) => _notificationId = notificationId;
  String? get notificationStatus => _notificationStatus;
  set notificationStatus(String? notificationStatus) =>
      _notificationStatus = notificationStatus;

  BuddyAlreadySendRequestData.fromJson(Map<String, dynamic> json) {
    _uniqueId = json['unique_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _notificationId = json['notification_id'];
    _notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = _uniqueId;
    data['name'] = _name;
    data['mobile'] = _mobile;
    data['notification_id'] = _notificationId;
    data['notification_status'] = _notificationStatus;
    return data;
  }
}

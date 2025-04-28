class MonthlyReminderMaster {
  List<MonthlyReminderData>? _data;
  bool? _success;
  String? _message;

  MonthlyReminderMaster(
      {List<MonthlyReminderData>? data, bool? success, String? message}) {
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

  List<MonthlyReminderData>? get data => _data;
  set data(List<MonthlyReminderData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  MonthlyReminderMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <MonthlyReminderData>[];
      json['data'].forEach((v) {
        _data!.add(MonthlyReminderData.fromJson(v));
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

class MonthlyReminderData {
  int? _id;
  int? _userId;
  String? _reminderDate;
  String? _reminderMonth;
  String? _reminderTime;
  String? _reminderType;
  String? _reminderFor;
  String? _createdAt;
  String? _updatedAt;

  MonthlyReminderData(
      {int? id,
      int? userId,
      String? reminderDate,
      String? reminderMonth,
      String? reminderTime,
      String? reminderType,
      String? reminderFor,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (reminderDate != null) {
      _reminderDate = reminderDate;
    }
    if (reminderMonth != null) {
      _reminderMonth = reminderMonth;
    }
    if (reminderTime != null) {
      _reminderTime = reminderTime;
    }
    if (reminderType != null) {
      _reminderType = reminderType;
    }
    if (reminderFor != null) {
      _reminderFor = reminderFor;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get reminderDate => _reminderDate;
  set reminderDate(String? reminderDate) => _reminderDate = reminderDate;
  String? get reminderMonth => _reminderMonth;
  set reminderMonth(String? reminderMonth) => _reminderMonth = reminderMonth;
  String? get reminderTime => _reminderTime;
  set reminderTime(String? reminderTime) => _reminderTime = reminderTime;
  String? get reminderType => _reminderType;
  set reminderType(String? reminderType) => _reminderType = reminderType;
  String? get reminderFor => _reminderFor;
  set reminderFor(String? reminderFor) => _reminderFor = reminderFor;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  MonthlyReminderData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _reminderDate = json['reminder_date'];
    _reminderMonth = json['reminder_month'];
    _reminderTime = json['reminder_time'];
    _reminderType = json['reminder_type'];
    _reminderFor = json['reminder_for'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['reminder_date'] = _reminderDate;
    data['reminder_month'] = _reminderMonth;
    data['reminder_time'] = _reminderTime;
    data['reminder_type'] = _reminderType;
    data['reminder_for'] = _reminderFor;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

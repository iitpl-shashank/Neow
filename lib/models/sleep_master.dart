class SleepMaster {
  SleepData? _data;
  bool? _success;
  String? _message;

  SleepMaster({SleepData? data, bool? success, String? message}) {
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

  SleepData? get data => _data;
  set data(SleepData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  SleepMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? SleepData.fromJson(json['data']) : null;
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

class SleepData {
  int? _badTimeHours;
  int? _badTimeMinutes;
  int? _wakeupTimeHours;
  int? _wakeupTimeMinutes;
  String? _totalSleepTime;
  String? _averageTotalSleepTime;

  SleepData(
      {int? badTimeHours,
      int? badTimeMinutes,
      int? wakeupTimeHours,
      int? wakeupTimeMinutes,
      String? totalSleepTime,
      String? averageTotalSleepTime}) {
    if (badTimeHours != null) {
      _badTimeHours = badTimeHours;
    }
    if (badTimeMinutes != null) {
      _badTimeMinutes = badTimeMinutes;
    }
    if (wakeupTimeHours != null) {
      _wakeupTimeHours = wakeupTimeHours;
    }
    if (wakeupTimeMinutes != null) {
      _wakeupTimeMinutes = wakeupTimeMinutes;
    }
    if (totalSleepTime != null) {
      _totalSleepTime = totalSleepTime;
    }
    if (averageTotalSleepTime != null) {
      _averageTotalSleepTime = averageTotalSleepTime;
    }
  }

  int? get badTimeHours => _badTimeHours;
  set badTimeHours(int? badTimeHours) => _badTimeHours = badTimeHours;
  int? get badTimeMinutes => _badTimeMinutes;
  set badTimeMinutes(int? badTimeMinutes) => _badTimeMinutes = badTimeMinutes;
  int? get wakeupTimeHours => _wakeupTimeHours;
  set wakeupTimeHours(int? wakeupTimeHours) =>
      _wakeupTimeHours = wakeupTimeHours;
  int? get wakeupTimeMinutes => _wakeupTimeMinutes;
  set wakeupTimeMinutes(int? wakeupTimeMinutes) =>
      _wakeupTimeMinutes = wakeupTimeMinutes;
  String? get totalSleepTime => _totalSleepTime;
  set totalSleepTime(String? totalSleepTime) =>
      _totalSleepTime = totalSleepTime;
  String? get averageTotalSleepTime => _averageTotalSleepTime;
  set averageTotalSleepTime(String? averageTotalSleepTime) =>
      _averageTotalSleepTime = averageTotalSleepTime;

  SleepData.fromJson(Map<String, dynamic> json) {
    _badTimeHours = json['bad_time_hours'];
    _badTimeMinutes = json['bad_time_minutes'];
    _wakeupTimeHours = json['wakeup_time_hours'];
    _wakeupTimeMinutes = json['wakeup_time_minutes'];
    _totalSleepTime = json['total_sleep_time'];
    _averageTotalSleepTime = json['average_total_sleep_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bad_time_hours'] = _badTimeHours;
    data['bad_time_minutes'] = _badTimeMinutes;
    data['wakeup_time_hours'] = _wakeupTimeHours;
    data['wakeup_time_minutes'] = _wakeupTimeMinutes;
    data['total_sleep_time'] = _totalSleepTime;
    data['average_total_sleep_time'] = _averageTotalSleepTime;
    return data;
  }
}

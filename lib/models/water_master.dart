class WaterMaster {
  WaterData? _data;
  bool? _success;
  String? _message;

  WaterMaster({WaterData? data, bool? success, String? message}) {
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

  WaterData? get data => _data;
  set data(WaterData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  WaterMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? WaterData.fromJson(json['data']) : null;
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

class WaterData {
  String? _waterMl;

  WaterData({String? waterMl}) {
    if (waterMl != null) {
      _waterMl = waterMl;
    }
  }

  String? get waterMl => _waterMl;
  set waterMl(String? waterMl) => _waterMl = waterMl;

  WaterData.fromJson(Map<String, dynamic> json) {
    _waterMl = json['water_ml'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['water_ml'] = _waterMl;
    return data;
  }
}

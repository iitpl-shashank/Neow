class LikedPostMaster {
  List<Data>? _data;
  bool? _success;
  String? _message;

  LikedPostMaster({List<Data>? data, bool? success, String? message}) {
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

  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  LikedPostMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
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

class Data {
  int? _userId;
  int? _healthMixId;
  int? _isLike;

  Data({int? userId, int? healthMixId, int? isLike}) {
    if (userId != null) {
      _userId = userId;
    }
    if (healthMixId != null) {
      _healthMixId = healthMixId;
    }
    if (isLike != null) {
      _isLike = isLike;
    }
  }

  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  int? get healthMixId => _healthMixId;
  set healthMixId(int? healthMixId) => _healthMixId = healthMixId;
  int? get isLike => _isLike;
  set isLike(int? isLike) => _isLike = isLike;

  Data.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _healthMixId = json['health_mix_id'];
    _isLike = json['is_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = _userId;
    data['health_mix_id'] = _healthMixId;
    data['is_like'] = _isLike;
    return data;
  }
}

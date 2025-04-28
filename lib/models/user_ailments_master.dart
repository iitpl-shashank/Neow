class UserAilmentsMaster {
  Data? _data;
  bool? _success;
  String? _message;

  UserAilmentsMaster({Data? data, bool? success, String? message}) {
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

  Data? get data => _data;
  set data(Data? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  UserAilmentsMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? _id;
  int? _userId;
  List<AilmentId>? _ailmentId;
  List<String>? _otherAilments;
  String? _createdAt;
  String? _updatedAt;

  Data(
      {int? id,
        int? userId,
        List<AilmentId>? ailmentId,
        List<String>? otherAilments,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (ailmentId != null) {
      _ailmentId = ailmentId;
    }
    if (otherAilments != null) {
      _otherAilments = otherAilments;
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
  List<AilmentId>? get ailmentId => _ailmentId;
  set ailmentId(List<AilmentId>? ailmentId) => _ailmentId = ailmentId;
  List<String>? get otherAilments => _otherAilments;
  set otherAilments(List<String>? otherAilments) =>
      _otherAilments = otherAilments;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    if (json['ailment_id'] != null) {
      _ailmentId = <AilmentId>[];
      json['ailment_id'].forEach((v) {
        _ailmentId!.add(AilmentId.fromJson(v));
      });
    }
    _otherAilments = json['other_ailments'].cast<String>();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    if (_ailmentId != null) {
      data['ailment_id'] = _ailmentId!.map((v) => v.toJson()).toList();
    }
    data['other_ailments'] = _otherAilments;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class AilmentId {
  int? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  AilmentId({int? id, String? name, String? createdAt, String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  AilmentId.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

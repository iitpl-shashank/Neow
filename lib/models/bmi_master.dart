class BmiMaster {
  BmiData? _data;
  bool? _success;
  String? _message;

  BmiMaster({BmiData? data, bool? success, String? message}) {
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

  BmiData? get data => _data;
  set data(BmiData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  BmiMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? BmiData.fromJson(json['data']) : null;
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

class BmiData {
  int? _id;
  int? _userId;
  int? _age;
  String? _height;
  String? _weight;
  String? _bmiScore;
  String? _bmiType;
  String? _createdAt;
  String? _updatedAt;

  BmiData(
      {int? id,
      int? userId,
      int? age,
      String? height,
      String? weight,
      String? bmiScore,
      String? bmiType,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (age != null) {
      _age = age;
    }
    if (height != null) {
      _height = height;
    }
    if (weight != null) {
      _weight = weight;
    }
    if (bmiScore != null) {
      _bmiScore = bmiScore;
    }
    if (bmiType != null) {
      _bmiType = bmiType;
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
  int? get age => _age;
  set age(int? age) => _age = age;
  String? get height => _height;
  set height(String? height) => _height = height;
  String? get weight => _weight;
  set weight(String? weight) => _weight = weight;
  String? get bmiScore => _bmiScore;
  set bmiScore(String? bmiScore) => _bmiScore = bmiScore;
  String? get bmiType => _bmiType;
  set bmiType(String? bmiType) => _bmiType = bmiType;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  BmiData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _age = json['age'];
    _height = json['height'];
    _weight = json['weight'];
    _bmiScore = json['bmi_score'];
    _bmiType = json['bmi_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['age'] = _age;
    data['height'] = _height;
    data['weight'] = _weight;
    data['bmi_score'] = _bmiScore;
    data['bmi_type'] = _bmiType;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

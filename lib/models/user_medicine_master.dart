class UserMedicineMaster {
  Data? _data;
  bool? _success;
  String? _message;

  UserMedicineMaster({Data? data, bool? success, String? message}) {
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

  UserMedicineMaster.fromJson(Map<String, dynamic> json) {
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
  List<MedicineId>? _medicineId;
  List<OtherMedicine>? _otherMedicine;
  String? _aid;
  String? _createdAt;
  String? _updatedAt;

  Data(
      {int? id,
      int? userId,
      List<MedicineId>? medicineId,
      List<OtherMedicine>? otherMedicine,
      String? aid,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (medicineId != null) {
      _medicineId = medicineId;
    }
    if (otherMedicine != null) {
      _otherMedicine = otherMedicine;
    }
    if (aid != null) {
      _aid = aid;
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
  List<MedicineId>? get medicineId => _medicineId;
  set medicineId(List<MedicineId>? medicineId) => _medicineId = medicineId;
  List<OtherMedicine>? get otherMedicine => _otherMedicine;
  set otherMedicine(List<OtherMedicine>? otherMedicine) =>
      _otherMedicine = otherMedicine;
  String? get aid => _aid;
  set aid(String? aid) => _aid = aid;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    if (json['medicine_id'] != null) {
      _medicineId = <MedicineId>[];
      json['medicine_id'].forEach((v) {
        _medicineId!.add(MedicineId.fromJson(v));
      });
    }
    if (json['other_medicine'] != null) {
      _otherMedicine = <OtherMedicine>[];
      // print(json['other_medi'])
      json['other_medicine'].forEach((v) {
        _otherMedicine!.add(OtherMedicine.fromJson(v));
      });
    }
    // _otherMedicine = json['other_medicine'].cast<OtherMedicine>();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    if (_medicineId != null) {
      data['medicine_id'] = _medicineId!.map((v) => v.toJson()).toList();
    }
    data['other_medicine'] = _otherMedicine;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

class OtherMedicine {
  String? _id;
  String? _name;
  String? _amt;
  String? _frequency;
  String? _months;
  String? _days;
  String? _date;

  OtherMedicine(
      {String? id,
      String? name,
      String? amt,
      String? frequency,
      String? months,
      String? days,
      String? date}) {
    if (id != null) {
      _id = id;
    }
    if (amt != null) {
      _amt = amt;
    }
    if (name != null) {
      _name = name;
    }
    if (frequency != null) {
      _frequency = frequency;
    }
    if (months != null) {
      _months = months;
    }
    if (days != null) {
      _days = days;
    }

    if (date != null) {
      _date = date;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get amt => _amt;
  set amt(String? amt) => _amt = amt;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get frequency => _frequency;
  set frequency(String? frequency) => _frequency = frequency;
  String? get months => _months;
  set months(String? months) => _months = months;
  String? get days => _days;
  set days(String? days) => _days = days;

  String? get date => _date;
  set date(String? date) => _date = date;

  OtherMedicine.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _amt = json['amt'];
    _name = json['name'];
    _frequency = json['frequency'];
    _months = json['months'];
    _days = json['days'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['amt'] = _amt;
    data['name'] = _name;
    data['frequency'] = _frequency;
    data['months'] = _months;
    data['days'] = _days;
    data['date'] = _date;
    return data;
  }
}

class MedicineId {
  int? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  MedicineId({int? id, String? name, String? createdAt, String? updatedAt}) {
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

  MedicineId.fromJson(Map<String, dynamic> json) {
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

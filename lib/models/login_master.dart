class LoginMaster {
  Data? _data;
  bool? _success;
  String? _message;

  LoginMaster({Data? data, bool? success, String? message}) {
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

  LoginMaster.fromJson(Map<String, dynamic> json) {
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
  UserMaster? _user;
  String? _token;

  Data({UserMaster? user, String? token}) {
    if (user != null) {
      _user = user;
    }
    if (token != null) {
      _token = token;
    }
  }

  UserMaster? get user => _user;

  set user(UserMaster? user) => _user = user;

  String? get token => _token;

  set token(String? token) => _token = token;

  Data.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? UserMaster.fromJson(json['user']) : null;
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    data['token'] = _token;
    return data;
  }
}

class UserMaster {
  int? _id;
  String? _name;
  String? _email;
  int? _roleId;
  String? _uuId;
  String? _birthdate;
  int? _age;
  String? _height;
  String? _weight;
  String? _bmiScore;
  String? _bmiType;
  String? _badTime;
  String? _wakeUpTime;
  String? _totalSleepTime;
  String? _waterMl;
  String? _gender;
  String? _genderType;
  String? _mobile;
  String? _deviceToken;
  String? _image;
  String? _relationshipStatus;
  String? _averageCycleLength;
  String? _previousPeriodsBegin;
  String? _previousPeriodsMonth;
  String? _averagePeriodLength;
  String? _humApkeHeKon;
  int? _status;
  String? _state;

  String? _city;

  UserMaster({
    int? id,
    String? name,
    String? email,
    int? roleId,
    String? uuId,
    String? birthdate,
    int? age,
    String? height,
    String? weight,
    String? bmiScore,
    String? bmiType,
    String? badTime,
    String? wakeUpTime,
    String? totalSleepTime,
    String? waterMl,
    String? gender,
    String? genderType,
    String? mobile,
    String? deviceToken,
    String? image,
    String? relationshipStatus,
    String? averageCycleLength,
    String? previousPeriodsBegin,
    String? previousPeriodsMonth,
    String? averagePeriodLength,
    String? humApkeHeKon,
    int? status,
    String? state,
    String? city,
  }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (roleId != null) {
      _roleId = roleId;
    }
    if (uuId != null) {
      _uuId = uuId;
    }
    if (birthdate != null) {
      _birthdate = birthdate;
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
    if (badTime != null) {
      _badTime = badTime;
    }
    if (wakeUpTime != null) {
      _wakeUpTime = wakeUpTime;
    }
    if (totalSleepTime != null) {
      _totalSleepTime = totalSleepTime;
    }
    if (waterMl != null) {
      _waterMl = waterMl;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (genderType != null) {
      _genderType = genderType;
    }
    if (mobile != null) {
      _mobile = mobile;
    }
    if (deviceToken != null) {
      _deviceToken = deviceToken;
    }
    if (image != null) {
      _image = image;
    }
    if (relationshipStatus != null) {
      _relationshipStatus = relationshipStatus;
    }
    if (averageCycleLength != null) {
      _averageCycleLength = averageCycleLength;
    }
    if (previousPeriodsBegin != null) {
      _previousPeriodsBegin = previousPeriodsBegin;
    }
    if (previousPeriodsMonth != null) {
      _previousPeriodsMonth = previousPeriodsMonth;
    }
    if (averagePeriodLength != null) {
      _averagePeriodLength = averagePeriodLength;
    }
    if (humApkeHeKon != null) {
      _humApkeHeKon = humApkeHeKon;
    }
    if (status != null) {
      _status = status;
    }

    if (state != null) {
      _state = state;
    }
    if (city != null) {
      _city = city;
    }
  }

  int? get id => _id;

  set id(int? id) => _id = id;

  String? get name => _name;

  set name(String? name) => _name = name;

  String? get email => _email;

  set email(String? email) => _email = email;

  int? get roleId => _roleId;

  set roleId(int? roleId) => _roleId = roleId;

  String? get uuId => _uuId;

  set uuId(String? uuId) => _uuId = uuId;

  String? get birthdate => _birthdate;

  set birthdate(String? birthdate) => _birthdate = birthdate;

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

  String? get badTime => _badTime;

  set badTime(String? badTime) => _badTime = badTime;

  String? get wakeUpTime => _wakeUpTime;

  set wakeUpTime(String? wakeUpTime) => _wakeUpTime = wakeUpTime;

  String? get totalSleepTime => _totalSleepTime;

  set totalSleepTime(String? totalSleepTime) =>
      _totalSleepTime = totalSleepTime;

  String? get waterMl => _waterMl;

  set waterMl(String? waterMl) => _waterMl = waterMl;

  String? get gender => _gender;

  set gender(String? gender) => _gender = gender;

  String? get genderType => _genderType;

  set genderType(String? genderType) => _genderType = genderType;

  String? get mobile => _mobile;

  set mobile(String? mobile) => _mobile = mobile;

  String? get deviceToken => _deviceToken;

  set deviceToken(String? deviceToken) => _deviceToken = deviceToken;

  String? get image => _image;

  set image(String? image) => _image = image;

  String? get relationshipStatus => _relationshipStatus;

  set relationshipStatus(String? relationshipStatus) =>
      _relationshipStatus = relationshipStatus;

  String? get averageCycleLength => _averageCycleLength;

  set averageCycleLength(String? averageCycleLength) =>
      _averageCycleLength = averageCycleLength;

  String? get previousPeriodsBegin => _previousPeriodsBegin;

  set previousPeriodsBegin(String? previousPeriodsBegin) =>
      _previousPeriodsBegin = previousPeriodsBegin;

  String? get previousPeriodsMonth => _previousPeriodsMonth;

  set previousPeriodsMonth(String? previousPeriodsMonth) =>
      _previousPeriodsMonth = previousPeriodsMonth;

  String? get averagePeriodLength => _averagePeriodLength;

  set averagePeriodLength(String? averagePeriodLength) =>
      _averagePeriodLength = averagePeriodLength;

  String? get humApkeHeKon => _humApkeHeKon;

  set humApkeHeKon(String? humApkeHeKon) => _humApkeHeKon = humApkeHeKon;

  int? get status => _status;

  set status(int? status) => _status = status;

  String? get state => _state;

  set state(String? state) => _state = state;

  String? get city => _city;

  set city(String? state) => _city = city;

  UserMaster.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int?;
    _name = json['name'] as String?;
    _email = json['email'] as String?;
    _roleId = json['role_id'] as int?;
    _uuId = json['uuId'] as String?;
    _birthdate = json['birthdate'] as String?;
    _age = json['age'] as int?;
    _height =
        json['height']?.toString(); // Convert to string to avoid type mismatch
    _weight =
        json['weight']?.toString(); // Convert to string to avoid type mismatch
    _bmiScore = json['bmi_score']
        ?.toString(); // Convert to string to avoid type mismatch
    _bmiType = json['bmi_type'] as String?;
    _badTime = json['bad_time'] as String?;
    _wakeUpTime = json['wake_up_time'] as String?;
    _totalSleepTime = json['total_sleep_time'] as String?;
    _waterMl = json['water_ml'] as String?;
    _gender = json['gender'] as String?;
    _genderType = json['gender_type'] as String?;
    _mobile = json['mobile'] as String?;
    _deviceToken = json['device_token'] as String?;
    _image = json['image'] as String?;
    _relationshipStatus = json['relationship_status'] as String?;
    _averageCycleLength = json['average_cycle_length'] as String?;
    _previousPeriodsBegin = json['previous_periods_begin'] as String?;
    _previousPeriodsMonth = json['previous_periods_month'] as String?;
    _averagePeriodLength = json['average_period_length'] as String?;
    _humApkeHeKon = json['hum_apke_he_kon'] as String?;
    _status = json['status'] as int?;
    _state = json['state'] as String?;
    _city = json['city'] as String?;

    // Convert weight, height, and bmiScore to double if they're not null
    if (_weight != null) {
      _weight = double.parse(_weight!)
          .toString(); // Parsing as double then converting to string
    }
    if (_height != null) {
      _height = double.parse(_height!)
          .toString(); // Parsing as double then converting to string
    }
    if (_bmiScore != null) {
      _bmiScore = double.parse(_bmiScore!)
          .toString(); // Parsing as double then converting to string
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['email'] = _email;
    data['role_id'] = _roleId;
    data['uuId'] = _uuId;
    data['birthdate'] = _birthdate;
    data['age'] = _age;
    data['height'] = _height;
    data['weight'] = _weight;
    data['bmi_score'] = _bmiScore;
    data['bmi_type'] = _bmiType;
    data['bad_time'] = _badTime;
    data['wake_up_time'] = _wakeUpTime;
    data['total_sleep_time'] = _totalSleepTime;
    data['water_ml'] = _waterMl;
    data['gender'] = _gender;
    data['gender_type'] = _genderType;
    data['mobile'] = _mobile;
    data['device_token'] = _deviceToken;
    data['image'] = _image;
    data['relationship_status'] = _relationshipStatus;
    data['average_cycle_length'] = _averageCycleLength;
    data['previous_periods_begin'] = _previousPeriodsBegin;
    data['previous_periods_month'] = _previousPeriodsMonth;
    data['average_period_length'] = _averagePeriodLength;
    data['hum_apke_he_kon'] = _humApkeHeKon;
    data['status'] = _status;
    data['state'] = _state;
    data['city'] = _city;
    return data;
  }
}

class SignupMaster {
  Data? _data;
  bool? _success;
  String? _message;

  SignupMaster({Data? data, bool? success, String? message}) {
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

  SignupMaster.fromJson(Map<String, dynamic> json) {
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
  User? _user;
  String? _token;

  Data({User? user, String? token}) {
    if (user != null) {
      _user = user;
    }
    if (token != null) {
      _token = token;
    }
  }

  User? get user => _user;
  set user(User? user) => _user = user;
  String? get token => _token;
  set token(String? token) => _token = token;

  Data.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
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

class User {
  String? _name;
  String? _email;
  String? _roleId;
  String? _birthdate;
  String? _gender;
  String? _mobile;
  String? _deviceToken;
  String? _image;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  User(
      {String? name,
        String? email,
        String? roleId,
        String? birthdate,
        String? gender,
        String? mobile,
        String? deviceToken,
        String? image,
        String? updatedAt,
        String? createdAt,
        int? id}) {
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (roleId != null) {
      _roleId = roleId;
    }
    if (birthdate != null) {
      _birthdate = birthdate;
    }
    if (gender != null) {
      _gender = gender;
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
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (id != null) {
      _id = id;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get roleId => _roleId;
  set roleId(String? roleId) => _roleId = roleId;
  String? get birthdate => _birthdate;
  set birthdate(String? birthdate) => _birthdate = birthdate;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get mobile => _mobile;
  set mobile(String? mobile) => _mobile = mobile;
  String? get deviceToken => _deviceToken;
  set deviceToken(String? deviceToken) => _deviceToken = deviceToken;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  int? get id => _id;
  set id(int? id) => _id = id;

  User.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _roleId = json['role_id'];
    _birthdate = json['birthdate'];
    _gender = json['gender'];
    _mobile = json['mobile'];
    _deviceToken = json['device_token'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['email'] = _email;
    data['role_id'] = _roleId;
    data['birthdate'] = _birthdate;
    data['gender'] = _gender;
    data['mobile'] = _mobile;
    data['device_token'] = _deviceToken;
    data['image'] = _image;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    data['id'] = _id;
    return data;
  }
}

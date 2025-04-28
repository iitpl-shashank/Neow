class ReflectionMaster {
  List<ReflectionData>? _data;
  bool? _success;
  String? _message;

  ReflectionMaster(
      {List<ReflectionData>? data, bool? success, String? message}) {
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

  List<ReflectionData>? get data => _data;
  set data(List<ReflectionData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  ReflectionMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <ReflectionData>[];
      json['data'].forEach((v) {
        _data!.add(ReflectionData.fromJson(v));
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

class ReflectionData {
  int? _id;
  int? _userId;
  String? _mood;
  String? _music;
  String? _learning;
  String? _cleaning;
  String? _bodyCare;
  String? _gratitude;
  String? _hangOut;
  String? _sleep;
  String? _workOut;
  String? _screenTime;
  String? _food;
  String? _edit;
  String? _isEdit;
  String? _createdAt;
  int? _isGratitudeComplete;
  int? _isEditComplete;

  ReflectionData(
      {int? id,
      int? userId,
      String? mood,
      String? music,
      String? learning,
      String? cleaning,
      String? bodyCare,
      String? gratitude,
      String? hangOut,
      String? sleep,
      String? workOut,
      String? screenTime,
      String? food,
      String? edit,
      String? isEdit,
      String? createdAt,
      int? isGratitudeComplete,
      int? isEditComplete}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (mood != null) {
      _mood = mood;
    }
    if (music != null) {
      _music = music;
    }
    if (learning != null) {
      _learning = learning;
    }
    if (cleaning != null) {
      _cleaning = cleaning;
    }
    if (bodyCare != null) {
      _bodyCare = bodyCare;
    }
    if (gratitude != null) {
      _gratitude = gratitude;
    }
    if (hangOut != null) {
      _hangOut = hangOut;
    }
    if (sleep != null) {
      _sleep = sleep;
    }
    if (workOut != null) {
      _workOut = workOut;
    }
    if (screenTime != null) {
      _screenTime = screenTime;
    }
    if (food != null) {
      _food = food;
    }
    if (edit != null) {
      _edit = edit;
    }
    if (isEdit != null) {
      _isEdit = isEdit;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (isGratitudeComplete != null) {
      _isGratitudeComplete = isGratitudeComplete;
    }
    if (isEditComplete != null) {
      _isEditComplete = isEditComplete;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  String? get mood => _mood;
  set mood(String? mood) => _mood = mood;
  String? get music => _music;
  set music(String? music) => _music = music;
  String? get learning => _learning;
  set learning(String? learning) => _learning = learning;
  String? get cleaning => _cleaning;
  set cleaning(String? cleaning) => _cleaning = cleaning;
  String? get bodyCare => _bodyCare;
  set bodyCare(String? bodyCare) => _bodyCare = bodyCare;
  String? get gratitude => _gratitude;
  set gratitude(String? gratitude) => _gratitude = gratitude;
  String? get hangOut => _hangOut;
  set hangOut(String? hangOut) => _hangOut = hangOut;
  String? get sleep => _sleep;
  set sleep(String? sleep) => _sleep = sleep;
  String? get workOut => _workOut;
  set workOut(String? workOut) => _workOut = workOut;
  String? get screenTime => _screenTime;
  set screenTime(String? screenTime) => _screenTime = screenTime;
  String? get food => _food;
  set food(String? food) => _food = food;
  String? get edit => _edit;
  set edit(String? edit) => _edit = edit;
  String? get isEdit => _isEdit;
  set isEdit(String? isEdit) => _isEdit = isEdit;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  int? get isGratitudeComplete => _isGratitudeComplete;
  set isGratitudeComplete(int? isGratitudeComplete) =>
      _isGratitudeComplete = isGratitudeComplete;
  int? get isEditComplete => _isEditComplete;
  set isEditComplete(int? isEditComplete) => _isEditComplete = isEditComplete;

  ReflectionData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _mood = json['mood'];
    _music = json['music'];
    _learning = json['learning'];
    _cleaning = json['cleaning'];
    _bodyCare = json['body_care'];
    _gratitude = json['gratitude'];
    _hangOut = json['hang_out'];
    _sleep = json['sleep'];
    _workOut = json['work_out'];
    _screenTime = json['screen_time'];
    _food = json['food'];
    _edit = json['edit'];
    _isEdit = json['is_edit'];
    _createdAt = json['created_at'];
    _isGratitudeComplete = json['isGratitudeComplete'];
    _isEditComplete = json['isEditComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['mood'] = _mood;
    data['music'] = _music;
    data['learning'] = _learning;
    data['cleaning'] = _cleaning;
    data['body_care'] = _bodyCare;
    data['gratitude'] = _gratitude;
    data['hang_out'] = _hangOut;
    data['sleep'] = _sleep;
    data['work_out'] = _workOut;
    data['screen_time'] = _screenTime;
    data['food'] = _food;
    data['edit'] = _edit;
    data['is_edit'] = _isEdit;
    data['created_at'] = _createdAt;
    data['isGratitudeComplete'] = _isGratitudeComplete;
    data['isEditComplete'] = _isEditComplete;
    return data;
  }
}

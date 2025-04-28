class MonthlyMissionMaster {
  MonthlyMissionData? _data;
  bool? _success;
  String? _message;

  MonthlyMissionMaster(
      {MonthlyMissionData? data, bool? success, String? message}) {
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

  MonthlyMissionData? get data => _data;
  set data(MonthlyMissionData? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  MonthlyMissionMaster.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null
        ? MonthlyMissionData.fromJson(json['data'])
        : null;
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

class MonthlyMissionData {
  int? _id;
  int? _userId;
  List<String>? _mainFocusOfMonth;
  List<keyData>? _goals;
  List<keyData>? _hobbies;
  List<keyData>? _habitsToCut;
  List<keyData>? _habitsToAdopt;
  List<keyData>? _newThingsToTry;
  List<keyData>? _familyGoals;
  List<keyData>? _booksToRead;
  List<keyData>? _moviesToWatch;
  List<keyData>? _placesToVisit;
  String? _makeWish;

  MonthlyMissionData(
      {int? id,
      int? userId,
      List<String>? mainFocusOfMonth,
      List<keyData>? goals,
      List<keyData>? hobbies,
      List<keyData>? habitsToCut,
      List<keyData>? habitsToAdopt,
      List<keyData>? newThingsToTry,
      List<keyData>? familyGoals,
      List<keyData>? booksToRead,
      List<keyData>? moviesToWatch,
      List<keyData>? placesToVisit,
      String? makeWish}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (mainFocusOfMonth != null) {
      _mainFocusOfMonth = mainFocusOfMonth;
    }
    if (goals != null) {
      _goals = goals;
    }
    if (hobbies != null) {
      _hobbies = hobbies;
    }
    if (habitsToCut != null) {
      _habitsToCut = habitsToCut;
    }
    if (habitsToAdopt != null) {
      _habitsToAdopt = habitsToAdopt;
    }
    if (newThingsToTry != null) {
      _newThingsToTry = newThingsToTry;
    }
    if (familyGoals != null) {
      _familyGoals = familyGoals;
    }
    if (booksToRead != null) {
      _booksToRead = booksToRead;
    }
    if (moviesToWatch != null) {
      _moviesToWatch = moviesToWatch;
    }
    if (placesToVisit != null) {
      _placesToVisit = placesToVisit;
    }
    if (makeWish != null) {
      _makeWish = makeWish;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  int? get userId => _userId;
  set userId(int? userId) => _userId = userId;
  List<String>? get mainFocusOfMonth => _mainFocusOfMonth;
  set mainFocusOfMonth(List<String>? mainFocusOfMonth) =>
      _mainFocusOfMonth = mainFocusOfMonth;
  List<keyData>? get goals => _goals;
  set goals(List<keyData>? goals) => _goals = goals;
  List<keyData>? get hobbies => _hobbies;
  set hobbies(List<keyData>? hobbies) => _hobbies = hobbies;
  List<keyData>? get habitsToCut => _habitsToCut;
  set habitsToCut(List<keyData>? habitsToCut) => _habitsToCut = habitsToCut;
  List<keyData>? get habitsToAdopt => _habitsToAdopt;
  set habitsToAdopt(List<keyData>? habitsToAdopt) =>
      _habitsToAdopt = habitsToAdopt;
  List<keyData>? get newThingsToTry => _newThingsToTry;
  set newThingsToTry(List<keyData>? newThingsToTry) =>
      _newThingsToTry = newThingsToTry;
  List<keyData>? get familyGoals => _familyGoals;
  set familyGoals(List<keyData>? familyGoals) => _familyGoals = familyGoals;
  List<keyData>? get booksToRead => _booksToRead;
  set booksToRead(List<keyData>? booksToRead) => _booksToRead = booksToRead;
  List<keyData>? get moviesToWatch => _moviesToWatch;
  set moviesToWatch(List<keyData>? moviesToWatch) =>
      _moviesToWatch = moviesToWatch;
  List<keyData>? get placesToVisit => _placesToVisit;
  set placesToVisit(List<keyData>? placesToVisit) =>
      _placesToVisit = placesToVisit;
  String? get makeWish => _makeWish;
  set makeWish(String? makeWish) => _makeWish = makeWish;

  MonthlyMissionData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _mainFocusOfMonth = json['main_focus_of_month'].cast<String>();
    if (json['goals'] != null) {
      _goals = <keyData>[];
      json['goals'].forEach((v) {
        _goals!.add(keyData.fromJson(v));
      });
    }
    if (json['hobbies'] != null) {
      _hobbies = <keyData>[];
      json['hobbies'].forEach((v) {
        _hobbies!.add(keyData.fromJson(v));
      });
    }
    if (json['habits_to_cut'] != null) {
      _habitsToCut = <keyData>[];
      json['habits_to_cut'].forEach((v) {
        _habitsToCut!.add(keyData.fromJson(v));
      });
    }
    if (json['habits_to_adopt'] != null) {
      _habitsToAdopt = <keyData>[];
      json['habits_to_adopt'].forEach((v) {
        _habitsToAdopt!.add(keyData.fromJson(v));
      });
    }
    if (json['new_things_to_try'] != null) {
      _newThingsToTry = <keyData>[];
      json['new_things_to_try'].forEach((v) {
        _newThingsToTry!.add(keyData.fromJson(v));
      });
    }
    if (json['family_goals'] != null) {
      _familyGoals = <keyData>[];
      json['family_goals'].forEach((v) {
        _familyGoals!.add(keyData.fromJson(v));
      });
    }
    if (json['books_to_read'] != null) {
      _booksToRead = <keyData>[];
      json['books_to_read'].forEach((v) {
        _booksToRead!.add(keyData.fromJson(v));
      });
    }
    if (json['movies_to_watch'] != null) {
      _moviesToWatch = <keyData>[];
      json['movies_to_watch'].forEach((v) {
        _moviesToWatch!.add(keyData.fromJson(v));
      });
    }
    if (json['places_to_visit'] != null) {
      _placesToVisit = <keyData>[];
      json['places_to_visit'].forEach((v) {
        _placesToVisit!.add(keyData.fromJson(v));
      });
    }
    _makeWish = json['make_wish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['main_focus_of_month'] = _mainFocusOfMonth;
    if (_goals != null) {
      data['goals'] = _goals!.map((v) => v.toJson()).toList();
    }
    if (_hobbies != null) {
      data['hobbies'] = _hobbies!.map((v) => v.toJson()).toList();
    }
    if (_habitsToCut != null) {
      data['habits_to_cut'] =
          _habitsToCut!.map((v) => v.toJson()).toList();
    }
    if (_habitsToAdopt != null) {
      data['habits_to_adopt'] =
          _habitsToAdopt!.map((v) => v.toJson()).toList();
    }
    if (_newThingsToTry != null) {
      data['new_things_to_try'] =
          _newThingsToTry!.map((v) => v.toJson()).toList();
    }
    if (_familyGoals != null) {
      data['family_goals'] = _familyGoals!.map((v) => v.toJson()).toList();
    }
    if (_booksToRead != null) {
      data['books_to_read'] =
          _booksToRead!.map((v) => v.toJson()).toList();
    }
    if (_moviesToWatch != null) {
      data['movies_to_watch'] =
          _moviesToWatch!.map((v) => v.toJson()).toList();
    }
    if (_placesToVisit != null) {
      data['places_to_visit'] =
          _placesToVisit!.map((v) => v.toJson()).toList();
    }
    data['make_wish'] = _makeWish;
    return data;
  }
}

class keyData {
  bool? _status;
  String? _value;

  keyData({bool? status, String? value}) {
    if (status != null) {
      _status = status;
    }
    if (value != null) {
      _value = value;
    }
  }

  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get value => _value;
  set value(String? value) => _value = value;

  keyData.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['value'] = _value;
    return data;
  }
}

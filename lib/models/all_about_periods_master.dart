class AllAboutPeriodsMaster {
  List<AllAboutData>? _data;
  bool? _success;
  String? _message;

  AllAboutPeriodsMaster({List<AllAboutData>? data, bool? success, String? message}) {
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

  List<AllAboutData>? get data => _data;
  set data(List<AllAboutData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  AllAboutPeriodsMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <AllAboutData>[];
      json['data'].forEach((v) {
        _data!.add(AllAboutData.fromJson(v));
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

class AllAboutData {
  int? _id;
  String? _categoryName;
  String? _categoryIcon;

  AllAboutData({int? id, String? categoryName, String? categoryIcon}) {
    if (id != null) {
      _id = id;
    }
    if (categoryName != null) {
      _categoryName = categoryName;
    }
    if (categoryIcon != null) {
      _categoryIcon = categoryIcon;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get categoryName => _categoryName;
  set categoryName(String? categoryName) => _categoryName = categoryName;
  String? get categoryIcon => _categoryIcon;
  set categoryIcon(String? categoryIcon) => _categoryIcon = categoryIcon;

  AllAboutData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    _categoryIcon = json['category_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['category_name'] = _categoryName;
    data['category_icon'] = _categoryIcon;
    return data;
  }
}

class SliderVideoMaster {
  List<SliderVideoData>? _data;
  bool? _success;
  String? _message;

  SliderVideoMaster(
      {List<SliderVideoData>? data, bool? success, String? message}) {
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

  List<SliderVideoData>? get data => _data;
  set data(List<SliderVideoData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  SliderVideoMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <SliderVideoData>[];
      json['data'].forEach((v) {
        _data!.add(SliderVideoData.fromJson(v));
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

class SliderVideoData {
  int? _id;
  String? _title;
  String? _link;
  String? _createdAt;
  String? _updatedAt;

  SliderVideoData(
      {int? id,
      String? title,
      String? link,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (link != null) {
      _link = link;
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
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get link => _link;
  set link(String? link) => _link = link;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  SliderVideoData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _link = json['link'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['link'] = _link;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}

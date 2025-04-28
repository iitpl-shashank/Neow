class AllAboutPeriodsDetailsMaster {
  List<AllPeriodsDetailData>? _data;
  bool? _success;
  String? _message;

  AllAboutPeriodsDetailsMaster(
      {List<AllPeriodsDetailData>? data, bool? success, String? message}) {
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

  List<AllPeriodsDetailData>? get data => _data;
  set data(List<AllPeriodsDetailData>? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  AllAboutPeriodsDetailsMaster.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <AllPeriodsDetailData>[];
      json['data'].forEach((v) {
        _data!.add(AllPeriodsDetailData.fromJson(v));
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

class AllPeriodsDetailData {
  String? _media;
  String? _mediaType;
  String? _description;

  AllPeriodsDetailData({String? media, String? mediaType, String? description}) {
    if (media != null) {
      _media = media;
    }
    if (mediaType != null) {
      _mediaType = mediaType;
    }
    if (description != null) {
      _description = description;
    }
  }

  String? get media => _media;
  set media(String? media) => _media = media;
  String? get mediaType => _mediaType;
  set mediaType(String? mediaType) => _mediaType = mediaType;
  String? get description => _description;
  set description(String? description) => _description = description;

  AllPeriodsDetailData.fromJson(Map<String, dynamic> json) {
    _media = json['media'];
    _mediaType = json['media_type'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media'] = _media;
    data['media_type'] = _mediaType;
    data['description'] = _description;
    return data;
  }
}

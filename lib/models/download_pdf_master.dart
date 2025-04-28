class DownloadPdfMaster {
  Data? _data;
  bool? _success;
  String? _message;

  DownloadPdfMaster({Data? data, bool? success, String? message}) {
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

  DownloadPdfMaster.fromJson(Map<String, dynamic> json) {
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
  String? _pdfPath;

  Data({String? pdfPath}) {
    if (pdfPath != null) {
      _pdfPath = pdfPath;
    }
  }

  String? get pdfPath => _pdfPath;
  set pdfPath(String? pdfPath) => _pdfPath = pdfPath;

  Data.fromJson(Map<String, dynamic> json) {
    _pdfPath = json['pdf_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pdf_path'] = _pdfPath;
    return data;
  }
}

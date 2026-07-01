class DownloadSymptomReportMaster {
  int? status;
  String? msg;
  bool? success;
  SymptomReportData? data;

  DownloadSymptomReportMaster({this.status, this.msg, this.success, this.data});

  DownloadSymptomReportMaster.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    success = json['success'];
    data = json['data'] != null ? SymptomReportData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SymptomReportData {
  String? fileUrl;

  SymptomReportData({this.fileUrl});

  SymptomReportData.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_url'] = fileUrl;
    return data;
  }
}

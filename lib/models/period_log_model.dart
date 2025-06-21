class PeriodLogModel {
  final PeriodLogData data;
  final bool success;
  final String message;

  PeriodLogModel({
    required this.data,
    required this.success,
    required this.message,
  });

  factory PeriodLogModel.fromJson(Map<String, dynamic> json) {
    return PeriodLogModel(
      data: PeriodLogData.fromJson(json['data'] ?? {}),
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class PeriodLogData {
  final bool hasLogs;

  PeriodLogData({required this.hasLogs});

  factory PeriodLogData.fromJson(Map<String, dynamic> json) {
    return PeriodLogData(
      hasLogs: json['has_logs'] ?? false,
    );
  }
}

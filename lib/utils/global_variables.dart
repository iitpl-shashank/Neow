import 'package:flutter/cupertino.dart';

import '../models/login_master.dart';
import '../models/cycle_dates_master.dart';

import 'package:flutter/cupertino.dart';

import '../models/login_master.dart';
import '../models/cycle_dates_master.dart';

class PeriodInfoListResponse {
  final PeriodObj data;
  final bool success;
  final String message;

  PeriodInfoListResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory PeriodInfoListResponse.fromJson(Map<String, dynamic> json) {
    return PeriodInfoListResponse(
      data: PeriodObj.fromJson(json['data'] ?? {}),
      success: json['success'] ?? false,
      message: json['message'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
      'message': message,
    };
  }
}

class PeriodObj {
  final List<PeriodData> periodData;
  final List<PredictionData> predictions;
  final String avgCycleLength;
  final String avgPeriodLength;
  final int diffInDays;

  PeriodObj({
    required this.periodData,
    required this.predictions,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.diffInDays,
  });

  factory PeriodObj.fromJson(Map<String, dynamic> json) {
    return PeriodObj(
      periodData: (json['periods_info'] as List?)
              ?.map((e) => PeriodData.fromJson(e))
              .toList() ??
          [],
      predictions: (json['predictions'] as List?)
              ?.map((e) => PredictionData.fromJson(e))
              .toList() ??
          [],
      avgCycleLength: json['avg_cycle_length']?.toString() ?? "",
      avgPeriodLength: json['avg_period_length']?.toString() ?? "",
      diffInDays: json['diff_in_days'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'periods_info': periodData.map((e) => e.toJson()).toList(),
      'avg_cycle_length': avgCycleLength,
      'avg_period_length': avgPeriodLength,
      'predictions': predictions.map((e) => e.toJson()).toList(),
      'diff_in_days': diffInDays,
    };
  }
}

class PeriodData {
  final String periodStartDate;
  final String periodEndDate;
  final String periodLength;
  final String periodCycleLength;

  PeriodData({
    required this.periodStartDate,
    required this.periodEndDate,
    required this.periodLength,
    required this.periodCycleLength,
  });

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    return PeriodData(
      periodStartDate: json['period_start_date']?.toString() ?? "",
      periodEndDate: json['period_end_date']?.toString() ?? "",
      periodLength: json['period_length']?.toString() ?? "",
      periodCycleLength: json['period_cycle_length']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'period_length': periodLength,
      'period_cycle_length': periodCycleLength,
    };
  }
}

class PredictionData {
  final String month;
  final String predictedStart;
  final String predictedEnd;
  final String ovulationDay;
  final String fertileWindowStart;
  final String fertileWindowEnd;

  PredictionData({
    required this.month,
    required this.predictedStart,
    required this.predictedEnd,
    required this.ovulationDay,
    required this.fertileWindowStart,
    required this.fertileWindowEnd,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      month: json['month']?.toString() ?? "",
      predictedStart: json['predicted_start']?.toString() ?? "",
      predictedEnd: json['predicted_end']?.toString() ?? "",
      ovulationDay: json['ovulation_day']?.toString() ?? "",
      fertileWindowStart: json['fertile_window_start']?.toString() ?? "",
      fertileWindowEnd: json['fertile_window_end']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'predicted_start': predictedStart,
      'predicted_end': predictedEnd,
      'ovulation_day': ovulationDay,
      'fertile_window_start': fertileWindowStart,
      'fertile_window_end': fertileWindowEnd,
    };
  }
}

bool connectivity = true, isNotifyConnectivity = false;
String languageCode = "en";
GlobalKey<NavigatorState> mainNavKey = GlobalKey();
String gUserType = "";
UserMaster? globalUserMaster;
List<CycleDates> gCycleDates = [];
// String connectivity = "";
String appVersion = "";
String uuid = "";
String globalPday = "0";
bool globalIsPeriodDay = false;
String platform = "";
bool isWithinFourteenDays = false;

List<PeriodObj> peroidCustomeList = [];
String? globalFertileWindowStart;
String? globalFertileWindowEnd;
bool _isLogEdit = false;

// Getter
bool get isLogEdit => _isLogEdit;

// Setter
set isLogEdit(bool value) {
  _isLogEdit = value;
}

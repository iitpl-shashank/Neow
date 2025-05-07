import 'dart:convert';

SymptomReportModel symptomReportModelFromJson(String str) =>
    SymptomReportModel.fromJson(json.decode(str));

String symptomReportModelToJson(SymptomReportModel data) =>
    json.encode(data.toJson());

class SymptomReportModel {
  Data? data;
  bool? success;
  String? message;

  SymptomReportModel({
    this.data,
    this.success,
    this.message,
  });

  factory SymptomReportModel.fromJson(Map<String, dynamic> json) =>
      SymptomReportModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
        "message": message,
      };
}

class Data {
  MonthlyScores? monthlyScores;

  Data({
    this.monthlyScores,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        monthlyScores: json["monthly_scores"] == null
            ? null
            : MonthlyScores.fromJson(json["monthly_scores"]),
      );

  Map<String, dynamic> toJson() => {
        "monthly_scores": monthlyScores?.toJson(),
      };
}

class MonthlyScores {
  May2025? may2025;

  MonthlyScores({
    this.may2025,
  });

  factory MonthlyScores.fromJson(Map<String, dynamic> json) => MonthlyScores(
        may2025: json["May 2025"] == null
            ? null
            : May2025.fromJson(json["May 2025"]),
      );

  Map<String, dynamic> toJson() => {
        "May 2025": may2025?.toJson(),
      };
}

class May2025 {
  List<Log>? logs;
  String? flow;
  String? pain;
  String? stress;
  List<String>? logDates;
  String? acne;

  May2025({
    this.logs,
    this.flow,
    this.pain,
    this.stress,
    this.logDates,
    this.acne,
  });

  factory May2025.fromJson(Map<String, dynamic> json) => May2025(
        logs: json["logs"] == null
            ? []
            : List<Log>.from(json["logs"]!.map((x) => Log.fromJson(x))),
        flow: json["flow"],
        pain: json["pain"],
        stress: json["stress"],
        logDates: json["log_dates"] == null
            ? []
            : List<String>.from(json["log_dates"]!.map((x) => x)),
        acne: json["acne"],
      );

  Map<String, dynamic> toJson() => {
        "logs": logs == null
            ? []
            : List<dynamic>.from(logs!.map((x) => x.toJson())),
        "flow": flow,
        "pain": pain,
        "stress": stress,
        "log_dates":
            logDates == null ? [] : List<dynamic>.from(logDates!.map((x) => x)),
        "acne": acne,
      };
}

class Log {
  int? year;
  int? month;
  DateTime? periodStartDate;
  int? logDay;
  int? stainingScore;
  int? clotSizeScore;
  int? workingAbilityScore;
  int? locationScore;
  int? periodCrampsScore;
  int? daysScore;
  int? stress;
  int? acne;

  Log({
    this.year,
    this.month,
    this.periodStartDate,
    this.logDay,
    this.stainingScore,
    this.clotSizeScore,
    this.workingAbilityScore,
    this.locationScore,
    this.periodCrampsScore,
    this.daysScore,
    this.stress,
    this.acne,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        year: json["year"],
        month: json["month"],
        periodStartDate: json["period_start_date"] == null
            ? null
            : DateTime.parse(json["period_start_date"]),
        logDay: json["log_day"],
        stainingScore: json["staining_score"],
        clotSizeScore: json["clot_size_score"],
        workingAbilityScore: json["working_ability_score"],
        locationScore: json["location_score"],
        periodCrampsScore: json["period_cramps_score"],
        daysScore: json["days_score"],
        stress: json["stress"],
        acne: json["acne"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "period_start_date":
            "${periodStartDate!.year.toString().padLeft(4, '0')}-${periodStartDate!.month.toString().padLeft(2, '0')}-${periodStartDate!.day.toString().padLeft(2, '0')}",
        "log_day": logDay,
        "staining_score": stainingScore,
        "clot_size_score": clotSizeScore,
        "working_ability_score": workingAbilityScore,
        "location_score": locationScore,
        "period_cramps_score": periodCrampsScore,
        "days_score": daysScore,
        "stress": stress,
        "acne": acne,
      };
}

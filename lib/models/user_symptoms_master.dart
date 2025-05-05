import 'dart:convert';

UserSymptomsMaster userSymptomsMasterFromJson(String str) => UserSymptomsMaster.fromJson(json.decode(str));

String userSymptomsMasterToJson(UserSymptomsMaster data) => json.encode(data.toJson());

class UserSymptomsMaster {
    final Data? data;
    final bool? success;
    final String? message;

    UserSymptomsMaster({
        this.data,
        this.success,
        this.message,
    });

    factory UserSymptomsMaster.fromJson(Map<String, dynamic> json) => UserSymptomsMaster(
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
    final List<Log>? logs;
    final int? totalStainingScore;
    final int? totalClotSizeScore;
    final int? totalstainclotScore;
    final bool? stainalert;
    final int? severeScore;
    final bool? severealert;

    Data({
        this.logs,
        this.totalStainingScore,
        this.totalClotSizeScore,
        this.totalstainclotScore,
        this.stainalert,
        this.severeScore,
        this.severealert,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        logs: json["logs"] == null ? [] : List<Log>.from(json["logs"]!.map((x) => Log.fromJson(x))),
        totalStainingScore: json["total_staining_score"],
        totalClotSizeScore: json["total_clot_size_score"],
        totalstainclotScore: json["totalstainclotScore"],
        stainalert: json["stainalert"],
        severeScore: json["severeScore"],
        severealert: json["severealert"],
    );

    Map<String, dynamic> toJson() => {
        "logs": logs == null ? [] : List<dynamic>.from(logs!.map((x) => x.toJson())),
        "total_staining_score": totalStainingScore,
        "total_clot_size_score": totalClotSizeScore,
        "totalstainclotScore": totalstainclotScore,
        "stainalert": stainalert,
        "severeScore": severeScore,
        "severealert": severealert,
    };
}

class Log {
    final int? id;
    final int? userId;
    final DateTime? periodStartDate;
    final int? logDay;
    final int? staining;
    final int? clotSize;
    final int? workingAbility;
    final String? location;
    final int? cramps;
    final int? days;
    final int? collectionMethod;
    final int? frequencyOfChangeDay;
    final int? mood;
    final int? energy;
    final int? stress;
    final dynamic lifestyle;
    final int? acne;
    final int? stainingScore;
    final int? clotSizeScore;
    final int? workingAbilityScore;
    final int? locationScore;
    final int? periodCrampsScore;
    final int? daysScore;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Log({
        this.id,
        this.userId,
        this.periodStartDate,
        this.logDay,
        this.staining,
        this.clotSize,
        this.workingAbility,
        this.location,
        this.cramps,
        this.days,
        this.collectionMethod,
        this.frequencyOfChangeDay,
        this.mood,
        this.energy,
        this.stress,
        this.lifestyle,
        this.acne,
        this.stainingScore,
        this.clotSizeScore,
        this.workingAbilityScore,
        this.locationScore,
        this.periodCrampsScore,
        this.daysScore,
        this.createdAt,
        this.updatedAt,
    });

    factory Log.fromJson(Map<String, dynamic> json) => Log(
        id: json["id"],
        userId: json["user_id"],
        periodStartDate: json["period_start_date"] == null ? null : DateTime.parse(json["period_start_date"]),
        logDay: json["log_day"],
        staining: json["staining"],
        clotSize: json["clot_size"],
        workingAbility: json["working_ability"],
        location: json["location"],
        cramps: json["cramps"],
        days: json["days"],
        collectionMethod: json["collection_method"],
        frequencyOfChangeDay: json["frequency_of_change_day"],
        mood: json["mood"],
        energy: json["energy"],
        stress: json["stress"],
        lifestyle: json["lifestyle"],
        acne: json["acne"],
        stainingScore: json["staining_score"],
        clotSizeScore: json["clot_size_score"],
        workingAbilityScore: json["working_ability_score"],
        locationScore: json["location_score"],
        periodCrampsScore: json["period_cramps_score"],
        daysScore: json["days_score"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "period_start_date": "${periodStartDate!.year.toString().padLeft(4, '0')}-${periodStartDate!.month.toString().padLeft(2, '0')}-${periodStartDate!.day.toString().padLeft(2, '0')}",
        "log_day": logDay,
        "staining": staining,
        "clot_size": clotSize,
        "working_ability": workingAbility,
        "location": location,
        "cramps": cramps,
        "days": days,
        "collection_method": collectionMethod,
        "frequency_of_change_day": frequencyOfChangeDay,
        "mood": mood,
        "energy": energy,
        "stress": stress,
        "lifestyle": lifestyle,
        "acne": acne,
        "staining_score": stainingScore,
        "clot_size_score": clotSizeScore,
        "working_ability_score": workingAbilityScore,
        "location_score": locationScore,
        "period_cramps_score": periodCrampsScore,
        "days_score": daysScore,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

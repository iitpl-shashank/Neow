import 'dart:convert';

VaccinationModel vaccinationModelFromJson(String str) =>
    VaccinationModel.fromJson(json.decode(str));

String vaccinationModelToJson(VaccinationModel data) =>
    json.encode(data.toJson());

class VaccinationModel {
  List<VaccineInfo>? data;
  bool? success;
  String? message;

  VaccinationModel({
    this.data,
    this.success,
    this.message,
  });

  factory VaccinationModel.fromJson(Map<String, dynamic> json) {
    List<VaccineInfo> dataList = [];
    if (json["data"] != null) {
      if (json["data"] is List) {
        dataList = List<VaccineInfo>.from(
            json["data"].map((x) => VaccineInfo.fromJson(x)));
      } else if (json["data"] is Map<String, dynamic>) {
        dataList = [VaccineInfo.fromJson(json["data"])];
      }
    }
    return VaccinationModel(
      data: dataList,
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
      };
}

class VaccineInfo {
  int? id;
  int? userId;
  int? age;
  int? hasKids;
  int? cancerVaccine;
  int? numberOfKids;
  int? hpvVaccine;
  int? isPregnant;
  int? willPregnant;
  int? tryPregnant;
  int? papSmear;
  int? hadPeriod;
  List<int>? experience;
  int? postmenopausal;
  DateTime? createdAt;
  DateTime? updatedAt;

  VaccineInfo({
    this.id,
    this.userId,
    this.age,
    this.hasKids,
    this.cancerVaccine,
    this.numberOfKids,
    this.hpvVaccine,
    this.isPregnant,
    this.willPregnant,
    this.tryPregnant,
    this.papSmear,
    this.hadPeriod,
    this.experience,
    this.postmenopausal,
    this.createdAt,
    this.updatedAt,
  });

  static int? _toInt(dynamic val) {
    if (val == null) return null;
    if (val is bool) return val ? 1 : 0;
    if (val is num) return val.toInt();
    if (val is String) {
      if (val.toLowerCase() == 'true') return 1;
      if (val.toLowerCase() == 'false') return 0;
      return int.tryParse(val);
    }
    return null;
  }

  static List<int> _parseExperience(dynamic val) {
    if (val == null) return [];
    if (val is List) {
      return val
          .map((x) => int.tryParse(x.toString()) ?? 0)
          .where((x) => x != 0)
          .toList();
    }
    if (val is String) {
      final cleanStr = val.trim();
      if (cleanStr.startsWith('[') && cleanStr.endsWith(']')) {
        try {
          final decoded = json.decode(cleanStr);
          if (decoded is List) {
            return decoded
                .map((x) => int.tryParse(x.toString()) ?? 0)
                .where((x) => x != 0)
                .toList();
          }
        } catch (_) {}
      }
      return cleanStr
          .split(',')
          .map((e) => int.tryParse(e.trim()) ?? 0)
          .where((x) => x != 0)
          .toList();
    }
    if (val is num) {
      return [val.toInt()];
    }
    return [];
  }

  factory VaccineInfo.fromJson(Map<String, dynamic> json) => VaccineInfo(
        id: _toInt(json["id"]),
        userId: _toInt(json["user_id"]),
        age: _toInt(json["age"]),
        hasKids: _toInt(json["has_kids"]),
        cancerVaccine: _toInt(json["cancer_vaccine"]),
        numberOfKids: _toInt(json["number_of_kids"]),
        hpvVaccine: _toInt(json["hpv_vaccine"]),
        isPregnant: _toInt(json["is_pregnant"]),
        willPregnant: _toInt(json["will_pregnant"]),
        tryPregnant: _toInt(json["try_pregnant"]),
        papSmear: _toInt(json["pap_smear"]),
        hadPeriod: _toInt(json["had_period"]),
        experience: json["experience"] == null
            ? []
            : _parseExperience(json["experience"]),
        postmenopausal: _toInt(json["postmenopausal"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "age": age,
        "has_kids": hasKids,
        "cancer_vaccine": cancerVaccine,
        "number_of_kids": numberOfKids,
        "hpv_vaccine": hpvVaccine,
        "is_pregnant": isPregnant,
        "will_pregnant": willPregnant,
        "try_pregnant": tryPregnant,
        "pap_smear": papSmear,
        "had_period": hadPeriod,
        "experience": experience == null
            ? []
            : List<dynamic>.from(experience!.map((x) => x)),
        "postmenopausal": postmenopausal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

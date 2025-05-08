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

  factory VaccinationModel.fromJson(Map<String, dynamic> json) =>
      VaccinationModel(
        data: json["data"] == null
            ? []
            : List<VaccineInfo>.from(
                json["data"]!.map((x) => VaccineInfo.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

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

  factory VaccineInfo.fromJson(Map<String, dynamic> json) => VaccineInfo(
        id: json["id"],
        userId: json["user_id"],
        age: json["age"],
        hasKids: json["has_kids"],
        cancerVaccine: json["cancer_vaccine"],
        numberOfKids: json["number_of_kids"],
        hpvVaccine: json["hpv_vaccine"],
        isPregnant: json["is_pregnant"],
        willPregnant: json["will_pregnant"],
        tryPregnant: json["try_pregnant"],
        papSmear: json["pap_smear"],
        hadPeriod: json["had_period"],
        experience: json["experience"] == null
            ? []
            : List<int>.from(json["experience"]!.map((x) => x)),
        postmenopausal: json["postmenopausal"],
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

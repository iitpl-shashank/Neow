import 'dart:convert';

VaccinationModel vaccinationModelFromJson(String str) =>
    VaccinationModel.fromJson(json.decode(str));

String vaccinationModelToJson(VaccinationModel data) =>
    json.encode(data.toJson());

class VaccinationModel {
  Data? data;
  bool? success;
  String? message;

  VaccinationModel({
    this.data,
    this.success,
    this.message,
  });

  factory VaccinationModel.fromJson(Map<String, dynamic> json) =>
      VaccinationModel(
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
  int? userId;
  String? age;
  String? hasKids;
  String? cancerVaccine;
  String? numberOfKids;
  String? hpvVaccine;
  String? isPregnant;
  String? willPregnant;
  String? tryPregnant;
  String? papSmear;
  String? hadPeriod;
  String? experience;
  String? postmenopausal;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
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
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        experience: json["experience"],
        postmenopausal: json["postmenopausal"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
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
        "experience": experience,
        "postmenopausal": postmenopausal,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

import 'dart:convert';

DeactivateAccountModel deactivateAccountModelFromJson(String str) =>
    DeactivateAccountModel.fromJson(json.decode(str));

String deactivateAccountModelToJson(DeactivateAccountModel data) =>
    json.encode(data.toJson());

class DeactivateAccountModel {
  Data? data;
  bool? success;
  String? message;

  DeactivateAccountModel({
    this.data,
    this.success,
    this.message,
  });

  factory DeactivateAccountModel.fromJson(Map<String, dynamic> json) =>
      DeactivateAccountModel(
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
  int? id;
  String? name;
  String? email;
  int? roleId;
  dynamic uniqueId;
  dynamic birthdate;
  dynamic profession;
  dynamic gender;
  dynamic genderType;
  dynamic randomCode;
  dynamic mobile;
  dynamic deviceToken;
  dynamic image;
  dynamic relationshipStatus;
  dynamic averageCycleLength;
  dynamic previousPeriodsBegin;
  dynamic previousPeriodsMonth;
  dynamic averagePeriodLength;
  dynamic humApkeHeKon;
  dynamic emailVerifiedAt;
  dynamic state;
  dynamic city;
  int? status;
  dynamic createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.uniqueId,
    this.birthdate,
    this.profession,
    this.gender,
    this.genderType,
    this.randomCode,
    this.mobile,
    this.deviceToken,
    this.image,
    this.relationshipStatus,
    this.averageCycleLength,
    this.previousPeriodsBegin,
    this.previousPeriodsMonth,
    this.averagePeriodLength,
    this.humApkeHeKon,
    this.emailVerifiedAt,
    this.state,
    this.city,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roleId: json["role_id"],
        uniqueId: json["unique_id"],
        birthdate: json["birthdate"],
        profession: json["profession"],
        gender: json["gender"],
        genderType: json["gender_type"],
        randomCode: json["random_code"],
        mobile: json["mobile"],
        deviceToken: json["device_token"],
        image: json["image"],
        relationshipStatus: json["relationship_status"],
        averageCycleLength: json["average_cycle_length"],
        previousPeriodsBegin: json["previous_periods_begin"],
        previousPeriodsMonth: json["previous_periods_month"],
        averagePeriodLength: json["average_period_length"],
        humApkeHeKon: json["hum_apke_he_kon"],
        emailVerifiedAt: json["email_verified_at"],
        state: json["state"],
        city: json["city"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role_id": roleId,
        "unique_id": uniqueId,
        "birthdate": birthdate,
        "profession": profession,
        "gender": gender,
        "gender_type": genderType,
        "random_code": randomCode,
        "mobile": mobile,
        "device_token": deviceToken,
        "image": image,
        "relationship_status": relationshipStatus,
        "average_cycle_length": averageCycleLength,
        "previous_periods_begin": previousPeriodsBegin,
        "previous_periods_month": previousPeriodsMonth,
        "average_period_length": averagePeriodLength,
        "hum_apke_he_kon": humApkeHeKon,
        "email_verified_at": emailVerifiedAt,
        "state": state,
        "city": city,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

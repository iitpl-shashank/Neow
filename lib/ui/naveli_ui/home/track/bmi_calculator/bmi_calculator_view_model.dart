import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../models/bmi_master.dart';
import '../../../../../models/common_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/global_variables.dart';

class BmiCalculatorViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  String selectedGender = 'Female';
  String dropdownValueHeight = 'Cm';
  String dropdownValueWeight = 'Kg';
  BmiData userData = BmiData();
  double? heightInMeter;
  double? weightInKg;
  String? birthDateString = globalUserMaster?.birthdate;
  DateTime birthDate = DateTime.parse(globalUserMaster!.birthdate.toString());
  int age = 0;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  double calculateBMI(double weight, double height) {
    heightInMeter =
        dropdownValueHeight == 'Cm' ? height / 100 : height * 0.3048;
    weightInKg = dropdownValueWeight == 'Kg' ? weight : weight * 0.453592;
    print(heightInMeter);
    print(weightInKg);
    return weightInKg! / (heightInMeter! * heightInMeter!);
  }

  String interpretBMI(double bmi, int age) {
    if (age < 18) {
      if (age >= 2 && age < 18) {
        if (bmi < 5) {
          return 'Severely Underweight';
        } else if (bmi >= 5 && bmi < 15) {
          return 'Underweight';
        } else if (bmi >= 15 && bmi < 85) {
          return 'Normal Weight';
        } else if (bmi >= 85 && bmi < 95) {
          return 'Overweight';
        } else {
          return 'Obese';
        }
      } else {
        return 'Not enough data for BMI interpretation';
      }
    } else {
      if (bmi < 18.5) {
        return 'Underweight';
      } else if (bmi >= 18.5 && bmi < 24.9) {
        return 'Normal Weight';
      } else if (bmi >= 25 && bmi < 29.9) {
        return 'Overweight';
      } else {
        return 'Obese';
      }
    }
  }

  Future<void> getBmiDetailApi() async {
    CommonUtils.showProgressDialog();
    BmiMaster? master = await _services.api!.getBmiDetail();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Bmi oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      if (master.data != null) {
        userData = master.data!;
      }
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeUserBmiApi({
    required int age,
    required double height,
    required double weight,
    required double bmiScore,
    required String bmiType,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.age: age,
      ApiParams.height: height,
      ApiParams.weight: weight,
      ApiParams.bmi_score: bmiScore,
      ApiParams.bmi_type: bmiType,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.storeUserBmi(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................bmi oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }
}

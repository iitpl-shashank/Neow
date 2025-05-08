import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/vaccination_model.dart';

import '../../../models/common_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import '../splash/splash_view_model.dart';

class WelcomeViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

//Alert variables for user report
  int? age = null;
  int? hasKids = null;
  int? cancerVaccine = null;
  int? numberOfKids = null;
  int? hpvVaccine = null;
  int? isPregnant = null;
  int? willPregnant = null;
  int? tryPregnant = null;
  int? papSmear = null;
  int? hadPeriod = null;
  int? postmenopausal = null;
  List<int> experience = [];

  // 0 for no and 1 for yes

  // Setter methods
  void setAge(int value) {
    age = value;
    notifyListeners();
  }

  void setHasKids(int value) {
    hasKids = value;
    notifyListeners();
  }

  void setCancerVaccine(int value) {
    cancerVaccine = value;
    notifyListeners();
  }

  void setNumberOfKids(int value) {
    numberOfKids = value;
    notifyListeners();
  }

  void setHpvVaccine(int value) {
    hpvVaccine = value;
    notifyListeners();
  }

  void setIsPregnant(int value) {
    isPregnant = value;
    notifyListeners();
  }

  void setWillPregnant(int value) {
    willPregnant = value;
    notifyListeners();
  }

  void setTryPregnant(int value) {
    tryPregnant = value;
    notifyListeners();
  }

  void setPapSmear(int value) {
    papSmear = value;
    notifyListeners();
  }

  void setHadPeriod(int value) {
    hadPeriod = value;
    notifyListeners();
  }

  void setPostmenopausal(int value) {
    postmenopausal = value;
    notifyListeners();
  }

  void setExperience(List<int> values) {
    experience = values;
    notifyListeners();
  }

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> verifyUniqueIdApi(
      {required String? uniqueId, required bool isFromCycle}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.unique_id: uniqueId,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.verifyUniqueId(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Welcome oops.............................");
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
      if (isFromCycle) {
        SplashViewModel().getUserDetails().whenComplete(
              () => pushAndRemoveUntil(
                const WelComeGifView(
                  isFromSplash: false,
                ),
              ),
            );
      } else {
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }

  Future<void> callVaccinationUpdateApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = {
      if (age != null) 'age': age,
      if (hasKids != null) 'has_kids': hasKids,
      if (cancerVaccine != null) 'cancer_vaccine': cancerVaccine,
      if (numberOfKids != null) 'number_of_kids': numberOfKids,
      if (hpvVaccine != null) 'hpv_vaccine': hpvVaccine,
      if (isPregnant != null) 'is_pregnant': isPregnant,
      if (willPregnant != null) 'will_pregnant': willPregnant,
      if (tryPregnant != null) 'try_pregnant': tryPregnant,
      if (papSmear != null) 'pap_smear': papSmear,
      if (hadPeriod != null) 'had_period': hadPeriod,
      if (postmenopausal != null) 'postmenopausal': postmenopausal,
      if (experience.isNotEmpty)
        for (int i = 0; i < experience.length; i++)
          'experience[]': experience[i],
    };

    try {
      VaccinationModel? response =
          await _services.api!.saveVaccinationInfo(params: params);

      CommonUtils.hideProgressDialog();

      if (response != null) {
        CommonUtils.showSnackBar(
          "Vaccination details saved successfully!",
          color: CommonColors.greenColor,
        );
        log("API Response: ${response.toJson()}");
      } else {
        CommonUtils.showSnackBar(
          "Failed to save vaccination details.",
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      CommonUtils.hideProgressDialog();
      CommonUtils.showSnackBar(
        "An error occurred while saving vaccination details.",
        color: CommonColors.mRed,
      );
      log("Exception in callVaccinationUpdateApi: $e");
    } finally {
      notifyListeners();
    }
  }
}

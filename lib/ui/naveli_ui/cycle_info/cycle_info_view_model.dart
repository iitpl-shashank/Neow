import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/cycle_info/welcom_gif_view.dart';

import '../../../generated/i18n.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../common_ui/singin/signin_view_model.dart';

class CycleInfoViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  int currentIndex = 0;
  int selectedIndex = -1;
  final now = DateTime.now();
  int daysInMonth = 0;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void getCurrentMonthDays() {
    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    notifyListeners();
  }

  Future<void> userUpdateDetailsApi({
    required bool isFromCycle,
    String? roleId,
    String? name,
    String? birthdate,
    String? gender,
    String? genderType,
    String? relationshipStatus,
    String? averageCycleLength,
    String? previousPeriodsBegin,
    String? previousPeriodsMonth,
    String? averagePeriodLength,
    String? humAapkeHeKon,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.role_id: roleId,
      ApiParams.name: name,
      ApiParams.birthdate: birthdate,
      ApiParams.gender: gender,
      if (genderType != null) ApiParams.gender_type: genderType,
      ApiParams.relationship_status: relationshipStatus,
      if (averageCycleLength != null)
        ApiParams.average_cycle_length: averageCycleLength,
      if (previousPeriodsBegin != null)
        ApiParams.previous_periods_begin: previousPeriodsBegin,
      if (previousPeriodsMonth != null)
        ApiParams.previous_periods_month: previousPeriodsMonth,
      if (averagePeriodLength != null)
        ApiParams.average_period_length: averagePeriodLength,
      if (humAapkeHeKon != null) ApiParams.hum_apke_he_kon: humAapkeHeKon,
    };
    log(params.toString());

    CommonMaster? master = await _services.api!.userUpdateDetails(
      params: params,
    );
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Cycle info oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        S.of(context)!.detailsSavedfailed,
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        S.of(context)!.detailsSavedSuccess,
        color: CommonColors.greenColor,
      );
      if (isFromCycle) {
        if (gUserType == AppConstants.NEOWME ||
            gUserType == AppConstants.CYCLE_EXPLORER) {
          (roleId ?? "").isNotEmpty ? gUserType = roleId ?? "" : null;
          SplashViewModel().getUserDetails().whenComplete(
                () => pushReplacement(
                  WelComeGifView(
                    isFromSplash: false,
                  ),
                ),
              );
        }
      }
      // AppPreferences.instance.setUserDetails(jsonEncode(master.data));
    }
    notifyListeners();
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../database/app_preferences.dart';
import '../../../../models/all_about_periods_details_master.dart';
import '../../../../models/all_about_periods_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AllAboutPeriodsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<AllAboutData> dataList = [];
  List<AllPeriodsDetailData> detailDataList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAllAboutPeriodDetailApi({
    required int? categoryId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.category_id: categoryId,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    log(params.toString());
    AllAboutPeriodsDetailsMaster? master =
        await _services.api!.getAllAboutPeriodDetail(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................all about period oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      detailDataList = master.data ?? [];
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> getAllAboutPeriodListApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    AllAboutPeriodsMaster? master =
        await _services.api!.getAllAboutPeriodList(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................all about period oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      dataList = master.data ?? [];
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

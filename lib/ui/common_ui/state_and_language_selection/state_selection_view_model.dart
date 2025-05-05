import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/models/state_master.dart';

import '../../../database/app_preferences.dart';
import '../../../models/city_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../welcome/welcome_view.dart';

class StateSelectionViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  StateData selectedState = StateData();
  CityData selectedCity = CityData();
  List<StateData> stateList = [];
  List<CityData> cityList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getStateListApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    StateMaster? master = await _services.api!.getStateList(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................State selection oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      stateList = master.data ?? [];
    }
    notifyListeners();
  }

  Future<void> getCityListApi({
    required int? stateId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.state_id: stateId,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    log(params.toString());
    CityMaster? master = await _services.api!.getCityList(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................State selection oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      cityList = master.data ?? [];
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeCityApi({
    required int? cityId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.city_id: cityId,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.storeCity(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................State selection oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      pushAndRemoveUntil(const WelcomeView());
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeStateApi({
    required int? stateId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.state_id: stateId,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.storeState(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................State selection oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

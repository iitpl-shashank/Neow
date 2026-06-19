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
  }

  void selectState(int? stateId) {
    if (stateId == null) {
      selectedState = StateData();
      selectedCity = CityData();
      cityList = [];
    } else {
      selectedState = stateList.firstWhere(
        (e) => e.id == stateId,
        orElse: () => StateData(),
      );

      selectedCity = CityData();
      cityList = [];

      getCityListApi(stateId: stateId);
    }

    notifyListeners();
  }

  void selectCity(int? cityId) {
    if (cityId == null) {
      selectedCity = CityData();
    } else {
      selectedCity = cityList.firstWhere(
        (city) => city.id == cityId,
        orElse: () => CityData(),
      );
    }
    notifyListeners();
  }

  Future<void> getStateListApi() async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = {
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };

    StateMaster? master = await _services.api!.getStateList(params: params);

    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else {
      final seenIds = <int>{};

      stateList = (master.data ?? []).where((state) {
        if (state.id == null) return false;
        return seenIds.add(state.id!);
      }).toList();

      print("States Loaded: ${stateList.length}");
    }

    notifyListeners();
  }

  Future<void> getCityListApi({
    required int? stateId,
  }) async {
    CommonUtils.showProgressDialog();

    Map<String, dynamic> params = {
      ApiParams.state_id: stateId,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };

    CityMaster? master = await _services.api!.getCityList(params: params);

    CommonUtils.hideProgressDialog();

    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else {
      final seenIds = <int>{};

      cityList = (master.data ?? []).where((city) {
        if (city.id == null) return false;
        return seenIds.add(city.id!);
      }).toList();

      print("Cities Loaded: ${cityList.length}");
    }

    notifyListeners();
  }

  Future<void> storeStateAndCity({
    required int? stateId,
    required int? cityId,
  }) async {
    CommonUtils.showProgressDialog();

    // 1. Store State
    Map<String, dynamic> stateParams = <String, dynamic>{
      ApiParams.state_id: stateId,
    };
    log(stateParams.toString());
    CommonMaster? stateMaster = await _services.api!.storeState(params: stateParams);

    if (stateMaster == null) {
      CommonUtils.hideProgressDialog();
      CommonUtils.oopsMSG();
      return;
    } else if (stateMaster.success == false) {
      CommonUtils.hideProgressDialog();
      CommonUtils.showSnackBar(
        stateMaster.message ?? "--",
        color: CommonColors.mRed,
      );
      return;
    }

    // 2. Store City
    Map<String, dynamic> cityParams = <String, dynamic>{
      ApiParams.city_id: cityId,
    };
    log(cityParams.toString());
    CommonMaster? cityMaster = await _services.api!.storeCity(params: cityParams);
    CommonUtils.hideProgressDialog();

    if (cityMaster == null) {
      CommonUtils.oopsMSG();
    } else if (cityMaster.success == false) {
      CommonUtils.showSnackBar(
        cityMaster.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (cityMaster.success == true) {
      pushAndRemoveUntil(const WelcomeView());
    }
    notifyListeners();
  }
}

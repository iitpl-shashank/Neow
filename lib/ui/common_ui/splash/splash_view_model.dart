import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/common_ui/privacy_policy/privacy_policy_view.dart';
import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/user_details_master.dart';
import '../../../services/index.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../bottom_navbar/bottom_navbar_view_model.dart';
import '../select_options/select_options_view.dart';
import '../singin/signin_view_model.dart';

class SplashViewModel with ChangeNotifier {
  final _services = Services();

  void checkIsFirstTime() {
    // checking app is opening first time
    // below condition satisfied only once when opening app first time
    // if (AppPreferences.instance.getIsFirstTime()) {
    //   // condition TRUE --> set first time false after 1 second
    //   Future.delayed(const Duration(seconds: 1), () {
    //     // updating after 1 second because in Splash view we fetch with singletone instance
    //     AppPreferences.instance.setIsFirstTime(false);
    //   });
    // }
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    log("Stored User Details :: ${jsonEncode(AppPreferences.instance.getUserDetails())}");
    String locale = AppPreferences.instance.getLanguageCode();
    log("User Language :: $locale");
    globalUserMaster = AppPreferences.instance.getUserDetails();
    if (globalUserMaster != null) {
      // user logged in --> [globalUserMaster] is not null and set [gUserType]
      gUserType = globalUserMaster!.roleId.toString();
      // in Below method we get user data from server silently (In background)
      await getUserDetails();
      // in below method we checking if required data is filled or not and redirect user accordingly
      checkGlobalUserData(isFromSplash: true);
      log("User type :: $gUserType");
    } else {
      if (!AppPreferences.instance.getIsFirstTime()) {
        // we set 3 second delay because we have to display [WelComeGifView] as splash screen 3 second instead of door splash
        Future.delayed(const Duration(seconds: 3), () {
          // then navigating user for login option
          pushAndRemoveUntil(const SelectOptionView());
        });
      }
    }
    notifyListeners();
  }

  void onFinishGIF() {
    pushAndRemoveUntil(const SelectOptionView());
    AppPreferences.instance
        .setIsFirstTime(false);
    // pushAndRemoveUntil(const StateSelectionView());
  }

  Future<void> checkGlobalUserData({bool isFromSplash = false}) async {
    if (gUserType == AppConstants.NEOWME &&
        (globalUserMaster?.name == null ||
            globalUserMaster?.gender == null ||
            globalUserMaster?.relationshipStatus == null ||
            globalUserMaster?.birthdate == null ||
            globalUserMaster?.previousPeriodsBegin == null)) {
      pushAndRemoveUntil(const PrivacyPolicyView());
    } else if (gUserType == AppConstants.BUDDY &&
        (globalUserMaster?.name == null ||
            globalUserMaster?.gender == null ||
            globalUserMaster?.relationshipStatus == null ||
            globalUserMaster?.birthdate == null ||
            globalUserMaster?.humApkeHeKon == null)) {
      pushAndRemoveUntil(const PrivacyPolicyView());
    } else if (gUserType == AppConstants.CYCLE_EXPLORER &&
        (globalUserMaster?.name == null ||
            globalUserMaster?.gender == null ||
            globalUserMaster?.relationshipStatus == null ||
            globalUserMaster?.birthdate == null)) {
      pushAndRemoveUntil(const PrivacyPolicyView());
    } else {
      gUserType = globalUserMaster?.roleId == null
          ? ""
          : globalUserMaster!.roleId.toString();
      // user comes from [Login screen] then we have to navigate user instantly to home that's why [isFromSplash = false] and delay is [0 second]
      Future.delayed(Duration(seconds: isFromSplash ? 3 : 0), () {
        SignInViewModel().login(userType: gUserType);
        // pushAndRemoveUntil(const SelectOptionView());
      });
    }
  }

  Future<void> getUserDetails() async {
    UserDetailMaster? master = await _services.api!.getUserDetails();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Splash oops.............................");
    } else if (master.success! && master.data != null) {
      AppPreferences.instance.setUserDetails(jsonEncode(master.data));
      globalUserMaster = master.data;
    } else if (!master.success!) {
      CommonUtils.showRedToastMessage(
        master.message ?? S.of(mainNavKey.currentContext!)!.userDataSyncFailed,
      );
    }
    // below condition check if session is expired or not
    // if (master?.isSessionExpired ?? false) {
    //   // if session is expired then we got [isSessionExpired = true] then
    //   // we have to remove all saved data from local preference and redirect user to login screen
    //   clearPreference();
    // }
  }

  Future<void> logoutApi() async {
    CommonUtils.showProgressDialog();
    await _services.api!.logoutApi();
    CommonUtils.hideProgressDialog();
    clearPreference();
  }

  Future<void> clearPreference() async {
    mainNavKey.currentContext!.read<BottomNavbarViewModel>().selectedIndex = 0;
    String fCMToken = AppPreferences.instance.getFCMToken();
    String langCode = AppPreferences.instance.getLanguageCode();
    await AppPreferences.instance.clear();
    await AppPreferences.instance.setIsFirstTime(false);
    await AppPreferences.instance.setLanguageCode(langCode);
    await AppPreferences.instance.setFCMToken(fCMToken);
    globalUserMaster = null;
    gUserType = "";
    pushAndRemoveUntil(const SelectOptionView());
  }
}

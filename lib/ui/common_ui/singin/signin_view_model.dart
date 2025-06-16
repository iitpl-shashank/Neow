import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view.dart';
import 'package:naveli_2023/ui/common_ui/otp/otp_view.dart';
import 'package:naveli_2023/ui/common_ui/select_options/select_options_view.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/your_naveli/your_naveli_view.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/check_device_token_master.dart';
import '../../../models/login_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';

class SignInViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  final _auth = FirebaseAuth.instance;
  String userRoleId = '';
  String isDeviceStatus = '';

  Future<void> loginApi({required String mobile, required int roleId}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.mobile: mobile,
      ApiParams.role_id: roleId,
      ApiParams.device_token: AppPreferences.instance.getFCMToken(),
    };

    LoginMaster? master = await _services.api!.login(params: params);
    debugPrint("Login Response :: ${jsonEncode(master)}");
    CommonUtils.hideProgressDialog();
    if (master == null) {
      // TODO : For testing login error
      // CommonUtils.showSnackBar(
      //   "Login check issue here 3." ?? "Login check dd : Something went wrong",
      //   color: CommonColors.A43786,
      //   duration: const Duration(seconds: 10),
      // );
      CommonUtils.oopsMSG();
      print(
          "................................Sign In oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
      pushAndRemoveUntil(const SelectOptionView());
    } else if (master.success == true) {
      log("Success :: true");
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      AppPreferences.instance.setAccessToken(master.data!.token!);
      AppPreferences.instance.setUserDetails(jsonEncode(master.data!.user));
      gUserType = master.data!.user!.roleId!.toString();
      globalUserMaster = AppPreferences.instance.getUserDetails();
      SplashViewModel().checkGlobalUserData();
    }
    notifyListeners();
  }

  Future<void> checkDeviceTokenApi({
    required String? mobile,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.mobile: mobile,
    };
    CheckDeviceTokenMaster? master =
        await _services.api!.checkDeviceToken(params: params);
    CommonUtils.hideProgressDialog();
    // try {
    //   CommonUtils.showSnackBar(
    //     "Login check issue here 1. $master",
    //     color: CommonColors.A43786,
    //     duration: const Duration(seconds: 10),
    //   );
    // } catch (e) {
    //   CommonUtils.showSnackBar(
    //     "Login check issue here 1. master is null",
    //     color: CommonColors.A43786,
    //     duration: const Duration(seconds: 10),
    //   );
    // }
    if (master == null) {
      // TODO : For testing login error
      // CommonUtils.showSnackBar(
      //   "Login check issue here 1." ?? "Login check dd : Something went wrong",
      //   color: CommonColors.A43786,
      //   duration: const Duration(seconds: 10),
      // );
      CommonUtils.oopsMSG();
      print(
          "................................Rakesh NEw 81 sign in oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      isDeviceStatus = master.data ?? '';
    }
    notifyListeners();
  }

  Future<void> removeDeviceTokenApi({
    required String? mobile,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.mobile: mobile,
    };
    CommonMaster? master =
        await _services.api!.removeDeviceToken(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      // TODO : For testing login error
      // CommonUtils.showSnackBar(
      //   "Login check issue here 2." ?? "Login check dd : Something went wrong",
      //   color: CommonColors.A43786,
      //   duration: const Duration(seconds: 10),
      // );
      CommonUtils.oopsMSG();
      print(
          "................................sign in oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {}
    notifyListeners();
  }

  // void verifyMobileApi({required mobile}) async {
  //   CommonUtils.showProgressDialog();
  //   Map<String, dynamic> params = <String, dynamic>{
  //     ApiParams.mobile: mobile,
  //   };
  //   CommonMaster? master = await _services.api!.verifyMobile(params: params);
  //   CommonUtils.hideProgressDialog();
  //   log("Master :: ${jsonEncode(master)}");
  //   if (master != null && master.success != null && master.success!) {
  //     // CommonUtils.showSnackBar(
  //     //   master.message,
  //     //   color: CommonColors.greenColor,
  //     // );
  //     verifyPhone(
  //       phoneNumber: mobile,
  //       onCodeSent: () {},
  //     );
  //   } else if (master != null) {
  //     CommonUtils.showSnackBar(
  //       master.message ?? "--",
  //       color: CommonColors.mRed,
  //     );
  //   } else {
  //     CommonUtils.oopsMSG();
  //   }
  //   notifyListeners();
  // }

  Future<void> verifyPhone(
      {required String phoneNumber,
      required Function onCodeSent,
      required BuildContext context}) async {
    CommonUtils.showProgressDialog();
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      CommonUtils.hideProgressDialog();
      var phoneNumberWithCountryCode = "+91$phoneNumber";
      pushAndRemoveUntil(OTPView(
        phoneNumber: phoneNumberWithCountryCode,
        verificationId: verId,
        roleId: userRoleId,
      ));
    } as PhoneCodeSent;
    try {
      log("verifyPhone Function call");
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$phoneNumber",
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            // this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 40),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            CommonUtils.hideProgressDialog();
          },
          // codeAutoRetrievalTimeout: (String verId) {
          //   log("Auto retrieval timeout. Retrying...");
          //   verifyPhone(phoneNumber: phoneNumber, onCodeSent: onCodeSent, context: context);
          // },

          verificationFailed: (FirebaseAuthException exceptio) {
            CommonUtils.hideProgressDialog();
            // final snackBar = SnackBar(content: Text(exceptio.message));
            log("verification New\n${exceptio.message}");
            // TODO : For testing login error
            // CommonUtils.showSnackBar(
            //   color: CommonColors.mRed,
            //   exceptio.message!.contains("blocked")
            //       ? exceptio.message
            //       : S.of(context)?.verificationFailed,
            // );
            CommonUtils.showSnackBar(
              color: CommonColors.mRed,
              exceptio.message,
              duration: const Duration(seconds: 10),
            );
            log("verification failed\n${exceptio.message}");
            notifyListeners();
          });
    } catch (e) {
      CommonUtils.hideProgressDialog();
      notifyListeners();
    }
  }

  void login({required String userType}) {
    if (userType == AppConstants.NEOWME) {
      // pushAndRemoveUntil(const WelComeGifView(isFromSplash: false));
      pushAndRemoveUntil(const BottomNavbarView());
    } else if (userType == AppConstants.BUDDY) {
      print("Buddy Access :: ${AppPreferences.instance.getBuddyAccess()}");
      pushAndRemoveUntil(AppPreferences.instance.getBuddyAccess()
          ? const BottomNavbarView()
          : const YourNaveliView());
    } else if (userType == AppConstants.CYCLE_EXPLORER) {
      pushAndRemoveUntil(const BottomNavbarView());
    }
    notifyListeners();
  }
}

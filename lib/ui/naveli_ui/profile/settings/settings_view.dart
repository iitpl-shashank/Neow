import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../database/app_preferences.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_profile_menu.dart';
import '../../../app/app_model.dart';
import '../../../common_ui/splash/splash_view_model.dart';
import '../account_access/account_access_view.dart';
import '../your_naveli/your_naveli_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isSelected = false;
  int selectedIndex = 1;

  void setLanguage(String langCode) {
    AppPreferences.instance.setLanguageCode(langCode);
    CommonUtils.languageCode = langCode;
    Provider.of<AppModel>(mainNavKey.currentContext!, listen: false)
        .changeLanguage();
  }

  void changeLanguage(int index) {
    if (index == 1) {
      setLanguage(AppConstants.LANGUAGE_ENGLISH);
    } else if (index == 2) {
      setLanguage(AppConstants.LANGUAGE_HINDI);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_ENGLISH) {
      selectedIndex = 1;
    } else if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_HINDI) {
      selectedIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.settings,
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              kCommonSpaceV30,
              Container(
                width: kDeviceWidth / 1,
                decoration: ShapeDecoration(
                  color: CommonColors.mWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    if (gUserType == AppConstants.NEOWME)
                      CommonProfileMenu(
                        text: S.of(context)!.accountAccess,
                        isLast: false,
                        // color: CommonColors.blackColor,
                        underLineColor: CommonColors.mGrey300,
                        onTap: () {
                          push(const AccountAccessView());
                        },
                      ),
                    if (gUserType == AppConstants.BUDDY)
                      CommonProfileMenu(
                        text: S.of(context)!.yourNaveli,
                        isLast: false,
                        underLineColor: CommonColors.mGrey300,
                        //color: CommonColors.blackColor,
                        onTap: () {
                          push(const YourNaveliView());
                        },
                      ),
                    CommonProfileMenu(
                      text: S.of(context)!.deActiveYourAcc,
                      isLast: false,
                      underLineColor: CommonColors.mGrey300,
                      //color: CommonColors.blackColor,
                    ),
                    CommonProfileMenu(
                      onTap: () {
                        SplashViewModel().logoutApi();
                      },
                      text: S.of(context)!.logout,
                      isLast: true,
                      // color: CommonColors.mRed,
                    ),
                  ],
                ),
              ),
              kCommonSpaceV30,
              Container(
                width: kDeviceWidth / 1,
                decoration: ShapeDecoration(
                  color: CommonColors.mWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context)!.metricSystem,
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: isSelected,
                          activeColor: CommonColors.primaryColor,
                          onChanged: (bool value) {
                            setState(() {
                              isSelected = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV30,
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: CommonColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(30.0),
                    color: CommonColors.mTransparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                          changeLanguage(selectedIndex);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 25, right: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: selectedIndex == 1
                                // ? Color(0xFFC06CF9)
                                ? CommonColors.primaryColor
                                : CommonColors.mTransparent),
                        child: Text(
                          "English",
                          style: getAppStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 1
                                  ? CommonColors.mWhite
                                  : CommonColors.blackColor),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                          changeLanguage(selectedIndex);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, left: 25, right: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: selectedIndex == 2
                                // ? Color(0xFFC06CF9)
                                ? CommonColors.primaryColor
                                : CommonColors.mTransparent),
                        child: Text(
                          "हिंदी",
                          style: getAppStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 2
                                  ? CommonColors.mWhite
                                  : CommonColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

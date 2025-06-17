import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import '../../../../database/app_preferences.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../app/app_model.dart';
import '../../../common_ui/splash/splash_view_model.dart';
import '../account_access/account_access_view.dart';
import '../account_access/account_access_view_model.dart';
import '../dashboard/dashboard_view_model.dart';
import 'widgets/info_box.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isSelected = false;
  int selectedIndex = 1;
  late AccountAccessViewModel mViewModel;
  Timer? timer;
  bool hasPending = false;
  bool hasAccepted = false;
  bool hasRejected = false;
  List<String> acceptedIds = [];

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
    super.initState();
    Future.delayed(Duration.zero, () async {
      mViewModel.attachedContext(context);
      await mViewModel.getBuddyRequestApi();
      setState(() {
        if (mViewModel.buddyRequestDataList != null &&
            mViewModel.buddyRequestDataList!.isNotEmpty) {
          acceptedIds.clear();
          hasPending = mViewModel.buddyRequestDataList!
              .any((item) => item.notificationStatus == "pending");
          hasAccepted = mViewModel.buddyRequestDataList!
              .any((item) => item.notificationStatus == "accepted");
          hasRejected = mViewModel.buddyRequestDataList!
              .any((item) => item.notificationStatus == "rejected");
          for (var item in mViewModel.buddyRequestDataList!) {
            if (item.notificationStatus == "accepted") {
              acceptedIds.add(item.id.toString());
            }
          }
        } else {
          hasPending = false;
          hasAccepted = false;
          hasRejected = false;
        }
      });
      timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {
        // Call your method here
        await mViewModel.getBuddyRequestApi();
        setState(() {
          if (mViewModel.buddyRequestDataList != null &&
              mViewModel.buddyRequestDataList!.isNotEmpty) {
            acceptedIds.clear();
            hasPending = mViewModel.buddyRequestDataList!
                .any((item) => item.notificationStatus == "pending");
            hasAccepted = mViewModel.buddyRequestDataList!
                .any((item) => item.notificationStatus == "accepted");
            hasRejected = mViewModel.buddyRequestDataList!
                .any((item) => item.notificationStatus == "rejected");
            for (var item in mViewModel.buddyRequestDataList!) {
              if (item.notificationStatus == "accepted") {
                acceptedIds.add(item.id.toString());
              }
            }
          } else {
            hasPending = false;
            hasAccepted = false;
            hasRejected = false;
          }
        });
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashBoardViewModel>(context, listen: false)
          .getUserPersonalInformation();
    });
    if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_ENGLISH) {
      selectedIndex = 1;
    } else if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_HINDI) {
      selectedIndex = 2;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AccountAccessViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Padding(
            padding: kCommonScreenPadding,
            child: PrimaryButton(
              label: S.of(context)!.logout,
              onPress: () {
                SplashViewModel().logoutApi();
              },
            ),
          ),
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.settings,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(S.of(context)!.uniqueId,
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: kCommonScreenPadding,
                    child: InfoBox(
                        text:
                            '•  ${Provider.of<DashBoardViewModel>(context).userUniqueId}'),
                  ),
                ),
                // TODO : Hidden as per client request
                if (mViewModel.buddyRequestDataList != null &&
                    mViewModel.buddyRequestDataList!.isNotEmpty)
                  const SizedBox(height: 10),
                if (mViewModel.buddyRequestDataList != null &&
                    mViewModel.buddyRequestDataList!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text("Pairing",
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                if (mViewModel.buddyRequestDataList != null &&
                    mViewModel.buddyRequestDataList!.isNotEmpty)
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: kCommonScreenPadding,
                      child: Column(
                        children: [
                          // if (mViewModel.buddyRequestDataList != null &&
                          //     mViewModel.buddyRequestDataList!.isNotEmpty &&
                          //     (mViewModel.buddyRequestDataList!.first
                          //                 .notificationStatus ==
                          //             "pending" ||
                          //         mViewModel.buddyRequestDataList!.first
                          //                 .notificationStatus ==
                          //             "rejected"))
                          GestureDetector(
                            onTap: () async {
                              final uniqueId = Provider.of<DashBoardViewModel>(
                                      context,
                                      listen: false)
                                  .userUniqueId;
                              await Clipboard.setData(
                                  ClipboardData(text: uniqueId));

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    S.of(context)!.copiedToClipboard,
                                  ),
                                ),
                              );
                            },
                            child: InfoBox(
                              text: 'Generate Code',
                              endWidget: Image.asset(
                                LocalImages.icMagicWand,
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ),

                          Text(
                            "Share this with your Buddy to allow them to monitor your cycle and your health",
                            style: TextStyle(
                              color: CommonColors.greyText,
                            ),
                          ),
                          if (hasAccepted) const SizedBox(height: 25),
                          if (hasAccepted)
                            InfoBox(
                              text: 'Currently Paired',
                              // endWidget: Text(
                              //   mViewModel.buddyRequestDataList!.first.id
                              //       .toString(),
                              //   style: TextStyle(
                              //     color: CommonColors.greyText,
                              //     fontWeight: FontWeight.normal,
                              //   ),
                              // ),
                              endWidget: Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (acceptedIds.isNotEmpty)
                                      Wrap(
                                        direction: Axis.vertical,
                                        children: acceptedIds
                                            .map((id) => Text(
                                                  id,
                                                  style: TextStyle(
                                                    color:
                                                        CommonColors.greyText,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    else
                                      Text(
                                        'No Buddies',
                                        style: TextStyle(
                                          color: CommonColors.greyText,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),
                          if (hasAccepted)
                            GestureDetector(
                              onTap: () {
                                push(const AccountAccessView());
                              },
                              child: const InfoBox(
                                text: 'Exit Pairing',
                              ),
                            ),
                          if (hasPending || hasRejected)
                            GestureDetector(
                              onTap: () {
                                push(const AccountAccessView());
                              },
                              child: const InfoBox(
                                text: 'Check Pairing Requests',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    S.of(context)!.language,
                    style: getAppStyle(
                      color: CommonColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  color: CommonColors.bgGrey,
                  child: Padding(
                    padding: kCommonScreenPadding,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                              changeLanguage(selectedIndex);
                            });
                          },
                          child: InfoBox(
                            text: 'English',
                            endWidget: (selectedIndex == 1)
                                ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                              changeLanguage(selectedIndex);
                            });
                          },
                          child: InfoBox(
                            text: 'हिंदी',
                            endWidget: (selectedIndex == 2)
                                ? Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    S.of(context)!.account,
                    style: getAppStyle(
                      color: CommonColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  color: CommonColors.bgGrey,
                  child: Padding(
                    padding: kCommonScreenPadding,
                    child: Column(
                      children: [
                        InfoBox(
                          text: S.of(context)!.deactivateAccount,
                        ),
                        const SizedBox(height: 12),
                        InfoBox(
                          text: S.of(context)!.changePhoneNumber,
                          endWidget: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // kCommonSpaceV30,
                // Container(
                //   width: kDeviceWidth / 1,
                //   decoration: ShapeDecoration(
                //     color: CommonColors.mWhite,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     shadows: const [
                //       BoxShadow(
                //         color: Color(0x3F000000),
                //         blurRadius: 5,
                //         offset: Offset(0, 2),
                //         spreadRadius: 0,
                //       )
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       if (gUserType == AppConstants.NEOWME)
                //         CommonProfileMenu(
                //           text: S.of(context)!.accountAccess,
                //           isLast: false,
                //           // color: CommonColors.blackColor,
                //           underLineColor: CommonColors.mGrey300,
                //           onTap: () {
                //             push(const AccountAccessView());
                //           },
                //         ),
                //       if (gUserType == AppConstants.BUDDY)
                //         CommonProfileMenu(
                //           text: S.of(context)!.yourNaveli,
                //           isLast: false,
                //           underLineColor: CommonColors.mGrey300,
                //           //color: CommonColors.blackColor,
                //           onTap: () {
                //             push(const YourNaveliView());
                //           },
                //         ),
                //       CommonProfileMenu(
                //         text: S.of(context)!.deActiveYourAcc,
                //         isLast: false,
                //         underLineColor: CommonColors.mGrey300,
                //         //color: CommonColors.blackColor,
                //       ),
                //       CommonProfileMenu(
                //         onTap: () {
                //           SplashViewModel().logoutApi();
                //         },
                //         text: S.of(context)!.logout,
                //         isLast: true,
                //         // color: CommonColors.mRed,
                //       ),
                //     ],
                //   ),
                // ),
                // kCommonSpaceV30,
                // Container(
                //   width: kDeviceWidth / 1,
                //   decoration: ShapeDecoration(
                //     color: CommonColors.mWhite,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     shadows: const [
                //       BoxShadow(
                //         color: Color(0x3F000000),
                //         blurRadius: 5,
                //         offset: Offset(0, 2),
                //         spreadRadius: 0,
                //       )
                //     ],
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           S.of(context)!.metricSystem,
                //           style: getAppStyle(
                //             color: CommonColors.blackColor,
                //             fontSize: 16,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //         Transform.scale(
                //           scale: 0.7,
                //           child: CupertinoSwitch(
                //             value: isSelected,
                //             activeColor: CommonColors.primaryColor,
                //             onChanged: (bool value) {
                //               setState(() {
                //                 isSelected = value;
                //               });
                //             },
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // kCommonSpaceV30,
                // Container(
                //   decoration: BoxDecoration(
                //       border:
                //           Border.all(color: CommonColors.primaryColor, width: 2),
                //       borderRadius: BorderRadius.circular(30.0),
                //       color: CommonColors.mTransparent),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             selectedIndex = 1;
                //             changeLanguage(selectedIndex);
                //           });
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.only(
                //               top: 5, bottom: 5, left: 25, right: 25),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(30.0),
                //               color: selectedIndex == 1
                //                   // ? Color(0xFFC06CF9)
                //                   ? CommonColors.primaryColor
                //                   : CommonColors.mTransparent),
                //           child: Text(
                //             "English",
                //             style: getAppStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w500,
                //                 color: selectedIndex == 1
                //                     ? CommonColors.mWhite
                //                     : CommonColors.blackColor),
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             selectedIndex = 2;
                //             changeLanguage(selectedIndex);
                //           });
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.only(
                //               top: 5, bottom: 5, left: 25, right: 25),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(30.0),
                //               color: selectedIndex == 2
                //                   // ? Color(0xFFC06CF9)
                //                   ? CommonColors.primaryColor
                //                   : CommonColors.mTransparent),
                //           child: Text(
                //             "हिंदी",
                //             style: getAppStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w500,
                //                 color: selectedIndex == 2
                //                     ? CommonColors.mWhite
                //                     : CommonColors.blackColor),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

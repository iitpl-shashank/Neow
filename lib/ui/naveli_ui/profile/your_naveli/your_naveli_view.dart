import 'dart:async';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/your_naveli/your_naveli_view_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import '../../../../database/app_preferences.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../common_ui/bottom_navbar/bottom_navbar_view.dart';
import '../../../common_ui/splash/splash_view_model.dart';

class YourNaveliView extends StatefulWidget {
  const YourNaveliView({super.key});

  @override
  State<YourNaveliView> createState() => _YourNaveliViewState();
}

class _YourNaveliViewState extends State<YourNaveliView> {
  late YourNaveliViewModel mViewModel;
  String? acceptedUniqueId;
  Timer? timerForRequestApi;

  @override
  void initState() {
    super.initState();
    // Call the method initially
    Future.delayed(
      Duration.zero,
      () async {
        mViewModel.attachedContext(context);
        await mViewModel.getBuddyAlreadySendRequestApi();
        print(
            'acceptedUniqueId:===============================:${acceptedUniqueId}');
        // Set up a periodic timer to call the method every 2 seconds
        // timerForRequestApi = Timer.periodic(
        //   const Duration(seconds: 5),
        //   (Timer t) {
        if (globalUserMaster != null) {
          mViewModel.getBuddyAlreadySendRequestApi().whenComplete(() async {
            if (mViewModel.buddyAlreadySendRequestDataList.isNotEmpty) {
              for (var buddyData
                  in mViewModel.buddyAlreadySendRequestDataList) {
                print(buddyData.toString());

                if (buddyData.notificationStatus == "accepted") {
                  acceptedUniqueId = buddyData.uniqueId;
                  break;
                }
              }
            }
          });
          print(
              'acceptedUniqueId:===============================:${acceptedUniqueId}');
          if (acceptedUniqueId != null) {
            mViewModel.getDataFromUidApi(uniqueId: acceptedUniqueId);
            if (AppPreferences.instance.getBuddyAccess() == false) {
              print(".......First accepted Time called.......");
              pushAndRemoveUntil(const BottomNavbarView());
              AppPreferences.instance.setBuddyAccess(true);
            }
          }
          if (mViewModel.buddyAlreadySendRequestDataList.isNotEmpty) {
            for (var buddyData in mViewModel.buddyAlreadySendRequestDataList) {
              if (buddyData.notificationStatus == "pending" ||
                  buddyData.notificationStatus == "rejected") {
                print(".......First rejected Time called.......");
                acceptedUniqueId = null;
                if (AppPreferences.instance.getBuddyAccess() == true) {
                  pushAndRemoveUntil(const YourNaveliView());
                }
                AppPreferences.instance.setBuddyAccess(false);
              }
            }
          }
        }
        //   },
        // );
      },
    );
  }

  // @override
  // void dispose() {
  //   timerForRequestApi?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<YourNaveliViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: '',
        ),
        body:

            // SingleChildScrollView(
            //   padding: kCommonScreenPadding,
            //   child: ListView.builder(
            //     itemCount: mViewModel.buddyAlreadySendRequestDataList.length,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemBuilder: (context, index) {
            //       return Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 8),
            //           child: Container(
            //             // width: kDeviceWidth / 1,
            //             // height: kDeviceHeight / 2.2,
            //             clipBehavior: Clip.antiAlias,
            //             decoration: ShapeDecoration(
            //               color: CommonColors.mWhite,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               shadows: const [
            //                 BoxShadow(
            //                   color: Color(0x3F000000),
            //                   blurRadius: 5,
            //                   offset: Offset(0, 2),
            //                   spreadRadius: 0,
            //                 )
            //               ],
            //             ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                   padding:
            //                       const EdgeInsets.only(left: 8, right: 8, top: 8),
            //                   child: Text(
            //                       "Name : ${mViewModel.buddyAlreadySendRequestDataList[index].name}"),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(
            //                     left: 8,
            //                     right: 8,
            //                   ),
            //                   child: Text(
            //                       "Unique Id : ${mViewModel.buddyAlreadySendRequestDataList[index].uniqueId}"),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(
            //                     left: 8,
            //                     right: 8,
            //                   ),
            //                   child: Text(
            //                       "Mobile : ${mViewModel.buddyAlreadySendRequestDataList[index].mobile}"),
            //                 ),
            //                 if (mViewModel.buddyAlreadySendRequestDataList[index]
            //                         .notificationStatus ==
            //                     "rejected")
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                         left: 8, right: 8, bottom: 8),
            //                     child: Row(
            //                       children: [
            //                         const Text(
            //                           "Request Status : ",
            //                         ),
            //                         Text(
            //                           mViewModel
            //                                   .buddyAlreadySendRequestDataList[
            //                                       index]
            //                                   .notificationStatus ??
            //                               '',
            //                           style: getAppStyle(color: CommonColors.mRed),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 if (mViewModel.buddyAlreadySendRequestDataList[index]
            //                         .notificationStatus ==
            //                     "accepted")
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                         left: 8, right: 8, bottom: 8),
            //                     child: Row(
            //                       children: [
            //                         const Text(
            //                           "Request Status : ",
            //                         ),
            //                         Text(
            //                           mViewModel
            //                                   .buddyAlreadySendRequestDataList[
            //                                       index]
            //                                   .notificationStatus ??
            //                               '',
            //                           style: getAppStyle(
            //                               color: CommonColors.greenColor),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 if (mViewModel.buddyAlreadySendRequestDataList[index]
            //                         .notificationStatus ==
            //                     "pending")
            //                   Padding(
            //                     padding: const EdgeInsets.only(
            //                         left: 8, right: 8, bottom: 8),
            //                     child: Row(
            //                       children: [
            //                         const Text(
            //                           "Request Status : ",
            //                         ),
            //                         Text(
            //                           mViewModel
            //                                   .buddyAlreadySendRequestDataList[
            //                                       index]
            //                                   .notificationStatus ??
            //                               '',
            //                           style: getAppStyle(
            //                               color: CommonColors.primaryColor),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //               ],
            //             ),
            //           ));
            Center(
          child: (mViewModel.buddyAlreadySendRequestDataList.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    '${S.of(context)!.requestSent} ${mViewModel.buddyAlreadySendRequestDataList[0].name ?? ""}${S.of(context)!.pleaseWaitForApproval}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CommonColors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              : CircularProgressIndicator(
                  color: CommonColors.primaryColor,
                ),
        ),
        bottomNavigationBar: Padding(
          padding: kCommonAllBottomPadding,
          child: Row(
            children: [
              // Expanded(
              //   child: PrimaryButton(
              //     onPress: () {
              //       push(const SendRequestScreen());
              //     },
              //     label: "Send request",
              //   ),
              // ),
              // kCommonSpaceH15,
              Expanded(
                child: PrimaryButton(
                  onPress: () {
                    SplashViewModel().logoutApi();
                  },
                  label: "Logout",
                  buttonColor: CommonColors.fadeRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';
import 'account_access_view_model.dart';

class AccountAccessView extends StatefulWidget {
  const AccountAccessView({super.key});

  @override
  State<AccountAccessView> createState() => _AccountAccessViewState();
}

class _AccountAccessViewState extends State<AccountAccessView> {
  late AccountAccessViewModel mViewModel;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Call the method initially
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getBuddyRequestApi();
      // Set up a periodic timer to call the method every 2 seconds
      timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
        // Call your method here
        mViewModel.getBuddyRequestApi();
      });
    });
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
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.accountAccess,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: ListView.builder(
            itemCount: mViewModel.buddyRequestDataList?.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    // width: kDeviceWidth / 1,
                    // height: kDeviceHeight / 2.2,
                    clipBehavior: Clip.antiAlias,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: Text(
                              "${mViewModel.buddyRequestDataList?[index].name} ${S.of(context)!.wantsToSeeData}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Text(
                              "${S.of(context)!.mobile} : ${mViewModel.buddyRequestDataList?[index].mobile}"),
                        ),
                        kCommonSpaceV5,
                        if (mViewModel.buddyRequestDataList?[index]
                                .notificationStatus ==
                            "pending")
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  buttonColor: CommonColors.greenColor,
                                  height: 40,
                                  onPress: () {
                                    mViewModel.storeAccountAccessStatusApi(
                                        naveliResponse: true,
                                        notificationId: mViewModel
                                            .buddyRequestDataList?[index]
                                            .notificationId);
                                  },
                                  borderRadius: BorderRadius.zero,
                                  label: S.of(context)!.accept,
                                  lblSize: 13,
                                ),
                              ),
                              kCommonSpaceH3,
                              Expanded(
                                child: PrimaryButton(
                                  buttonColor: CommonColors.primaryColor,
                                  height: 40,
                                  onPress: () {
                                    mViewModel.storeAccountAccessStatusApi(
                                        naveliResponse: false,
                                        notificationId: mViewModel
                                            .buddyRequestDataList?[index]
                                            .notificationId);
                                  },
                                  borderRadius: BorderRadius.zero,
                                  label: S.of(context)!.decline,
                                  lblSize: 13,
                                ),
                              ),
                            ],
                          ),
                        if (mViewModel.buddyRequestDataList?[index]
                                .notificationStatus ==
                            "rejected")
                          PrimaryButton(
                            buttonColor: CommonColors.mGrey300,
                            height: 40,
                            onPress: () {},
                            borderRadius: BorderRadius.zero,
                            label: S.of(context)!.rejected,
                            labelColor: CommonColors.blackColor,
                            lblSize: 13,
                          ),
                        if (mViewModel.buddyRequestDataList?[index]
                                .notificationStatus ==
                            "accepted")
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  buttonColor: CommonColors.mGrey300,
                                  height: 40,
                                  onPress: () {},
                                  borderRadius: BorderRadius.zero,
                                  label: S.of(context)!.accepted,
                                  labelColor: CommonColors.blackColor,
                                  lblSize: 13,
                                ),
                              ),
                              kCommonSpaceH3,
                              Expanded(
                                child: PrimaryButton(
                                  buttonColor: CommonColors.primaryColor,
                                  height: 40,
                                  onPress: () {
                                    mViewModel.storeAccountAccessStatusApi(
                                        naveliResponse: false,
                                        notificationId: mViewModel
                                            .buddyRequestDataList?[index]
                                            .notificationId);
                                  },
                                  borderRadius: BorderRadius.zero,
                                  label: S.of(context)!.removeAccess,
                                  lblSize: 13,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}

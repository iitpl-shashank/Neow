import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/rate_and_review/rate_and_review_screen.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/reports/reports_view.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/settings/settings_view.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_profile_menu.dart';
import '../../../widgets/scaffold_bg.dart';
import 'about_us/about_us_view.dart';
import 'dashboard/dashboard_view.dart';
import 'help/help_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.profile,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              kCommonSpaceV20,
              Container(
                width: kDeviceWidth / 1.1,
                decoration: ShapeDecoration(
                  //color: const Color(0xFFDDC1FE).withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    if (gUserType == AppConstants.NEOWME ||
                        gUserType == AppConstants.CYCLE_EXPLORER)
                      CommonProfileMenu(
                        color: Color(0xFFFAEEFF),
                        text: S.of(context)!.myHealthReports,
                        text2: S.of(context)!.viewAndAccessAllYourReport,
                        isLast: false,
                        onTap: () {
                          push(const DashboardView());
                        },
                      ),
                    CommonProfileMenu(
                      color: Color(0xFFFFF1F1),
                      text: S.of(context)!.aboutUs,
                      text2: S.of(context)!.missionAndVision,
                      isLast: false,
                      onTap: () {
                        push(const AboutUs());
                      },
                    ),
                    CommonProfileMenu(
                      color: Color(0xFFEAF6FF),
                      text: S.of(context)!.reminders,
                      text2: S.of(context)!.timelyReminders,
                      isLast: false,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context)!.comingSoon,
                            ),
                          ),
                        );
                      },
                    ),
                    CommonProfileMenu(
                      color: Color(0xFFFFFBED),
                      text: S.of(context)!.help,
                      text2: S.of(context)!.findAnswersAndAssistance,
                      isLast: false,
                      onTap: () {
                        push(const HelpView());
                      },
                    ),
                    CommonProfileMenu(
                      color: Color(0xFFF8FFF0),
                      text: S.of(context)!.settings,
                      text2: S.of(context)!.controlYourAppSettings,
                      isLast: false,
                      onTap: () {
                        push(const SettingsView());
                      },
                    ),
                    CommonProfileMenu(
                      color: Color(0xFFF0EBFF),
                      text: S.of(context)!.rateUs,
                      text2: S.of(context)!.rateAndWriteReview,
                      isLast: false,
                      onTap: () {
                        push(const RateAndReviewScreen());
                      },
                    ),
                    CommonProfileMenu(
                      color: Color(0xFFEAF6FF),
                      text: S.of(context)!.shareNeowApp,
                      text2: S.of(context)!.shareAppWithFriends,
                      isLast: true,
                      onTap: () {
                        if (Platform.isAndroid) {
                          CommonUtils.shareApp(
                            link:
                                "https://play.google.com/store/apps/details?id=com.naveli.naveli_2023",
                          );
                        } else if (Platform.isIOS) {
                          CommonUtils.shareApp(
                            // TODO : Add the ios app link
                            //com.naveli.naveli_2023
                            link:
                                "https://apps.apple.com/app/idXXXXXXXXX", // Replace with your iOS App Store link
                          );
                        } else {
                          CommonUtils.shareApp(); // fallback
                        }
                      },
                    ),
                  ],
                ),
              ),
              kCommonSpaceV50,
              Text(
                S.of(context)!.followUsOn,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 15,
                ),
              ),
              kCommonSpaceV15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          "https://www.facebook.com/share/vgDh7TDfbcB3crNt/?mibextid=LQQJ4d");
                    },
                    child: SvgPicture.asset(
                      LocalSvgs.icFacebook,
                      height: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          "https://www.instagram.com/neowindiaa?utm_source=qr");
                    },
                    child: SvgPicture.asset(
                      LocalSvgs.icInstagram,
                      height: 35,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                          "https://x.com/NeowIndia?t=zxTms01n1yiQ31W4qejuMA&s=08");
                    },
                    child: SvgPicture.asset(
                      LocalSvgs.icTwitter,
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl("https://www.youtube.com/@neowindia");
                    },
                    child: SvgPicture.asset(
                      LocalSvgs.icYoutube,
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl("https://www.neowindia.com/");
                    },
                    child: Image.asset(
                      LocalImages.web,
                      height: 34,
                    ),
                  ),
                ],
              ),
              kCommonSpaceV30,
              /*Card(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          //get colors from hex
                          Color(0xFFF69170),
                          Color(0xFF7D96E6),
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, left: 16.0),
                            child: (Text(S.of(context)!.announcements,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16.0, bottom: 16.0),
                            child: (TextButton(
                                onPressed: () {
                                  // push(const ChatPage());
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: GradientText(
                                    S.of(context)!.check,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFFF69170),
                                      Color(0xFF7D96E6),
                                    ]),
                                  ),
                                ))),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Image.asset(
                          LocalImages.img_naveli_speaker,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV20,*/
            ],
          ),
        ),
      ),
    );
  }
}

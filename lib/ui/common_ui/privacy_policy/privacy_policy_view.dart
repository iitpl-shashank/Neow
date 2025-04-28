import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../state_and_language_selection/state_selection_view.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  bool isCheckedTermsOfService = false;
  bool isCheckedPrivacyPolicy = false;

  late AudioPlayer player;

  @override
  void initState() {
    player = AudioPlayer();
    player.setAsset(LocalImages.au_yatrigan_kripya_dhyan_de);
    playAudio();
    super.initState();
  }

  Future<void> playAudio() async {
    try {
      await player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        body: Center(
          child: SingleChildScrollView(
            padding: kCommonScreenPadding,
            child: Column(
              children: [
                Image.asset(
                  height: kDeviceHeight / 3,
                  LocalImages.img_naveli_speaker,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(LocalImages.img_image_error);
                  },
                ),
                kCommonSpaceV20,
                Text(
                  S.of(context)!.yatriGanDhyanDe,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kCommonSpaceV10,
                Text(
                  "T&C",
                  // maxLines: 1,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kCommonSpaceV20,
                Text(
                  'By clicking the box below, you agree to our Terms and Conditions and Privacy Policy. ',
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kCommonSpaceV5,
                kCommonSpaceV5,
                Text(
                  'In case you are younger than 16 years, please ask your parent/guardian to help you set up your NeoW account. Their permission is mandatory for you to use the NeoW app.',
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kCommonSpaceV20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: CommonColors.primaryColor,
                      value: isCheckedTermsOfService,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isCheckedTermsOfService = newValue ?? false;
                        });
                      },
                    ),
                    Text(
                      S.of(context)!.iAgree,
                      style: getAppStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        S.of(context)!.termsOfServices,
                        overflow: TextOverflow.ellipsis,
                        style: getAppStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: CommonColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: CommonColors.primaryColor,
                      value: isCheckedPrivacyPolicy,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isCheckedPrivacyPolicy = newValue ?? false;
                        });
                      },
                    ),
                    Text(
                      S.of(context)!.iHaveReadClue,
                      style: getAppStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        S.of(context)!.privacyPolicy,
                        overflow: TextOverflow.ellipsis,
                        style: getAppStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: CommonColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                /* kCommonSpaceV10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("\t\t\t • "),
                    Expanded(
                      child: Text(
                        S.of(context)!.theirPermission,
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("\t\t\t • "),
                    Expanded(
                      child: Text(
                        S.of(context)!.theirHelp,
                        textAlign: TextAlign.start,
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ), */
                kCommonSpaceV50,
                // kCommonSpaceV20,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButton(
                    width: kDeviceWidth / 1.3,
                    onPress: () {
                      if (isValid()) {
                        pushReplacement(const StateSelectionView());
                      }
                    },
                    label: S.of(context)!.accept,
                  ),
                ),
                kCommonSpaceV15,
              ],
            ),
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: kCommonAllBottomPadding,
        //   child: PrimaryButton(
        //     width: kDeviceWidth / 2,
        //     onPress: () {
        //       pushAndRemoveUntil(const WelcomeView());
        //     },
        //     label: S.of(context)!.accept,
        //   ),
        // ),
      ),
    );
  }

  bool isValid() {
    if (isCheckedTermsOfService == false) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectTs,
        color: CommonColors.mRed,
      );
      return false;
    } else if (isCheckedPrivacyPolicy == false) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectPrivacy,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

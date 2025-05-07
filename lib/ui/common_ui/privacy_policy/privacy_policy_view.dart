import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../app/app_model.dart';
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
    return SafeArea(
      child: ScaffoldBG(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Scaffold(
            backgroundColor: CommonColors.mTransparent,
            body: Center(
              child: SingleChildScrollView(
                padding: kCommonScreenPadding,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kCommonSpaceV10,
                      if (lang != "hi")
                        Text(
                          "Terms & Conditions*",
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      kCommonSpaceV20,
                      Text(
                        S.of(context)!.tcTitle,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight:
                              lang == "hi" ? FontWeight.w300 : FontWeight.w500,
                        ),
                      ),
                      kCommonSpaceV5,
                      kCommonSpaceV5,
                      Text(
                        S.of(context)!.tcSubtitle,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight:
                              lang == "hi" ? FontWeight.w300 : FontWeight.w500,
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
                          if (lang == "hi")
                            Expanded(
                              child: Text(
                                S.of(context)!.iHaveReadClue,
                                style: getAppStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                          if (lang != 'hi')
                            Text(
                              S.of(context)!.iHaveReadClue,
                              style: getAppStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          if (lang != 'hi')
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
            ),
          );
        }),
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

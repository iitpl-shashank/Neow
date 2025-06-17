import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../app/app_model.dart';
import 'signin_view_model.dart';

class SignInView extends StatefulWidget {
  final String userType;

  const SignInView({super.key, required this.userType});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late SignInViewModel mViewModel;
  late AudioPlayer player;
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPhoneNumber = false;

  @override
  void initState() {
    // player = AudioPlayer();
    // player.setAsset(LocalImages.au_aarti);
    // playAudio();
    mViewModel = Provider.of<SignInViewModel>(context, listen: false);
    mViewModel.userRoleId = widget.userType;
    log("USER type from previous :: ${widget.userType} || ${mViewModel.userRoleId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SignInViewModel>(context);
    return SafeArea(
      child: ScaffoldBG(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) {
                            return Image.asset(
                              (lang == "hi")
                                  ? LocalImages.login_background_hindi
                                  : LocalImages.login_background,
                              height: kDeviceHeight / 3,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(LocalImages.img_image_error);
                              },
                            );
                          },
                        ),
                        Container(
                          width: kDeviceWidth - 30,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            // color: const Color(0xFFEFE5FE).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              kCommonSpaceV10,
                              Padding(
                                padding: kCommonScreenPadding10,
                                child: Text(
                                  mViewModel.userRoleId == '3'
                                      ? S.of(context)!.welcomeBuddy
                                      : S.of(context)!.welcomeToNewYou,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: lang == "hi"
                                        ? FontWeight.w200
                                        : FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (mViewModel.userRoleId == '3')
                                Text(
                                  S.of(context)!.welcomeBuddySubtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CommonColors.greyText,
                                    fontSize: 14,
                                    fontWeight: lang == "hi"
                                        ? FontWeight.w200
                                        : FontWeight.w500,
                                  ),
                                ),
                              LabeledTextField(
                                maxLength: 10,
                                hintText: S.of(context)!.enterPhoneNumber,
                                controller: emailOrPhoneController,
                                inputType: TextInputType.phone,
                              ),
                              kCommonSpaceV50,
                              PrimaryButton(
                                width: kDeviceWidth / 1,
                                onPress: () async {
                                  print(
                                      "Language.......................${AppPreferences.instance.getLanguageCode()}");
                                  if (isValid()) {
                                    print(".......................IN 171");
                                    await mViewModel.checkDeviceTokenApi(
                                        mobile:
                                            emailOrPhoneController.text.trim());
                                    log('${mViewModel.isDeviceStatus}::mViewModel.isDeviceStatus==================');
                                    if (mViewModel.isDeviceStatus == "no") {
                                      mViewModel.verifyPhone(
                                        phoneNumber:
                                            emailOrPhoneController.text.trim(),
                                        context: context,
                                        onCodeSent: () {},
                                      );
                                    } else if (mViewModel.isDeviceStatus ==
                                        "yes") {
                                      mViewModel.removeDeviceTokenApi(
                                          mobile: emailOrPhoneController.text
                                              .trim());
                                      mViewModel.verifyPhone(
                                        phoneNumber:
                                            emailOrPhoneController.text.trim(),
                                        context: context,
                                        onCodeSent: () {},
                                      );
                                    }
                                  }
                                },
                                label: S.of(context)!.continueText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isValid() {
    if (emailOrPhoneController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterMobile,
        color: CommonColors.mRed,
      );
      return false;
    } else if (!CommonUtils.isvalidPhone(emailOrPhoneController.text.trim())) {
      CommonUtils.showSnackBar(S.of(context)!.plEnter10DigitsMobile,
          color: CommonColors.mRed);
      return false;
    }
    // else if (!isPhoneNumber && passwordController.text.trim().isEmpty) {
    //   CommonUtils.showSnackBar(
    //     S.of(context)!.plEnterPassword,
    //     color: CommonColors.mRed,
    //   );
    //   return false;
    // }
    else {
      return true;
    }
  }
}

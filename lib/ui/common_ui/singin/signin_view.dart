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

  // Future<void> playAudio() async {
  //   try {
  //     await player.play();
  //     player.playerStateStream.listen((state) {
  //       if (state.processingState == ProcessingState.completed) {
  //         player.seek(Duration.zero);
  //         player.play();
  //       }
  //     });
  //   } catch (e) {
  //     print("Error playing audio: $e");
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   player.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SignInViewModel>(context);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            /* Image.asset(
              LocalImages.img_sign_in_bg,
              height: kDeviceHeight / 1.850,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(LocalImages.img_image_error);
              },
            ), */
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* GifView.asset(
                      LocalImages.gif_naveli_aarati,
                      fit: BoxFit.cover,
                      width: kDeviceWidth / 1.8,
                    ), */
                    Image.asset(
                      LocalImages.login_background,
                      height: kDeviceHeight / 3,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(LocalImages.img_image_error);
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
                              S.of(context)!.welcomeToNewYou,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          LabeledTextField(
                            hintText: 'Enter your mobile number',
                            controller: emailOrPhoneController,
                            inputType: TextInputType.phone,
                            // onEditComplete: (text) {
                            //   setState(() {
                            //     isPhoneNumber =
                            //         RegExp(r'^[0-9]+$').hasMatch(text);
                            //   });
                            // },
                          ),
                          // kCommonSpaceV10,
                          // if (!isPhoneNumber) ...[
                          //   LabeledTextField(
                          //     hintText: S.of(context)!.password,
                          //     controller: passwordController,
                          //     isObscure: true,
                          //   ),
                          //   kCommonSpaceV10,
                          // ],
                          // InkWell(
                          //   onTap: () {
                          //     // push(BottomNavbarView());
                          //     push(SignupView(userType: widget.userType));
                          //   },
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Text(
                          //       S.of(context)!.dontHave,
                          //       style: getAppStyle(
                          //         color: CommonColors.primaryColor,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          kCommonSpaceV50,
                          PrimaryButton(
                            width: kDeviceWidth / 1,
                            onPress: () async {
                              print(
                                  "Language.......................${AppPreferences.instance.getLanguageCode()}");
                              if (isValid()) {
                                print(".......................IN 171");
                                await mViewModel.checkDeviceTokenApi(
                                    mobile: emailOrPhoneController.text.trim());
                                log('${mViewModel.isDeviceStatus}::mViewModel.isDeviceStatus==================');
                                if (mViewModel.isDeviceStatus == "no") {
                                  mViewModel.verifyPhone(
                                    phoneNumber:
                                        emailOrPhoneController.text.trim(),
                                    context: context,
                                    onCodeSent: () {},
                                  );
                                } else if (mViewModel.isDeviceStatus == "yes") {
                                  mViewModel.removeDeviceTokenApi(
                                      mobile:
                                          emailOrPhoneController.text.trim());
                                  mViewModel.verifyPhone(
                                    phoneNumber:
                                        emailOrPhoneController.text.trim(),
                                    context: context,
                                    onCodeSent: () {},
                                  );
                                  /* showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // backgroundColor: CommonColors.mTransparent,
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "This user has already logged in",
                                              textAlign: TextAlign.center,
                                              style: getAppStyle(
                                                  color: CommonColors.mRed,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              "Are you sure to want to relogin ?",
                                              textAlign: TextAlign.center,
                                              style: getAppStyle(
                                                  color:
                                                      CommonColors.primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                            kCommonSpaceV20,
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: PrimaryButton(
                                                    buttonColor:
                                                        CommonColors.mRed,
                                                    height: 40,
                                                    onPress: () {
                                                      Navigator.pop(context);
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    label: S.of(context)!.no,
                                                    labelColor:
                                                        CommonColors.blackColor,
                                                    lblSize: 15,
                                                  ),
                                                ),
                                                kCommonSpaceH10,
                                                Expanded(
                                                  child: PrimaryButton(
                                                    buttonColor:
                                                        CommonColors.greenColor,
                                                    height: 40,
                                                    onPress: () async {
                                                      await mViewModel
                                                          .removeDeviceTokenApi(
                                                              mobile:
                                                                  emailOrPhoneController
                                                                      .text
                                                                      .trim());
                                                      mViewModel.verifyPhone(
                                                        phoneNumber:
                                                            emailOrPhoneController
                                                                .text
                                                                .trim(),
                                                        context: context,
                                                        onCodeSent: () {},
                                                      );
                                                    },
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    label: S.of(context)!.yes,
                                                    lblSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ); */
                                }

                                ///

                                // mViewModel.verifyPhone(
                                //   phoneNumber:
                                //       emailOrPhoneController.text.trim(),
                                //   context: context,
                                //   onCodeSent: () {},
                                // );

                                ///

                                // if (!isPhoneNumber) {
                                //   mViewModel.loginApi(
                                //     email: emailOrPhoneController.text.trim(),
                                //     password: passwordController.text.trim(),
                                //   );
                                // } else {
                                //   mViewModel.verifyMobileApi(
                                //       mobile:
                                //           emailOrPhoneController.text.trim());
                                // }
                              }
                              // push(BottomNavbarView());
                            },
                            label: 'Continue',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text(
            //   S.of(context)!.signIn,
            //   style: getAppStyle(
            //     color: CommonColors.blackColor,
            //     fontSize: 25,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // kCommonSpaceV30,
            // LabeledTextField(
            //   hintText: S.of(context)!.emailOrPhone,
            //   controller: emailController,
            // ),
            // kCommonSpaceV10,
            // LabeledTextField(
            //   hintText: S.of(context)!.password,
            //   controller: passwordController,
            //   isObscure: true,
            // ),
            // kCommonSpaceV10,
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: InkWell(
            //     onTap: () {
            //       push(ForgotPsswrdView());
            //     },
            //     child: Text(
            //       "${S.of(context)!.forgotPassword}?",
            //       style: getAppStyle(
            //         color: CommonColors.secondaryColor,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            // kCommonSpaceV30,
            // PrimaryButton(
            //   onPress: () {
            //     push(OTPView());
            //   },
            //   label: S.of(context)!.signIn.toUpperCase(),
            // ),
            // kCommonSpaceV15,
            // InkWell(
            //   onTap: () {
            //     push(const SignupView());
            //   },
            //   child: Text(
            //     S.of(context)!.dontHave,
            //     style: getAppStyle(
            //       color: CommonColors.secondaryColor,
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
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

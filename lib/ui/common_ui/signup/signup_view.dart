import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/scaffold_bg.dart';
import 'signup_view_model.dart';

class SignupView extends StatefulWidget {
  final String userType;

  const SignupView({super.key, required this.userType});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late SignupViewModel mViewModel;

  final mEmailController = TextEditingController();
  final mPhoneController = TextEditingController();
  final mPasswordController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SignupViewModel>(context);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // kCommonSpaceV30,
            Image.asset(
              LocalImages.img_sign_in_bg,
              height: kDeviceHeight / 1.850,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(LocalImages.img_image_error);
              },
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      LocalImages.img_naveli_aarti,
                      // height: kDeviceHeight / 1.8,
                      width: kDeviceWidth / 1.8,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(LocalImages.img_image_error);
                      },
                    ),
                    Container(
                      // height: kDeviceHeight / 1.9,
                      width: kDeviceWidth / 1.1,
                      decoration: BoxDecoration(
                          color: const Color(0xFFEFE5FE).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            kCommonSpaceV10,
                            Text(
                              S.of(context)!.welcomeToNewYou,
                              style: GoogleFonts.piedra(
                                color: CommonColors.primaryColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            kCommonSpaceV10,
                            LabeledTextField(
                              hintText: S.of(context)!.email,
                              controller: mEmailController,
                            ),
                            kCommonSpaceV10,
                            LabeledTextField(
                              maxLength: 10,
                              inputType: TextInputType.phone,
                              hintText: S.of(context)!.phone,
                              controller: mPhoneController,
                            ),
                            kCommonSpaceV10,
                            LabeledTextField(
                              hintText: S.of(context)!.password,
                              controller: mPasswordController,
                              isObscure: true,
                            ),
                            kCommonSpaceV10,
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                // push(const SignInView());
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  S.of(context)!.alreadyHave,
                                  style: getAppStyle(
                                    color: CommonColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            kCommonSpaceV30,
                            PrimaryButton(
                              width: kDeviceWidth / 2,
                              onPress: () {
                                if (isValid()) {
                                  mViewModel.signUp(
                                    roleId: widget.userType,
                                    email: mEmailController.text.trim(),
                                    mobile: mPhoneController.text.trim(),
                                    password: mPasswordController.text.trim(),
                                  );
                                }
                              },
                              label: S.of(context)!.signUp,
                            ),
                            kCommonSpaceV10,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValid() {
    if (mEmailController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterEmail,
          color: CommonColors.mRed);
      return false;
    } else if (!CommonUtils.isvalidEmail(mEmailController.text.trim())) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterValidEmail,
          color: CommonColors.mRed);
      return false;
    } else if (mPhoneController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterMobile,
          color: CommonColors.mRed);
      return false;
    } else if (!CommonUtils.isvalidPhone(mPhoneController.text.trim())) {
      CommonUtils.showSnackBar(S.of(context)!.plEnter10DigitsMobile,
          color: CommonColors.mRed);
      return false;
    } else if (mPasswordController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterPassword,
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/singin/signin_view.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/primary_button.dart';
import 'forgot_psswrd_view_model.dart';

class ForgotPsswrdView extends StatefulWidget {
  const ForgotPsswrdView({super.key});

  @override
  State<ForgotPsswrdView> createState() => _ForgotPsswrdViewState();
}

class _ForgotPsswrdViewState extends State<ForgotPsswrdView> {
  late ForgotPsswrdViewModel mViewModel;

  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();
  final mIdController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ForgotPsswrdViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: kCommonAllBottomPadding,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              LocalImages.img_logo,
              height: 150,
              width: 150,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(LocalImages.img_image_error);
              },
            ),
            kCommonSpaceV20,
            Text(
              S.of(context)!.forgotPassword,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            kCommonSpaceV30,
            kCommonSpaceV20,
            LabeledTextField(
              hintText: S.of(context)!.email,
              controller: mEmailController,
            ),
            kCommonSpaceV30,
            PrimaryButton(
              onPress: () {
                push(const SignInView(userType: AppConstants.NEOWME));
              },
              label: S.of(context)!.submit.toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

// bool isValid() {
//   if (mEmailController.text.trim().isEmpty) {
//     CommonUtils.showSnackBar(
//       S.of(context)!.plEnterEmail,
//       color: CommonColors.mRed,
//     );
//     return false;
//   } else if (!CommonUtils.isvalidEmail(mEmailController.text.trim())) {
//     CommonUtils.showSnackBar(
//       S.of(context)!.plEnterValidEmail,
//       color: CommonColors.mRed,
//     );
//     return false;
//   } else if (mPasswordController.text.isEmpty) {
//     CommonUtils.showSnackBar(
//       S.of(context)!.plEnterPassword,
//       color: CommonColors.mRed,
//     );
//     return false;
//   } else {
//     return true;
//   }
// }
}

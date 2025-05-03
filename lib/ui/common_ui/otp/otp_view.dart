import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/app/app_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../widgets/primary_button.dart';
import '../singin/signin_view_model.dart';
import 'otp_view_model.dart';

class OTPView extends StatefulWidget {
  final String roleId;
  final String phoneNumber;
  final String verificationId;

  const OTPView({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.roleId,
  });

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> with CodeAutoFill {
  late OTPViewModel mViewModel;
  final otpController = TextEditingController();
  String otp = "";
  var phone;

  String? appSignature;
  String? otpCode;

  @override
  void initState() {
    super.initState();

    SmsAutoFill().listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });

    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.userRoleId = widget.roleId;
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<OTPViewModel>(context);

    return Scaffold(
      body: ScaffoldBG(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                kCommonSpaceV30,
                Text(
                  S.of(context)!.enterYourOtp,
                  style: TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 24,
                    fontWeight:
                        lang == "hi" ? FontWeight.w200 : FontWeight.w600,
                  ),
                ),
                kCommonSpaceV30,
                kCommonSpaceV20,
                PinFieldAutoFill(
                  controller: otpController,
                  decoration: BoxLooseDecoration(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    strokeColorBuilder: FixedColorBuilder(Colors.black),
                  ),
                  currentCode: otp,
                  onCodeSubmitted: (code) {
                    otp = code;
                  },
                  onCodeChanged: (code) {
                    setState(() {
                      otpController.text = code ?? "0";
                      otp = code ?? "0";
                    });
                  },
                ),
                kCommonSpaceV20,
                kCommonSpaceV20,
                mViewModel.second == 0
                    ? InkWell(
                        onTap: () {
                          mViewModel.startTimer();
                          widget.phoneNumber.contains("+91");
                          phone = widget.phoneNumber.substring(3);
                          // print(".......${phone}.......");
                          SignInViewModel().verifyPhone(
                            phoneNumber: phone,
                            context: context,
                            onCodeSent: () {},
                          );
                        },
                        child: Text(S.of(context)!.resendOtp,
                            style: getAppStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: CommonColors.secondaryColor,
                            )),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context)!.requestOtp,
                            textAlign: TextAlign.center,
                            style: getAppStyle(
                              fontSize: 16,
                              fontWeight: lang == "hi"
                                  ? FontWeight.w200
                                  : FontWeight.w600,
                              color: CommonColors.blackColor,
                            ),
                          ),
                          Text(
                            " ${mViewModel.second} ${S.of(context)!.seconds}",
                            textAlign: TextAlign.center,
                            style: getAppStyle(
                              fontSize: 16,
                              fontWeight: lang == "hi"
                                  ? FontWeight.w200
                                  : FontWeight.w600,
                              color: CommonColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                kCommonSpaceV50,
                PrimaryButton(
                  width: kDeviceWidth / 1.3,
                  onPress: () {
                    if (isValid()) {
                      mViewModel.checkOTP(
                        otp,
                        widget.verificationId,
                        widget.phoneNumber.contains("+91")
                            ? widget.phoneNumber.substring(3)
                            : widget.phoneNumber,
                      );
                    }
                    // pushAndRemoveUntil(PrivacyPolicyView());
                  },
                  label: S.of(context)!.continueText,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isValid() {
    if (otp.isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.enterYourOtp,
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }

  @override
  void codeUpdated() {
    setState(() {
      otp = code!;
      otpController.text = code!;
      debugPrint('otp $code');
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
    // controller.dispose();
  }
}

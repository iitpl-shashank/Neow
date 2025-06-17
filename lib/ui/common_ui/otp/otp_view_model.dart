import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../naveli_ui/profile/your_naveli/your_naveli_view_model.dart';
import '../singin/signin_view_model.dart';

class OTPViewModel with ChangeNotifier {
  late BuildContext context;
  String userRoleId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Timer? timer;
  int second = 60;

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
    startTimer();
  }

  Future<void> checkOTP(
      String code, String verificationId, String phone) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      CommonUtils.showProgressDialog();
      await _auth.signInWithCredential(credential);
      CommonUtils.hideProgressDialog();
      await SignInViewModel().loginApi(
          mobile: phone,
          roleId: int.parse(userRoleId),
          mViewModel: Provider.of<YourNaveliViewModel>(context, listen: false));
      print('OTP is correct');
    } catch (e) {
      print('OTP is wrong');
      CommonUtils.hideProgressDialog();
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterValidOtp,
        color: CommonColors.mRed,
      );
    }
  }

  void startTimer() {
    second = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (second == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          second--;
          notifyListeners();
        }
      },
    );
  }
}

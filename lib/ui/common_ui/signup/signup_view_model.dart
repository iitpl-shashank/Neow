import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../models/signup_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class SignupViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
  }

  Future<void> signUp({
    required String roleId,
    required String email,
    required String mobile,
    required String password,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, String> params = <String, String>{
      ApiParams.role_id: roleId,
      ApiParams.email: email,
      ApiParams.mobile: mobile,
      ApiParams.password: password,
    };
    SignupMaster? master = await _services.api!.signUp(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Sign Up oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.mRed,
      );
    } else if (master.success! && master.data != null) {
      CommonUtils.showSnackBar(master.message,
          color: CommonColors.primaryColor);
      Navigator.pop(mainNavKey.currentContext!);
    }
    notifyListeners();
  }
}

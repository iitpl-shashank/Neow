import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../models/common_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../naveli_ui/cycle_info/welcom_gif_view.dart';
import '../splash/splash_view_model.dart';

class WelcomeViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> verifyUniqueIdApi(
      {required String? uniqueId, required bool isFromCycle}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.unique_id: uniqueId,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.verifyUniqueId(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Welcome oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
      if (isFromCycle) {
        SplashViewModel().getUserDetails().whenComplete(
              () => pushAndRemoveUntil(
                const WelComeGifView(
                  isFromSplash: false,
                ),
              ),
            );
      } else {
        Navigator.pop(context);
      }
    }
    notifyListeners();
  }
}

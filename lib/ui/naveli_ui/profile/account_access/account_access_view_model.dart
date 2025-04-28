import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/buddy_request_master.dart';

import '../../../../models/common_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AccountAccessViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<BuddyRequestData>? buddyRequestDataList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> storeAccountAccessStatusApi({
    required bool? naveliResponse,
    required int? notificationId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.notification_id: notificationId,
      ApiParams.naveli_response: naveliResponse,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeNaveliAccountStatus(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................account access oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      getBuddyRequestApi();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      // Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future<void> getBuddyRequestApi() async {
    // CommonUtils.showProgressDialog();
    BuddyRequestMaster? master = await _services.api!.getBuddyRequestData();
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................account access oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      buddyRequestDataList = master.data ?? [];

      // print("Buddy Request list is :: ${buddyRequestDataList}");

      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

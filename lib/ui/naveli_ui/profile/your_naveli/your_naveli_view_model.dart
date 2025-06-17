import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../generated/i18n.dart';
import '../../../../models/buddy_already_send_request_master.dart';
import '../../../../models/user_details_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/global_variables.dart';

class YourNaveliViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<BuddyAlreadySendRequestData> buddyAlreadySendRequestDataList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getBuddyAlreadySendRequestApi() async {
    // CommonUtils.showProgressDialog();
    BuddyAlreadySendRequestMaster? master =
        await _services.api!.getBuddyAlreadySendRequestData();
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................your naveli oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      buddyAlreadySendRequestDataList = master.data ?? [];
      notifyListeners();

      // print("Buddy Request list is :: ${buddyRequestDataList}");

      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> getDataFromUidApi({
    required String? uniqueId,
  }) async {
    // CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.unique_id: uniqueId,
    };
    log("Accepted Unique ID: $uniqueId");
    UserDetailMaster? master =
        await _services.api!.getDataFromUniqueId(params: params);
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................your naveli oops.............................");
    } else if (master.success! && master.data != null) {
      // AppPreferences.instance.setUserDetails(jsonEncode(master.data));
      // globalUserMaster = master.data;
      globalUserMaster?.averageCycleLength = master.data?.averageCycleLength;
      globalUserMaster?.averagePeriodLength = master.data?.averagePeriodLength;
      globalUserMaster?.previousPeriodsBegin =
          master.data?.previousPeriodsBegin;
      globalUserMaster?.roleId = 3;
    } else if (!master.success!) {
      CommonUtils.showRedToastMessage(
        master.message ?? S.of(mainNavKey.currentContext!)!.userDataSyncFailed,
      );
    }
    notifyListeners();
  }
}

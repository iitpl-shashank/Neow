import 'dart:async';

import 'package:flutter/material.dart';

import '../../../services/index.dart';


class ForgotPsswrdViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();

  Future<void> attachedContext(BuildContext context) async {
    this.context = context;
  }

  // void loginApi({required userType, required email, required password}) async {
  //   CommonUtils.showProgressDialog();
  //   Map<String, dynamic> params = <String, dynamic>{
  //     ApiParams.email: email,
  //     ApiParams.password: password,
  //     ApiParams.user_type: userType,
  //   };
  //
  //   LoginMaster? master = await _services.api!.login(params: params);
  //   CommonUtils.hideProgressDialog();
  //   log("Master :: ${jsonEncode(master)}");
  //   if (master != null && master.success != null && master.success!) {
  //     CommonUtils.showSnackBar(
  //       master.message,
  //       color: CommonColors.greenColor,
  //     );
  //     AppPreferences.instance.setAccessToken(master.accessToken!);
  //     AppPreferences.instance.setUserDetails(jsonEncode(master.user));
  //     gUserType = master.user!.userType!;
  //     globalUserMaster = master.user;
  //     login(userType: master.user!.userType!);
  //   } else if (master != null) {
  //     CommonUtils.showSnackBar(
  //       master.message ?? "--",
  //       color: CommonColors.mRed,
  //     );
  //   } else {
  //     CommonUtils.oopsMSG();
  //   }
  //   notifyListeners();
  // }
  //
  // void login({required String userType}) {
  //   if (userType == AppConstants.customer) {
  //     pushAndRemoveUntil(const BottomNavbar());
  //   } else if (userType == AppConstants.measurer) {
  //     pushAndRemoveUntil(const AppointmentView());
  //   } else if (userType == AppConstants.seller) {
  //     pushAndRemoveUntil(const SellerDashboardView());
  //   } else if (userType == AppConstants.model) {
  //     pushAndRemoveUntil(const ModelListView());
  //   } else if (userType == AppConstants.repairStore) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //   } else if (userType == AppConstants.deliveryStore) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //   } else if (userType == AppConstants.physicalStore) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //   } else if (userType == AppConstants.manufacturer) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //   } else if (userType == AppConstants.ticketOwner) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //   } else if (userType == AppConstants.measurementRequester) {
  //     pushAndRemoveUntil(const CommonDashboardView());
  //     // pushAndRemoveUntil(const AppointmentListView());
  //   }
  // }
}

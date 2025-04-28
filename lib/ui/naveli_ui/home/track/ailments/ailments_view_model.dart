import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../../database/app_preferences.dart';
import '../../../../../generated/i18n.dart';
import '../../../../../models/common_master.dart';
import '../../../../../models/madication_master.dart';
import '../../../../../models/user_ailments_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/global_variables.dart';

class AilmentsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<MedicationData> ailmentList = [];
  List<String> storedOtherAilmentsList = [];
  List<String> userPreviousAilments = [];
  List<int?> selectedAilmentsIdList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAilmentListApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    CommonMedicationAilmentMaster? master =
        await _services.api!.getAilmentsName(params: params);
    CommonUtils.hideProgressDialog();
    if (master != null && master.success! && master.data != null) {
      ailmentList = master.data ?? [];
      await getStoredAilmentsListApi(true);
      // gUserSymptomsMaster = master.data;
    } else if (master != null && !master.success!) {
      CommonUtils.showSnackBar(
        master.message ?? S.of(mainNavKey.currentContext!)!.userDataSyncFailed,
        color: CommonColors.mRed,
      );
    }
    notifyListeners();
  }

  Future<void> getStoredAilmentsListApi(bool isAilmentsScreen) async {
    if (isAilmentsScreen) {
      CommonUtils.showProgressDialog();
    }
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    UserAilmentsMaster? master =
        await _services.api!.getStoredAilmentsDetail(params: params);

    if (isAilmentsScreen) {
      CommonUtils.hideProgressDialog();
    }

    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................ailments oops.............................");
    } else if (master.success! && master.data != null) {
      if (isAilmentsScreen) {
        updateSelectedAilmentsFromStored(master.data!.ailmentId ?? []);
      }
      if (master.data?.ailmentId != []) {
        master.data?.ailmentId?.forEach((ailment) {
          userPreviousAilments.add(ailment.name ?? '');
        });
      }
      storedOtherAilmentsList = master.data?.otherAilments ?? [];
      print(storedOtherAilmentsList);
      print("======================================== storedOtherAilmentsList");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    }
    notifyListeners();
  }

  void updateSelectedAilmentsFromStored(List<AilmentId> storedAilmentsIds) {
    for (AilmentId? storedId in storedAilmentsIds) {
      if (storedId != null) {
        final foundMedicine = ailmentList.firstWhere(
          (medicine) => medicine.id == storedId.id,
        );
        foundMedicine.isSelected = true;
      }
    }
    notifyListeners();
  }

  Future<void> storeUserAilmentsApi({
    required List<int?> medicationsId,
    List<String>? otherAilments,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.ailment_id: medicationsId,
      ApiParams.other_ailments: otherAilments,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeUserAilments(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................ailments oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      getAilmentListApi();
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );
    }
    notifyListeners();
  }
}

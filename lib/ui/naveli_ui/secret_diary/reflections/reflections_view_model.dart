import 'package:flutter/cupertino.dart';

import '../../../../models/reflection_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class ReflectionsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<ReflectionData>? reflectionData = [];
  String editText = '';
  int? isGratitudeComplete;
  int? isEditComplete;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getReflectionApi() async {
    CommonUtils.showProgressDialog();
    ReflectionMaster? master = await _services.api!.getReflection();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................reflection oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      reflectionData = master.data ?? [];
      editText = master.data?.first.edit ?? '';
      isGratitudeComplete = master.data?.first.isGratitudeComplete;
      isEditComplete = master.data?.first.isEditComplete;
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

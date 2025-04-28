import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/models/about_us_master.dart';

import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AboutUsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  AboutData? aboutData;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAboutUsApi() async {
    CommonUtils.showProgressDialog();
    AboutUsMaster? master = await _services.api!.getAboutUsDetails();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................about us oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      aboutData = master.data;
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

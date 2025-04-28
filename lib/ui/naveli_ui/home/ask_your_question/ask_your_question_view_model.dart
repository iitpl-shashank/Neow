import 'package:flutter/cupertino.dart';

import '../../../../models/ask_question_master.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class AskYourQuestionViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<AnswerData> answerList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getAdminAnswerApi() async {
    CommonUtils.showProgressDialog();
    AskQuestionMaster? master = await _services.api!.getAdminAnswer();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................ask your question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      answerList =
          master.data?.where((item) => item.questionAnswer != null).toList() ??
              [];

      // answerList = master.data;

      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

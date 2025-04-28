import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/constant.dart';

import '../../../../../database/app_preferences.dart';
import '../../../../../models/common_master.dart';
import '../../../../../models/question_answer_master.dart';
import '../../../../../models/quiz_question_master.dart';
import '../../../../../models/sub_question_master.dart';
import '../../../../../services/api_para.dart';
import '../../../../../services/index.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';

class QuizQuestionViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<QuestionData> questionsList = [];
  SubQuestionData? subQuestionData;
  List<AnswerData> storedAnswerList = [];
  List<int?> selectedQuestionIdList = [];
  List<int?> selectedAnswerIdList = [];
  List<int?> selectedSubQuestionIdList = [];
  List<int?> selectedSubAnswerIdList = [];
  List<String?> selectedOptionNameList = [];
  Map<int, String?> selectedOptionsMap = {};
  String? pmsMessage;
  String? pcoMessage;
  String? anemiaMessage;
  String? storedPmsMessage;
  String? storedPcoMessage;
  String? storedAnemiaMessage;
  final now = DateTime.now();
  int? selectedHirsutism1;
  int? selectedHirsutism2;
  int? selectedHirsutism3;
  int? selectedHirsutism4;
  int? selectedHirsutism5;
  int? selectedHirsutism6;
  int? selectedHirsutism7;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void setSelectedOption(int? questionId, String? selectedOption) {
    if (questionId != null) {
      selectedOptionsMap[questionId] = selectedOption;
      notifyListeners();
    }
  }

  void checkAlreadyFeelAnswer() {
    if (questionsList.length == storedAnswerList.length) {
      print("Question length :: ${questionsList.length}");
      print("Answer length :: ${storedAnswerList.length}");
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: Text(
              'You have already given this quiz, Try again next month',
              textAlign: TextAlign.center,
              style: getGoogleFontStyle(
                color: CommonColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> storeHirsutismApi({
    int? upperLips,
    int? chin,
    int? chest,
    int? upperBack,
    int? lowerBack,
    int? upperAbdomen,
    int? lowerAbdomen,
  }) async {
    // CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.date: DateFormat('yyyy-MM-dd').format(now),
      if (upperLips != null) ApiParams.upper_lips: upperLips,
      if (chin != null) ApiParams.chin: chin,
      if (chest != null) ApiParams.chest: chest,
      if (upperBack != null) ApiParams.upper_back: upperBack,
      if (lowerBack != null) ApiParams.lower_back: lowerBack,
      if (upperAbdomen != null) ApiParams.upper_abdomen: upperAbdomen,
      if (lowerAbdomen != null) ApiParams.lower_abdomen: lowerAbdomen,
    };
    log(params.toString());

    CommonMaster? master = await _services.api!.storeHirsutism(params: params);
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // getUserSymptomsLogApi();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    // notifyListeners();
  }

  Future<void> getSubQuestionApi({
    required int? optionId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.sub_option_id: optionId,
    };
    log(params.toString());
    SubQuestionMaster? master =
        await _services.api!.getSubQuestion(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      subQuestionData = master.data;
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> getQuestionAnswerApi() async {
    CommonUtils.showProgressDialog();
    QuestionAnswerMaster? master = await _services.api!.getQuestionAnswer();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      storedAnswerList = master.data ?? [];
      storedPcoMessage = master.pco;
      storedPmsMessage = master.pms;
      storedAnemiaMessage = master.anemia;
      checkAlreadyFeelAnswer();
    }
    notifyListeners();
  }

  Future<void> getQuizQuestionListApi(
      {required int? questionType, String? ageGroup}) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.question_type: questionType,
      ApiParams.age_group: ageGroup,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    QuizQuestionMaster? master =
        await _services.api!.getQuizQuestions(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      questionsList = master.data ?? [];
      getQuestionAnswerApi();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeQuestionAnswerApi({
    required List<int?> questionId,
    required List<int?> optionId,
    String? pms,
    String? pco,
    String? anemia,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.question_id: questionId,
      ApiParams.option_id: optionId,
      if (pmsMessage != null) ApiParams.pms: pms,
      if (pcoMessage != null) ApiParams.pco: pco,
      if (anemiaMessage != null) ApiParams.anemia: anemia,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeQuestionAnswer(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      // Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future<void> storeSubQuestionAnswerApi({
    required List<int?> subQuestionId,
    required List<int?> subOptionId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.sub_question_ids: subQuestionId,
      ApiParams.sub_option_ids: subOptionId,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeSubQuestionAnswer(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................quiz question oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
      // Navigator.of(context).pop();
    }
    notifyListeners();
  }
}

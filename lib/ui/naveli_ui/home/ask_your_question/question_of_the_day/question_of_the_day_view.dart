import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/ask_your_question/question_of_the_day/question_of_the_day_view_model.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_text_field.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/scaffold_bg.dart';

class QuestionOfTheDay extends StatefulWidget {
  const QuestionOfTheDay({super.key});

  @override
  State<QuestionOfTheDay> createState() => _QuestionOfTheDayState();
}

class _QuestionOfTheDayState extends State<QuestionOfTheDay> {
  final mNameController = TextEditingController();
  final mQuestionController = TextEditingController();
  late QuestionOfDayViewModel mViewModel;

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<QuestionOfDayViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.queOfDay,
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              LabelTextField(
                bgColor: CommonColors.primaryLite,
                hintText: S.of(context)!.enterYourName,
                controller: mNameController,
                isOnlyChar: true,
              ),
              kCommonSpaceV20,
              Container(
                width: kDeviceWidth / 1,
                height: kDeviceHeight / 6,
                decoration: ShapeDecoration(
                  color: CommonColors.primaryLite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      // color: Colors.orange,
                      height: kDeviceHeight / 7,
                      child: TextField(
                        controller: mQuestionController,
                        maxLines: null,
                        maxLength: 400,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          counterText: '',
                          hintStyle: getAppStyle(
                            color: CommonColors.mGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: 'Ask your question',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          '(Max. 400 letter)',
                          style: getAppStyle(
                            color: CommonColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryButton(
                    width: kDeviceWidth / 1.5,
                    onPress: () {
                      if(isValid()){
                        mViewModel.storeQuestionOfDayApi(
                            name: mNameController.text.trim(),
                            userQuestion: mQuestionController.text.trim());
                        mNameController.clear();
                        mQuestionController.clear();
                      }
                    },
                    label: S.of(context)!.submit,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (mNameController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterName,
        color: CommonColors.mRed,
      );
      return false;
    } else if (mQuestionController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plWriteQue,
          color: CommonColors.mRed);
      return false;
    }
    else {
      return true;
    }
  }
}

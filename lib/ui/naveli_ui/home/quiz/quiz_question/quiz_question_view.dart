import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_question/quiz_question_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../models/sub_question_master.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_qustion_container.dart';
import '../../../../../widgets/common_symptoms_widget.dart';
import '../../../../../widgets/primary_button.dart';

// extension ListExtension<T> on List<T> {
//   T? firstWhereOrNull(bool Function(T) test) {
//     for (final element in this) {
//       if (test(element)) {
//         return element;
//       }
//     }
//     return null;
//   }
// }

class QuizQuestionView extends StatefulWidget {
  final int? questionListId;
  final String? imageLink;
  final String? quizTitle;
  final String? ageGroup;

  const QuizQuestionView(
      {super.key,
      required this.questionListId,
      required this.imageLink,
      this.ageGroup,
      required this.quizTitle});

  @override
  State<QuizQuestionView> createState() => _QuizQuestionViewState();
}

class _QuizQuestionViewState extends State<QuizQuestionView> {
  late QuizQuestionViewModel mViewModel;
  int nonNullCount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getQuizQuestionListApi(
          questionType: widget.questionListId, ageGroup: widget.ageGroup);
      mViewModel.selectedOptionsMap.clear();
      mViewModel.selectedQuestionIdList.clear();
      mViewModel.selectedOptionNameList.clear();
      mViewModel.selectedAnswerIdList.clear();
      mViewModel.selectedSubQuestionIdList.clear();
      mViewModel.selectedSubAnswerIdList.clear();
      mViewModel.selectedHirsutism1 = null;
      mViewModel.selectedHirsutism2 = null;
      mViewModel.selectedHirsutism3 = null;
      mViewModel.selectedHirsutism4 = null;
      mViewModel.selectedHirsutism5 = null;
      mViewModel.selectedHirsutism6 = null;
      mViewModel.selectedHirsutism7 = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<QuizQuestionViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: widget.quizTitle,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: SizedBox(
                      // height:50,
                      width: kDeviceWidth - 60,
                      // padding:const EdgeInsets.only(left:10,right:10,),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // height:90,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),

                                      // height:60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF84CE2F),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(children: [
                                        Text(' ',
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        /* Text(' ',style:TextStyle(fontSize:20,)),
                                                    Text(' ',style:TextStyle(fontSize:20,)), */
                                      ]),
                                    ),
                                    Text('Not\nat all',
                                        style: TextStyle(fontSize: 12)),
                                  ]),
                            ),
                            SizedBox(
                              // height:90,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),

                                      // height:60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFB5D92F),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(children: [
                                        Text(' ',
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        /* Text(' ',style:TextStyle(fontSize:20,)),
                                                    Text(' ',style:TextStyle(fontSize:20,)), */
                                      ]),
                                    ),
                                    Text('A litle\n',
                                        style: TextStyle(fontSize: 12)),
                                  ]),
                            ),
                            SizedBox(
                              // height:90,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),

                                      // height:60,
                                      decoration: BoxDecoration(
                                        color: Color(0XFFF4C741),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(children: [
                                        Text(' ',
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        /* Text(' ',style:TextStyle(fontSize:20,)),
                                                    Text(' ',style:TextStyle(fontSize:20,)), */
                                      ]),
                                    ),
                                    Text('Moderately\n',
                                        style: TextStyle(fontSize: 12)),
                                  ]),
                            ),
                            SizedBox(
                              // height:90,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),

                                      // height:60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF4912E),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(children: [
                                        Text(' ',
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        /* Text(' ',style:TextStyle(fontSize:20,)),
                                                    Text(' ',style:TextStyle(fontSize:20,)), */
                                      ]),
                                    ),
                                    Text('Quite\n a bit',
                                        style: TextStyle(fontSize: 12)),
                                  ]),
                            ),
                            SizedBox(
                              // height:90,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),

                                      // height:60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFC81E2A),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(children: [
                                        Text(' ',
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        /* Text(' ',style:TextStyle(fontSize:20,)),
                                                    Text(' ',style:TextStyle(fontSize:20,)), */
                                      ]),
                                    ),
                                    Text('Extremely\n',
                                        style: TextStyle(fontSize: 14)),
                                  ]),
                            ),
                          ]))),
              kCommonSpaceV10,
              /* if (widget.questionListId == 1)
                Text(
                  "Answer the questions on PMS to better understand and manage your premenstrual symptoms. PMS is a combination of physical and emotional symptoms that typically occur in the days or weeks before menstruation",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (widget.questionListId == 2)
                Text(
                  "Answer the questions on PCOS to gain insights into your condition and manage symptoms effectively. PCOS, or Polycystic Ovary Syndrome, is a hormonal disorder characterized by irregular periods, excess androgen levels, and cysts on the ovaries",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (widget.questionListId == 3)
                Text(
                  "Answer questions on your health to gain tailored insights and optimize well-being.",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              if (widget.questionListId == 4)
                Text(
                  "Stay informed about anaemia symptoms like fatigue, weakness, and pale skin. Monitor these signs closely and take proactive steps to effectively manage your condition.",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ), */
              // kCommonSpaceV20,
              Container(
                // color:CommonColors.mWhite,
                decoration: ShapeDecoration(
                  color: CommonColors.mWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: ListView.builder(
                  itemCount: mViewModel.questionsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final question = mViewModel.questionsList[index];
                    // if (widget.ageGroup != null &&
                    //     question.ageGroup?.name != widget.ageGroup) {
                    //   return SizedBox.shrink();
                    // }
                    // // Find the stored answer for this question
                    // final storedAnswer = mViewModel.answerList?.firstWhereOrNull(
                    //       (answer) => answer.questionId == question?.id,
                    // );
                    //
                    // // Find the selected option for this question
                    // final selectedOption = storedAnswer != null
                    //     ? question?.options?.firstWhereOrNull(
                    //       (option) => option.optionId == storedAnswer.optionId,
                    // )
                    //     : null;
                    return CommonQuestionWidget(
                      index: index + 1,
                      question: question.questionName ?? '--',
                      options: question.options,
                      selectedOption:
                          mViewModel.selectedOptionsMap[question.id],
                      onOptionSelected: (String? value) {
                        mViewModel.setSelectedOption(question.id, value);
                        final selectedOptionObject = question.options
                            ?.firstWhere(
                                (option) => option.optionName == value);
                        if (widget.questionListId == 3) {
                          mViewModel
                              .getSubQuestionApi(
                                  optionId: selectedOptionObject?.optionId)
                              .whenComplete(() {
                            if (mViewModel.subQuestionData?.question != null &&
                                mViewModel.subQuestionData?.options != null) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, top: 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.cancel_rounded,
                                                color: Colors.red,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: CommonQuestionWidget(
                                            index: 1,
                                            question: mViewModel.subQuestionData
                                                    ?.question ??
                                                '',
                                            options: mViewModel
                                                .subQuestionData?.options,
                                            // selectedOption: mViewModel.selectedOptionsMap[question.id],
                                            onOptionSelected:
                                                (String? value) async {
                                              SubQuestionData? subQuestionData =
                                                  mViewModel.subQuestionData;

                                              SubQuestionOptions?
                                                  selectedOption =
                                                  subQuestionData?.options
                                                      ?.firstWhere(
                                                (option) =>
                                                    option.optionName == value,
                                              );

                                              if (selectedOption != null) {
                                                // Check if the question ID is already present in selectedSubQuestionIdList
                                                int existingQuestionIndex =
                                                    mViewModel
                                                        .selectedSubQuestionIdList
                                                        .indexOf(subQuestionData
                                                            ?.questionId);

                                                if (existingQuestionIndex !=
                                                    -1) {
                                                  // If the question ID is already present, update the answer at the same index
                                                  mViewModel.selectedSubAnswerIdList[
                                                          existingQuestionIndex] =
                                                      selectedOption.id!;
                                                } else {
                                                  // If the question ID is not present, add both question ID and answer to the lists
                                                  mViewModel
                                                      .selectedSubQuestionIdList
                                                      .add(subQuestionData
                                                          ?.questionId);
                                                  mViewModel
                                                      .selectedSubAnswerIdList
                                                      .add(selectedOption.id!);
                                                }
                                              }

                                              print(
                                                  "Selected Question IDs: ${mViewModel.selectedSubQuestionIdList}");
                                              print(
                                                  "Selected Answer IDs: ${mViewModel.selectedSubAnswerIdList}");

                                              // Call the API and wait for completion
                                              await mViewModel
                                                  .getSubQuestionApi(
                                                      optionId:
                                                          selectedOption?.id);
                                              Navigator.pop(context);
                                              // Check if notification is available and show dialog
                                              if (mViewModel.subQuestionData
                                                      ?.notification !=
                                                  null) {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      top: 8),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .cancel_rounded,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 28,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    bottom: 10),
                                                            child: Text(
                                                              mViewModel
                                                                      .subQuestionData
                                                                      ?.notification ??
                                                                  '',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  getGoogleFontStyle(
                                                                color: CommonColors
                                                                    .primaryColor,
                                                                fontSize: 23,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              // Check if question and options are available and show dialog
                                              else if (mViewModel
                                                          .subQuestionData
                                                          ?.question !=
                                                      null &&
                                                  mViewModel.subQuestionData
                                                          ?.options !=
                                                      null) {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 8,
                                                                      top: 8),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .cancel_rounded,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 28,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8,
                                                                    right: 8),
                                                            child:
                                                                CommonQuestionWidget(
                                                              index: 1,
                                                              question: mViewModel
                                                                      .subQuestionData
                                                                      ?.question ??
                                                                  '',
                                                              options: mViewModel
                                                                  .subQuestionData
                                                                  ?.options,
                                                              // selectedOption: mViewModel.selectedOptionsMap[question.id],
                                                              onOptionSelected:
                                                                  (String?
                                                                      value) async {
                                                                SubQuestionData?
                                                                    subQuestionData =
                                                                    mViewModel
                                                                        .subQuestionData;

                                                                SubQuestionOptions?
                                                                    selectedOption =
                                                                    subQuestionData
                                                                        ?.options
                                                                        ?.firstWhere(
                                                                  (option) =>
                                                                      option
                                                                          .optionName ==
                                                                      value,
                                                                );

                                                                if (selectedOption !=
                                                                    null) {
                                                                  // Check if the question ID is already present in selectedSubQuestionIdList
                                                                  int existingQuestionIndex = mViewModel
                                                                      .selectedSubQuestionIdList
                                                                      .indexOf(
                                                                          subQuestionData
                                                                              ?.questionId);

                                                                  if (existingQuestionIndex !=
                                                                      -1) {
                                                                    // If the question ID is already present, update the answer at the same index
                                                                    mViewModel.selectedSubAnswerIdList[
                                                                            existingQuestionIndex] =
                                                                        selectedOption
                                                                            .id!;
                                                                  } else {
                                                                    // If the question ID is not present, add both question ID and answer to the lists
                                                                    mViewModel
                                                                        .selectedSubQuestionIdList
                                                                        .add(subQuestionData
                                                                            ?.questionId);
                                                                    mViewModel
                                                                        .selectedSubAnswerIdList
                                                                        .add(selectedOption
                                                                            .id!);
                                                                  }
                                                                }

                                                                print(
                                                                    "Selected Question IDs: ${mViewModel.selectedSubQuestionIdList}");
                                                                print(
                                                                    "Selected Answer IDs: ${mViewModel.selectedSubAnswerIdList}");

                                                                await mViewModel
                                                                    .getSubQuestionApi(
                                                                        optionId:
                                                                            selectedOption?.id);
                                                                Navigator.pop(
                                                                    context);

                                                                if (mViewModel
                                                                        .subQuestionData
                                                                        ?.notification !=
                                                                    null) {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierDismissible:
                                                                        false,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      // Future.delayed(Duration(seconds: 3), () {
                                                                      //   Navigator.of(context).pop();
                                                                      // });
                                                                      return Dialog(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.topRight,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(right: 8, top: 8),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.cancel_rounded,
                                                                                    color: Colors.red,
                                                                                    size: 28,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                                                              child: Text(
                                                                                mViewModel.subQuestionData?.notification ?? '',
                                                                                textAlign: TextAlign.center,
                                                                                style: getGoogleFontStyle(
                                                                                  color: CommonColors.primaryColor,
                                                                                  fontSize: 23,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }

                                                                setState(() {
                                                                  int existingIndex = mViewModel
                                                                      .selectedQuestionIdList
                                                                      .indexOf(
                                                                          question
                                                                              .id);
                                                                  if (existingIndex !=
                                                                      -1) {
                                                                    // If the question ID is found, update the corresponding answer ID
                                                                    mViewModel.selectedAnswerIdList[
                                                                            existingIndex] =
                                                                        selectedOptionObject
                                                                            ?.optionId;
                                                                    if (selectedOptionObject?.optionName == "Yes" ||
                                                                        selectedOptionObject?.optionName ==
                                                                            "Medium" ||
                                                                        selectedOptionObject?.optionName ==
                                                                            "High") {
                                                                      mViewModel
                                                                              .selectedOptionNameList[existingIndex] =
                                                                          selectedOptionObject
                                                                              ?.optionName;
                                                                    } else {
                                                                      // If the new option is not "Yes", "Medium", or "High", remove the previous option from the list
                                                                      if (existingIndex <
                                                                          mViewModel
                                                                              .selectedOptionNameList
                                                                              .length) {
                                                                        mViewModel.selectedOptionNameList[existingIndex] =
                                                                            null;
                                                                      }
                                                                    }
                                                                  } else {
                                                                    // If the question ID is not found, add both the question ID and answer ID
                                                                    mViewModel
                                                                        .selectedQuestionIdList
                                                                        .add(selectedOptionObject
                                                                            ?.questionId);
                                                                    mViewModel
                                                                        .selectedAnswerIdList
                                                                        .add(selectedOptionObject
                                                                            ?.optionId);
                                                                    if (selectedOptionObject?.optionName == "Yes" ||
                                                                        selectedOptionObject?.optionName ==
                                                                            "Medium" ||
                                                                        selectedOptionObject?.optionName ==
                                                                            "High") {
                                                                      mViewModel
                                                                          .selectedOptionNameList
                                                                          .add(selectedOptionObject
                                                                              ?.optionName);
                                                                    } else {
                                                                      mViewModel
                                                                          .selectedOptionNameList
                                                                          .add(
                                                                              null);
                                                                    }
                                                                  }
                                                                });
                                                                print(mViewModel
                                                                    .selectedOptionNameList);
                                                                nonNullCount = mViewModel
                                                                    .selectedOptionNameList
                                                                    .where((element) =>
                                                                        element !=
                                                                        null)
                                                                    .length;
                                                                // print(nonNullCount);
                                                                print(mViewModel
                                                                    .selectedQuestionIdList);
                                                                print(mViewModel
                                                                    .selectedAnswerIdList);
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            if (mViewModel.subQuestionData?.notification !=
                                null) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  // Future.delayed(Duration(seconds: 3), () {
                                  //   Navigator.of(context).pop();
                                  // });
                                  return Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, top: 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.cancel_rounded,
                                                color: Colors.red,
                                                size: 28,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                          child: Text(
                                            mViewModel.subQuestionData
                                                    ?.notification ??
                                                '',
                                            textAlign: TextAlign.center,
                                            style: getGoogleFontStyle(
                                              color: CommonColors.primaryColor,
                                              fontSize: 23,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          });
                        }
                        setState(() {
                          int existingIndex = mViewModel.selectedQuestionIdList
                              .indexOf(question.id);
                          if (existingIndex != -1) {
                            // If the question ID is found, update the corresponding answer ID
                            mViewModel.selectedAnswerIdList[existingIndex] =
                                selectedOptionObject?.optionId;
                            if (selectedOptionObject?.optionName == "Yes" ||
                                selectedOptionObject?.optionName == "Medium" ||
                                selectedOptionObject?.optionName == "High") {
                              mViewModel.selectedOptionNameList[existingIndex] =
                                  selectedOptionObject?.optionName;
                            } else {
                              // If the new option is not "Yes", "Medium", or "High", remove the previous option from the list
                              if (existingIndex <
                                  mViewModel.selectedOptionNameList.length) {
                                mViewModel
                                        .selectedOptionNameList[existingIndex] =
                                    null;
                              }
                            }
                          } else {
                            // If the question ID is not found, add both the question ID and answer ID
                            mViewModel.selectedQuestionIdList
                                .add(selectedOptionObject?.questionId);
                            mViewModel.selectedAnswerIdList
                                .add(selectedOptionObject?.optionId);
                            if (selectedOptionObject?.optionName == "Yes" ||
                                selectedOptionObject?.optionName == "Medium" ||
                                selectedOptionObject?.optionName == "High") {
                              mViewModel.selectedOptionNameList
                                  .add(selectedOptionObject?.optionName);
                            } else {
                              mViewModel.selectedOptionNameList.add(null);
                            }
                          }
                        });
                        print(mViewModel.selectedOptionNameList);
                        nonNullCount = mViewModel.selectedOptionNameList
                            .where((element) => element != null)
                            .length;
                        // print(nonNullCount);
                        print(mViewModel.selectedQuestionIdList);
                        print(mViewModel.selectedAnswerIdList);
                      },
                    );
                  },
                ),
              ),

              kCommonSpaceV20,
              if (widget.questionListId == 2) ...[
                Text(
                  "Hirsutism Quiz :",
                  style: getAppStyle(fontSize: 20),
                ),
                kCommonSpaceV15,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism1 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                upperLips: mViewModel.selectedHirsutism1);
                          },
                          imagePath: LocalImages.img_hirsutism_1,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism1 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism1 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                upperLips: mViewModel.selectedHirsutism1);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_2,
                          isSelected: mViewModel.selectedHirsutism1 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism1 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                upperLips: mViewModel.selectedHirsutism1);
                          },
                          imagePath: LocalImages.img_hirsutism_3,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism1 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism1 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                upperLips: mViewModel.selectedHirsutism1);
                          },
                          imagePath: LocalImages.img_hirsutism_4,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism1 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism1 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                upperLips: mViewModel.selectedHirsutism1);
                          },
                          imagePath: LocalImages.img_hirsutism_5,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism1 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism2 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                chin: mViewModel.selectedHirsutism2);
                          },
                          imagePath: LocalImages.img_hirsutism_6,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism2 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism2 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                chin: mViewModel.selectedHirsutism2);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_7,
                          isSelected: mViewModel.selectedHirsutism2 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism2 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                chin: mViewModel.selectedHirsutism2);
                          },
                          imagePath: LocalImages.img_hirsutism_8,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism2 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism2 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                chin: mViewModel.selectedHirsutism2);
                          },
                          imagePath: LocalImages.img_hirsutism_9,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism2 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism2 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                chin: mViewModel.selectedHirsutism2);
                          },
                          imagePath: LocalImages.img_hirsutism_10,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism2 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism3 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                chest: mViewModel.selectedHirsutism3);
                          },
                          imagePath: LocalImages.img_hirsutism_11,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism3 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism3 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                chest: mViewModel.selectedHirsutism3);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_12,
                          isSelected: mViewModel.selectedHirsutism3 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism3 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                chest: mViewModel.selectedHirsutism3);
                          },
                          imagePath: LocalImages.img_hirsutism_13,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism3 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism3 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                chest: mViewModel.selectedHirsutism3);
                          },
                          imagePath: LocalImages.img_hirsutism_14,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism3 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism3 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                chest: mViewModel.selectedHirsutism3);
                          },
                          imagePath: LocalImages.img_hirsutism_15,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism3 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism4 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                upperBack: mViewModel.selectedHirsutism4);
                          },
                          imagePath: LocalImages.img_hirsutism_16,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism4 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism4 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                upperBack: mViewModel.selectedHirsutism4);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_17,
                          isSelected: mViewModel.selectedHirsutism4 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism4 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                upperBack: mViewModel.selectedHirsutism4);
                          },
                          imagePath: LocalImages.img_hirsutism_18,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism4 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism4 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                upperBack: mViewModel.selectedHirsutism4);
                          },
                          imagePath: LocalImages.img_hirsutism_19,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism4 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism4 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                upperBack: mViewModel.selectedHirsutism4);
                          },
                          imagePath: LocalImages.img_hirsutism_20,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism4 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism5 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerBack: mViewModel.selectedHirsutism5);
                          },
                          imagePath: LocalImages.img_hirsutism_21,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism5 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism5 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerBack: mViewModel.selectedHirsutism5);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_22,
                          isSelected: mViewModel.selectedHirsutism5 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism5 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerBack: mViewModel.selectedHirsutism5);
                          },
                          imagePath: LocalImages.img_hirsutism_23,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism5 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism5 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerBack: mViewModel.selectedHirsutism5);
                          },
                          imagePath: LocalImages.img_hirsutism_24,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism5 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism5 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerBack: mViewModel.selectedHirsutism5);
                          },
                          imagePath: LocalImages.img_hirsutism_25,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism5 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism6 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                upperAbdomen: mViewModel.selectedHirsutism6);
                          },
                          imagePath: LocalImages.img_hirsutism_26,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism6 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism6 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                upperAbdomen: mViewModel.selectedHirsutism6);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_27,
                          isSelected: mViewModel.selectedHirsutism6 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism6 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                upperAbdomen: mViewModel.selectedHirsutism6);
                          },
                          imagePath: LocalImages.img_hirsutism_28,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism6 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism6 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                upperAbdomen: mViewModel.selectedHirsutism6);
                          },
                          imagePath: LocalImages.img_hirsutism_29,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism6 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism6 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                upperAbdomen: mViewModel.selectedHirsutism6);
                          },
                          imagePath: LocalImages.img_hirsutism_30,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism6 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                IntrinsicHeight(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism7 = 1;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerAbdomen: mViewModel.selectedHirsutism7);
                          },
                          imagePath: LocalImages.img_hirsutism_31,
                          underText: "1",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism7 == 1,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism7 = 2;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerAbdomen: mViewModel.selectedHirsutism7);
                          },
                          underText: "2",
                          isUnderText: true,
                          imagePath: LocalImages.img_hirsutism_32,
                          isSelected: mViewModel.selectedHirsutism7 == 2,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism7 = 3;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerAbdomen: mViewModel.selectedHirsutism7);
                          },
                          imagePath: LocalImages.img_hirsutism_33,
                          underText: "3",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism7 == 3,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism7 = 4;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerAbdomen: mViewModel.selectedHirsutism7);
                          },
                          imagePath: LocalImages.img_hirsutism_34,
                          underText: "4",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism7 == 4,
                        ),
                        CommonSymptomsWidget(
                          onTap: () {
                            setState(() {
                              mViewModel.selectedHirsutism7 = 5;
                            });
                            mViewModel.storeHirsutismApi(
                                lowerAbdomen: mViewModel.selectedHirsutism7);
                          },
                          imagePath: LocalImages.img_hirsutism_35,
                          underText: "5",
                          isUnderText: true,
                          isSelected: mViewModel.selectedHirsutism7 == 5,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV30,
              ],
              Center(
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  onPress: () {
                    // selectedQuestionIdList.clear();
                    // selectedAnswerIdList.clear();
                    if (isValid()) {
                      if (widget.questionListId == 1) {
                        if (nonNullCount >= 9 && nonNullCount < 13) {
                          mViewModel.pmsMessage =
                              "Yes, you might have symptoms of PMS";
                        } else if (nonNullCount >= 13) {
                          mViewModel.pmsMessage =
                              "Yes, you have few symptoms of PMS.";
                        } else if (nonNullCount < 9) {
                          mViewModel.pmsMessage = "You are going great";
                        }
                      }
                      if (widget.questionListId == 2) {
                        if (nonNullCount > 2) {
                          mViewModel.pcoMessage =
                              "Yes, you might have symptoms of PCO";
                        } else if (nonNullCount == 2 || nonNullCount == 1) {
                          mViewModel.pcoMessage =
                              "You have few symptoms of PCO";
                        } else if (nonNullCount == 0) {
                          mViewModel.pcoMessage = "You are going great";
                        }
                      }
                      if (widget.questionListId == 4) {
                        if (nonNullCount >= 6) {
                          mViewModel.anemiaMessage =
                              "That you might be anaemic, kindly get tested";
                        } else if (nonNullCount <= 5) {
                          mViewModel.anemiaMessage =
                              "You do not display the typical signs of anaemia";
                        }
                      }

                      if (widget.questionListId == 1) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            // Future.delayed(Duration(seconds: 3), () {
                            //   Navigator.of(context).pop();
                            // });
                            return WillPopScope(
                              onWillPop: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                return false;
                              },
                              child: Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, top: 8),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.red,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (nonNullCount >= 9 && nonNullCount < 13)
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(children: [
                                            Container(
                                              // width: 70,

                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: CommonColors.mGrey300,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          CommonColors.mGrey)),
                                              child: Icon(
                                                Icons.speed,
                                                color:
                                                    CommonColors.primaryColor,
                                              ),
                                              /* Image.asset(
                                                LocalImages.img_alert,
                                                // width:kDeviceWidth/1.4,
                                                fit: BoxFit.cover,
                                              ) */
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 15,
                                                  bottom: 5),
                                              child: Text(
                                                'Moderate PMS Symptoms',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                'Consider tracking your symptoms and consult a healthcare provider if they impact your daily life',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            kCommonSpaceV30,
                                          ])

                                          /* Text(
                                          'Yes, you might have symptoms of PMS. May consult your doctor.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ), */
                                          ),
                                    if (nonNullCount >= 13)
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(children: [
                                            Container(
                                                // width: 70,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: CommonColors
                                                            .mGrey)),
                                                child: Image.asset(
                                                  LocalImages.img_alert,
                                                  // width:kDeviceWidth/1.4,
                                                  fit: BoxFit.cover,
                                                )),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 15,
                                                  bottom: 5),
                                              child: Text(
                                                'Severe PMS Symptoms',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                'Advisable to consult a healthcare provider for a comprehensive evaluation and possible treatment options.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            kCommonSpaceV30,
                                          ])

                                          /* Text(
                                          'Yes , you have few symptoms of PMS. May consult your doctor.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ), */
                                          ),
                                    if (nonNullCount < 9)
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(children: [
                                            Container(
                                              // width: 70,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: CommonColors.mGrey300,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          CommonColors.mGrey)),
                                              child: Icon(
                                                Icons.thumb_up,
                                                color:
                                                    CommonColors.primaryColor,
                                              ),
                                              /* Image.asset(
                                                LocalImages.img_alert,
                                                // width:kDeviceWidth/1.4,
                                                fit: BoxFit.cover,
                                              ) */
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 15,
                                                  bottom: 5),
                                              child: Text(
                                                'Minimal or no PMS Symptoms',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                'Your symptoms may not be significant.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            kCommonSpaceV30,
                                          ])
                                          /* Text(
                                          'You are going great. Come back every month to assess your health.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ), */
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (widget.questionListId == 2) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            // Future.delayed(Duration(seconds: 3), () {
                            //   Navigator.of(context).pop();
                            // });
                            return WillPopScope(
                              onWillPop: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                return false;
                              },
                              child: Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, top: 8),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.red,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (nonNullCount > 2)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'Yes, you might have symptoms of PCO. May consult your doctor.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    if (nonNullCount == 2 || nonNullCount == 1)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'You have few symptoms of PCO. May consult your doctor.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    if (nonNullCount == 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'You are going great. Come back every month to assess your health.',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    kCommonSpaceV10,
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (widget.questionListId == 4) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return WillPopScope(
                              onWillPop: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                return false;
                              },
                              child: Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, top: 8),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.red,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (nonNullCount >= 6)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'That you might be anaemic, kindly get tested',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    if (nonNullCount <= 5)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'You do not display the typical signs of anaemia',
                                          textAlign: TextAlign.center,
                                          style: getGoogleFontStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    kCommonSpaceV10,
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      mViewModel
                          .storeQuestionAnswerApi(
                              questionId: mViewModel.selectedQuestionIdList,
                              optionId: mViewModel.selectedAnswerIdList,
                              pms: mViewModel.pmsMessage,
                              pco: mViewModel.pcoMessage,
                              anemia: mViewModel.anemiaMessage)
                          .whenComplete(() {
                        if (mViewModel.selectedSubQuestionIdList != [] &&
                            mViewModel.selectedSubAnswerIdList != []) {
                          mViewModel.storeSubQuestionAnswerApi(
                            subQuestionId: mViewModel.selectedSubQuestionIdList,
                            subOptionId: mViewModel.selectedSubAnswerIdList,
                          );
                        }
                        //   else {
                        //     Navigator.pop(context);
                        //   }
                      });
                      mViewModel.pmsMessage = null;
                      mViewModel.pcoMessage = null;
                      mViewModel.anemiaMessage = null;
                    }
                  },
                  label: S.of(context)!.submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (mViewModel.questionsList.length !=
        mViewModel.selectedAnswerIdList.length) {
      print("***** ${mViewModel.questionsList.length}");
      print("***** ${mViewModel.selectedAnswerIdList.length}");
      CommonUtils.showSnackBar(
        S.of(context)!.plFeelAnswer,
        color: CommonColors.mRed,
      );
      return false;
    } else if (widget.questionListId == 2 &&
        (mViewModel.selectedHirsutism1 == null ||
            mViewModel.selectedHirsutism2 == null ||
            mViewModel.selectedHirsutism3 == null ||
            mViewModel.selectedHirsutism4 == null ||
            mViewModel.selectedHirsutism5 == null ||
            mViewModel.selectedHirsutism6 == null ||
            mViewModel.selectedHirsutism7 == null)) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectHirsutism,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

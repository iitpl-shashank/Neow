import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_question/quiz_question_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/widgets/profile_image_round.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/local_images.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late QuizViewModel mViewModel;
  String? _selectedAgeGroup;
  final List<Map<String, dynamic>> dataList = [
    {
      'image': LocalImages.img_medication,
      'text': 'PMS',
      'hint': 'Assess PMS symptoms and\nlearn coping strategies.',
    },
    {
      'image': LocalImages.img_ailments,
      'text': 'PCO',
      'hint': 'Understand your PCO risk\nfactors',
    },
    {
      'image': LocalImages.img_weight,
      'text': 'Anaemia',
      'hint': 'Know your risk factor for\n anaemia.',
    },
    {
      'image': LocalImages.img_bmi_calculator,
      'text': 'Mental Health',
      'hint': 'Evaluate your mental\nhealth.',
    },
    /* {
      'image': LocalImages.img_sleep,
      'text': S.of(mainNavKey.currentContext!)!.sleep,
      'hint':'Monitor your sleep patterns \nand quality.',
    },
    {
      'image': LocalImages.img_water,
      'text': S.of(mainNavKey.currentContext!)!.waterReminder,
      'hint':'Stay hydrated with \npersonlized reminders.',
    }, */
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getQuizCategoryApi();
      // startBlinkingAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<QuizViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        body: ListView.builder(
            itemCount: mViewModel.quizData.length,
            shrinkWrap: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                // padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mViewModel.quizData[index].name ?? '',
                      textAlign: TextAlign.left,
                      style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    kCommonSpaceV10,
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 0, left: 10, top: 0, bottom: 0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                          color: CommonColors.mWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                8)), // Border radius for all edges
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
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center the content
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Center vertically
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10), // Margin left for the dot
                              child: Icon(
                                Icons.circle, // Dot icon
                                size: 5, // Size of the dot
                                color: CommonColors
                                    .blackColor, // Adjust color as needed
                              ),
                            ),
                            SizedBox(
                                width: 5), // Space between the dot and text
                            Expanded(
                              child: Text(
                                mViewModel.quizData[index].description ?? '',
                                textAlign: TextAlign.left,
                                style: getAppStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kCommonSpaceV10,
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class AgeGroupRadio extends StatelessWidget {
  final String text;
  final String value;
  final bool selected;
  final ValueChanged<String>? onChanged;

  const AgeGroupRadio({
    super.key,
    required this.text,
    required this.value,
    required this.selected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Radio(
        value: value,
        groupValue: selected ? value : null,
        activeColor: CommonColors.primaryColor,
        onChanged: onChanged != null
            ? (String? newValue) {
                if (onChanged != null) {
                  onChanged!(newValue!);
                  // print('Selected age group: $text');
                }
              }
            : null,
      ),
    );
  }
}

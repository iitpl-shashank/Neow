import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_question/quiz_question_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
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
        appBar: CommonAppBar(
          title: "Let's Know You Better",
        ),
        body: ListView.builder(
            itemCount: mViewModel.quizData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 12, left: 12, top: 3, bottom: 8),
                child: Container(
                    // width: kDeviceWidth / 1,
                    // height: kDeviceHeight / 2.2,
                    clipBehavior: Clip.antiAlias,
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
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            push(
                              QuizQuestionView(
                                questionListId: mViewModel.quizData[index].id,
                                imageLink: mViewModel.quizData[index].icon,
                                quizTitle: mViewModel.quizData[index].name,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  push(
                                    QuizQuestionView(
                                      questionListId:
                                          mViewModel.quizData[index].id,
                                      imageLink:
                                          mViewModel.quizData[index].icon,
                                      quizTitle:
                                          mViewModel.quizData[index].name,
                                    ),
                                  );
                                  // push(PostList(position:0,selectedTabIndex:0));
                                },
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    /* Image.asset(
                                          dataList[index]['image'],
                                          // fit: BoxFit.cover,
                                          // height: kDeviceHeight / 6,
                                        ), */
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          mViewModel.quizData[index].icon ??
                                              ''),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              kCommonSpaceH10,
                              SizedBox(
                                /* decoration:BoxDecoration(
                                      border:Border.all(width: 1, color: CommonColors.mGrey),
                                    ), */
                                width: kDeviceWidth / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      mViewModel.quizData[index].name ?? '',
                                      style: getAppStyle(
                                        color: CommonColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    kCommonSpaceV10,
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              child: Text(
                                            mViewModel.quizData[index]
                                                    .description ??
                                                '',
                                            maxLines: 2,
                                            style: getAppStyle(
                                              color: CommonColors.blackColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                          // kCommonSpaceH10,
                                          /* SizedBox(
                                                height:20,
                                                child:Container(
                                                  padding:const EdgeInsets.only(left:5,),
                                                  child:Text(' ',style:TextStyle(fontSize:10,)),
                                                  decoration:BoxDecoration(
                                                    color:CommonColors.mGrey,
                                                    shape:BoxShape.circle,
                                                  )
                                                )
                                              ), */
                                          kCommonSpaceH10,
                                          kCommonSpaceH10,
                                          kCommonSpaceH10,
                                        ]),
                                  ],
                                ),
                              ),
                              kCommonSpaceH10,
                              Text(
                                '>',
                                style: getAppStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  // height: 0.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ))),
              );
            }),
        /* GridView.builder(
          padding: kCommonScreenPadding,
          itemCount: mViewModel.quizData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: kDeviceHeight / 7),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (mViewModel.quizData[index].id == 3) {
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const ListTile(
                                        title: Text('Select Age Group'),
                                      ),
                                      AgeGroupRadio(
                                        text: '9 to 15',
                                        value: '9 to 15',
                                        selected:
                                            _selectedAgeGroup == '9 to 15',
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedAgeGroup = value;
                                          });
                                        },
                                      ),
                                      AgeGroupRadio(
                                        text: '16 to 25',
                                        value: '16 to 25',
                                        selected:
                                            _selectedAgeGroup == '16 to 25',
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedAgeGroup = value;
                                          });
                                        },
                                      ),
                                      AgeGroupRadio(
                                        text: '26 to 45',
                                        value: '26 to 45',
                                        selected:
                                            _selectedAgeGroup == '26 to 45',
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedAgeGroup = value;
                                          });
                                        },
                                      ),
                                      AgeGroupRadio(
                                        text: '46 to 60',
                                        value: '46 to 60',
                                        selected:
                                            _selectedAgeGroup == '46 to 60',
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedAgeGroup = value;
                                          });
                                        },
                                      ),
                                      AgeGroupRadio(
                                        text: 'more than 60',
                                        value: 'more than 60',
                                        selected:
                                            _selectedAgeGroup == 'more than 60',
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedAgeGroup = value;
                                          });
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (_selectedAgeGroup != null) {
                                                push(
                                                  QuizQuestionView(
                                                    questionListId: mViewModel
                                                        .quizData[index].id,
                                                    imageLink: mViewModel
                                                        .quizData[index].icon,
                                                    quizTitle: mViewModel
                                                        .quizData[index].name,
                                                    ageGroup: _selectedAgeGroup,
                                                  ),
                                                ).then((value) =>
                                                    Navigator.pop(context));
                                                print(
                                                    "Age group is :: $_selectedAgeGroup");
                                              }
                                              // } else {
                                              //   CommonUtils.showSnackBar(
                                              //     "Please select your age group",
                                              //     color: CommonColors.mRed,
                                              //   );
                                              // }
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        push(
                          QuizQuestionView(
                            questionListId: mViewModel.quizData[index].id,
                            imageLink: mViewModel.quizData[index].icon,
                            quizTitle: mViewModel.quizData[index].name,
                          ),
                        );
                      }
                      print("ID is :: ${mViewModel.quizData[index].id}");
                    },
                    child: Container(
                      width: kDeviceWidth,
                      decoration: BoxDecoration(
                          color: const Color(0xFFEAE0EB).withOpacity(0.6),
                          // color: Colors.orange,
                          // image: DecorationImage(
                          //   image: NetworkImage("https://new-naveli.harmistechnology.com/public/images/uploads/QuestionType/FkxLJ.png"),
                          //   fit: BoxFit.contain
                          // ),
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                          // shadows: [
                          //   BoxShadow(
                          //     color: CommonColors.primaryColor,
                          //     blurRadius: 4,
                          //     offset: Offset(0, 4),
                          //     spreadRadius: 0,
                          //   )
                          // ],
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageContainer(
                          image: mViewModel.quizData[index].icon,
                        ),
                      ),
                      // CachedNetworkImage(
                      //   imageUrl: mViewModel.quizData[index].icon ?? '',
                      //   placeholder: (context, url) => CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => Icon(Icons.wifi_off),
                      // )),
                    ),
                  ),
                ),
                Text(
                  mViewModel.quizData[index].name ?? '',
                  style: getAppStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ), */
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

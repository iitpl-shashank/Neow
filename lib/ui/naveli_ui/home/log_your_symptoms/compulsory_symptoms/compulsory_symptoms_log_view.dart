import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/global_variables.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_symptoms_widget.dart';
import '../../../../../widgets/scaffold_bg.dart';
import '../log_your_symptoms_view_model.dart';

class CompulsorySymptomsLogView extends StatefulWidget {
  const CompulsorySymptomsLogView({super.key});

  @override
  State<CompulsorySymptomsLogView> createState() =>
      _CompulsorySymptomsLogViewState();
}

class _CompulsorySymptomsLogViewState extends State<CompulsorySymptomsLogView> {
  late LogYourSymptomsModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getUserSymptomsLogApi(
          date: globalUserMaster?.previousPeriodsBegin ?? '');
      // startBlinkingAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LogYourSymptomsModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.logYourSymptoms,
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.primaryColor,
          style: getGoogleFontStyle(
            color: CommonColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: PageView(
          controller: mViewModel.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Understand Your Body Better: Track Symptoms During Your Period",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: getAppStyle(
                      color: CommonColors.black87,
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  kCommonSpaceV20,
                  Container(
                    width: kDeviceWidth / 1.1,
                    decoration: ShapeDecoration(
                      // color: Color(0xFFEAE0EB).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // shadows: [
                      //   BoxShadow(
                      //       color: CommonColors.black12,
                      //       spreadRadius: 1,
                      //       blurRadius: 10)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Flow',
                              style: getGoogleFontStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: CommonColors.primaryColor),
                            ),
                          ),
                          kCommonSpaceV5,
                          const CommonSymptomsTitle(title: 'Staining'),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedStaining = 1;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     staining: mViewModel.selectedStaining,
                                    //     stainingScore: 1);
                                  },
                                  imagePath: LocalImages.img_staining_light,
                                  imgWidth: 40,
                                  imgHeight: 70,
                                  isBoxFit: true,
                                  underText: "Low",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedStaining == 1,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedStaining = 2;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     staining: mViewModel.selectedStaining,
                                    //     stainingScore: 5);
                                  },
                                  imagePath: LocalImages.img_staining_dark,
                                  imgWidth: 40,
                                  imgHeight: 70,
                                  isBoxFit: true,
                                  underText: "Medium",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedStaining == 2,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedStaining = 3;
                                      mViewModel.checkFlow();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();
                                    // mViewModel.userSymptomsLogApi(
                                    //     staining: mViewModel.selectedStaining,
                                    //     stainingScore: 20);
                                  },
                                  imagePath:
                                      LocalImages.img_staining_extra_dark,
                                  imgWidth: 40,
                                  imgHeight: 70,
                                  isBoxFit: true,
                                  underText: "High",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedStaining == 3,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedStaining = 1;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             staining: mViewModel.selectedStaining);
                          //       },
                          //       imagePath: LocalImages.img_staining_light,
                          //       isBoxFit: true,
                          //       imgWidth: 40,
                          //       imgHeight: 70,
                          //       isSelected: mViewModel.selectedStaining == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedStaining = 2;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             staining: mViewModel.selectedStaining);
                          //       },
                          //       imagePath: LocalImages.img_staining_dark,
                          //       isBoxFit: true,
                          //       imgWidth: 40,
                          //       imgHeight: 70,
                          //       isSelected: mViewModel.selectedStaining == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedStaining = 3;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             staining: mViewModel.selectedStaining);
                          //       },
                          //       imagePath:
                          //       LocalImages.img_staining_extra_dark,
                          //       isBoxFit: true,
                          //       imgWidth: 40,
                          //       imgHeight: 70,
                          //       isSelected: mViewModel.selectedStaining == 3,
                          //     ),
                          //   ],
                          // ),
                          const CommonSymptomsTitle(
                            title: 'Clot size',
                          ),
                          kCommonSpaceV10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CommonSymptomsWidget(
                                onTap: () {
                                  setState(() {
                                    mViewModel.selectedClotSize = 1;
                                    mViewModel.checkFlow();
                                  });
                                  if (mViewModel.count != 0) {
                                    mViewModel.count -= 1;
                                  }
                                  // mViewModel.userSymptomsLogApi(
                                  //     clotSize: mViewModel.selectedClotSize,
                                  //     clotSizeScore: 1);
                                },
                                imagePath: LocalImages.img_clot_small,
                                imgWidth: 53,
                                imgHeight: 50,
                                isBoxFit: true,
                                underText: "Small",
                                isUnderText: true,
                                isSelected: mViewModel.selectedClotSize == 1,
                              ),
                              CommonSymptomsWidget(
                                onTap: () {
                                  setState(() {
                                    mViewModel.selectedClotSize = 2;
                                    mViewModel.checkFlow();
                                  });
                                  if (mViewModel.count != 0) {
                                    mViewModel.count -= 1;
                                  }
                                  // mViewModel.userSymptomsLogApi(
                                  //     clotSize: mViewModel.selectedClotSize,
                                  //     clotSizeScore: 5);
                                },
                                imagePath: LocalImages.img_clot_medium,
                                imgWidth: 65,
                                imgHeight: 60,
                                isBoxFit: true,
                                underText: "Medium",
                                isUnderText: true,
                                isSelected: mViewModel.selectedClotSize == 2,
                              ),
                              CommonSymptomsWidget(
                                // height: 105,
                                onTap: () {
                                  setState(() {
                                    mViewModel.selectedClotSize = 3;
                                    mViewModel.checkFlow();

                                    mViewModel.count += 1;
                                  });
                                  // mViewModel.checkMoreThenThreeSelected();

                                  // mViewModel.userSymptomsLogApi(
                                  //     clotSize: mViewModel.selectedClotSize,
                                  //     clotSizeScore: 10);
                                },
                                imagePath: LocalImages.img_clot_large,
                                imgWidth: 75,
                                imgHeight: 70,
                                isBoxFit: true,
                                underText: "large",
                                isUnderText: true,
                                isSelected: mViewModel.selectedClotSize == 3,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedClotSize = 1;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             clotSize: mViewModel.selectedClotSize);
                          //       },
                          //       imagePath: LocalImages.img_clot_small,
                          //       isBoxFit: true,
                          //       imgWidth: 53,
                          //       imgHeight: 50,
                          //       isSelected: mViewModel.selectedClotSize == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedClotSize = 2;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             clotSize: mViewModel.selectedClotSize);
                          //       },
                          //       imagePath: LocalImages.img_clot_medium,
                          //       isBoxFit: true,
                          //       imgWidth: 65,
                          //       imgHeight: 60,
                          //       isSelected: mViewModel.selectedClotSize == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedClotSize = 3;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             clotSize: mViewModel.selectedClotSize);
                          //       },
                          //       imagePath: LocalImages.img_clot_large,
                          //       isBoxFit: true,
                          //       imgWidth: 75,
                          //       imgHeight: 70,
                          //       isSelected: mViewModel.selectedClotSize == 3,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // width: kDeviceWidth / 1.1,
                    decoration: ShapeDecoration(
                      // color: Color(0xFFEAE0EB).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // shadows: [
                      //   BoxShadow(
                      //       color: CommonColors.black12,
                      //       spreadRadius: 1,
                      //       blurRadius: 10)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSymptomsTitle(
                            title: 'Collection Method',
                            isMiddleTitle: true,
                          ),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCollection = 1;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     collectionMethod:
                                    //         mViewModel.selectedCollection);
                                  },
                                  underText: "Sanitary Pads",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_collection_1,
                                  isSelected:
                                      mViewModel.selectedCollection == 1,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCollection = 2;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     collectionMethod:
                                    //         mViewModel.selectedCollection);
                                  },
                                  underText: "Cloth",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_collection_2,
                                  isSelected:
                                      mViewModel.selectedCollection == 2,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCollection = 3;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     collectionMethod:
                                    //         mViewModel.selectedCollection);
                                  },
                                  underText: "Tampons",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_collection_3,
                                  isSelected:
                                      mViewModel.selectedCollection == 3,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCollection = 4;
                                      mViewModel.checkFlow();

                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();

                                    // mViewModel.userSymptomsLogApi(
                                    //     collectionMethod:
                                    //         mViewModel.selectedCollection);
                                  },
                                  underText: "Cups",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_collection_4,
                                  isSelected:
                                      mViewModel.selectedCollection == 4,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCollection = 1;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             collectionMethod: mViewModel.selectedCollection);
                          //       },
                          //       imagePath: LocalImages.img_collection_1,
                          //       isSelected:
                          //       mViewModel.selectedCollection == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCollection = 2;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             collectionMethod: mViewModel.selectedCollection);
                          //       },
                          //       imagePath: LocalImages.img_collection_2,
                          //       isSelected:
                          //       mViewModel.selectedCollection == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCollection = 3;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             collectionMethod: mViewModel.selectedCollection);
                          //       },
                          //       imagePath: LocalImages.img_collection_3,
                          //       isSelected:
                          //       mViewModel.selectedCollection == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCollection = 4;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             collectionMethod: mViewModel.selectedCollection);
                          //       },
                          //       imagePath: LocalImages.img_collection_4,
                          //       isSelected:
                          //       mViewModel.selectedCollection == 4,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // width: kDeviceWidth / 1.1,
                    decoration: ShapeDecoration(
                      // color: Color(0xFFEAE0EB).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // shadows: [
                      //   BoxShadow(
                      //       color: CommonColors.black12,
                      //       spreadRadius: 1,
                      //       blurRadius: 10)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonSymptomsTitle(
                            title: 'Frequency of Change in a Day',
                            isMiddleTitle: true,
                            isHintIcon: true,
                            dialogText:
                                "How many times you change your pad/ panty/ cup/ tampon/ others daily?",
                          ),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // CommonSymptomsWidget(
                                //   width: 95,
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedFrequency = 1;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         frequencyOfChangeDay: mViewModel.selectedFrequency);
                                //   },
                                //   isContainer: true,
                                //   title: '6',
                                //   bgColor: Color(0xFFF19199),
                                //   borderColor: Color(0xFFF21D00),
                                //   isSelected: mViewModel.selectedFrequency == 1,
                                // ),
                                // CommonSymptomsWidget(
                                //   width: 95,
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedFrequency = 2;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         frequencyOfChangeDay: mViewModel.selectedFrequency);
                                //   },
                                //   isContainer: true,
                                //   title: '5',
                                //   bgColor: Color(0xFFF19199),
                                //   borderColor: Color(0xFFF21D00),
                                //   isSelected: mViewModel.selectedFrequency == 2,
                                // ),
                                // CommonSymptomsWidget(
                                //   width: 95,
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedFrequency = 3;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         frequencyOfChangeDay: mViewModel.selectedFrequency);
                                //   },
                                //   isContainer: true,
                                //   title: '4',
                                //   bgColor: Color(0xFFF19199),
                                //   borderColor: Color(0xFFF21D00),
                                //   isSelected: mViewModel.selectedFrequency == 3,
                                // ),
                                // CommonSymptomsWidget(
                                //   width: 95,
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedFrequency = 4;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         frequencyOfChangeDay: mViewModel.selectedFrequency);
                                //   },
                                //   isContainer: true,
                                //   title: '2',
                                //   bgColor: Color(0xFFF19199),
                                //   borderColor: Color(0xFFF21D00),
                                //   isSelected: mViewModel.selectedFrequency == 4,
                                // ),
                                // CommonSymptomsWidget(
                                //   width: 95,
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedFrequency = 5;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         frequencyOfChangeDay: mViewModel.selectedFrequency);
                                //   },
                                //   isContainer: true,
                                //   title: '1',
                                //   bgColor: Color(0xFFF19199),
                                //   borderColor: Color(0xFFF21D00),
                                //   isSelected: mViewModel.selectedFrequency == 5,
                                // ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedFrequency = 1;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     frequencyOfChangeDay:
                                    //         mViewModel.selectedFrequency);
                                  },
                                  imagePath: LocalImages.img_frequency_4,
                                  imgHeight: 40,
                                  underText: "4",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedFrequency == 1,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedFrequency = 2;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     frequencyOfChangeDay:
                                    //         mViewModel.selectedFrequency);
                                  },
                                  imagePath: LocalImages.img_frequency_3,
                                  imgHeight: 40,
                                  underText: "3",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedFrequency == 2,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedFrequency = 3;
                                      mViewModel.checkFlow();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     frequencyOfChangeDay:
                                    //         mViewModel.selectedFrequency);
                                  },
                                  imagePath: LocalImages.img_frequency_2,
                                  imgHeight: 40,
                                  underText: "2",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedFrequency == 3,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedFrequency = 4;
                                      mViewModel.checkFlow();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();
                                    // mViewModel.userSymptomsLogApi(
                                    //     frequencyOfChangeDay:
                                    //         mViewModel.selectedFrequency);
                                  },
                                  imagePath: LocalImages.img_frequency_1,
                                  imgHeight: 40,
                                  underText: "1",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedFrequency == 4,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedFrequency = 1;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             frequencyOfChangeDay: mViewModel.selectedFrequency);
                          //       },
                          //       imagePath: LocalImages.img_frequency_4,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedFrequency == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedFrequency = 2;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             frequencyOfChangeDay: mViewModel.selectedFrequency);
                          //       },
                          //       imagePath: LocalImages.img_frequency_3,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedFrequency == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedFrequency = 3;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             frequencyOfChangeDay: mViewModel.selectedFrequency);
                          //       },
                          //       imagePath: LocalImages.img_frequency_2,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedFrequency == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedFrequency = 4;
                          //           mViewModel.checkFlow();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             frequencyOfChangeDay: mViewModel.selectedFrequency);
                          //       },
                          //       imagePath: LocalImages.img_frequency_1,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedFrequency == 4,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: kDeviceWidth / 1.1,
                    decoration: ShapeDecoration(
                      // color: Color(0xFFEAE0EB).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // shadows: [
                      //   BoxShadow(
                      //       color: CommonColors.black12,
                      //       spreadRadius: 1,
                      //       blurRadius: 10)
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Pain',
                              style: getGoogleFontStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: CommonColors.primaryColor),
                            ),
                          ),
                          kCommonSpaceV5,
                          const CommonSymptomsTitle(
                            title: 'Working ability',
                            isHintIcon: true,
                            dialogText:
                                "Capacity to perform tasks effectively while on periods",
                          ),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  // height: 98,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedWorkingAbility = 1;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     workingAbility:
                                    //         mViewModel.selectedWorkingAbility,
                                    //     workingAbilityScore: 0);
                                  },
                                  imagePath: LocalImages.img_working_4,
                                  // imgHeight: 70,
                                  underText: "Always",
                                  isUnderText: true,
                                  isSelected:
                                      mViewModel.selectedWorkingAbility == 1,
                                ),
                                CommonSymptomsWidget(
                                  // height: 116,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedWorkingAbility = 2;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     workingAbility:
                                    //         mViewModel.selectedWorkingAbility,
                                    //     workingAbilityScore: 1);
                                  },
                                  imagePath: LocalImages.img_working_3,
                                  // imgHeight: 70,
                                  underText: "Almost Always",
                                  isUnderText: true,
                                  isSelected:
                                      mViewModel.selectedWorkingAbility == 2,
                                ),
                                CommonSymptomsWidget(
                                  // height: 116,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedWorkingAbility = 3;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     workingAbility:
                                    //         mViewModel.selectedWorkingAbility,
                                    //     workingAbilityScore: 2);
                                  },
                                  imagePath: LocalImages.img_working_2,
                                  // imgHeight: 70,
                                  underText: "Almost Never",
                                  isUnderText: true,
                                  isSelected:
                                      mViewModel.selectedWorkingAbility == 3,
                                ),
                                CommonSymptomsWidget(
                                  // height: 98,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedWorkingAbility = 4;
                                      mViewModel.checkPain();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();
                                    // mViewModel.userSymptomsLogApi(
                                    //     workingAbility:
                                    //         mViewModel.selectedWorkingAbility,
                                    //     workingAbilityScore: 3);
                                  },
                                  imagePath: LocalImages.img_working_1,
                                  // imgHeight: 70,
                                  underText: "None",
                                  isUnderText: true,
                                  isSelected:
                                      mViewModel.selectedWorkingAbility == 4,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedWorkingAbility = 1;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             workingAbility: mViewModel.selectedWorkingAbility);
                          //       },
                          //       imgHeight: 70,
                          //       imagePath: LocalImages.img_working_4,
                          //       isSelected: mViewModel.selectedWorkingAbility == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedWorkingAbility = 2;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             workingAbility: mViewModel.selectedWorkingAbility);
                          //       },
                          //       imgHeight: 70,
                          //       imagePath: LocalImages.img_working_3,
                          //       isSelected: mViewModel.selectedWorkingAbility == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedWorkingAbility = 3;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             workingAbility: mViewModel.selectedWorkingAbility);
                          //       },
                          //       imgHeight: 70,
                          //       imagePath: LocalImages.img_working_2,
                          //       isSelected: mViewModel.selectedWorkingAbility == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedWorkingAbility = 4;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             workingAbility: mViewModel.selectedWorkingAbility);
                          //       },
                          //       imgHeight: 70,
                          //       imagePath: LocalImages.img_working_1,
                          //       isSelected: mViewModel.selectedWorkingAbility == 4,
                          //     ),
                          //   ],
                          // ),
                          const CommonSymptomsTitle(
                              title: 'Location',
                              isHintIcon: true,
                              dialogText:
                                  "Period pain can occur in various locations including the lower abdomen, lower back,thighs, etc. How many places does it hurt?"),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  // height: 115,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedLocation = 1;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     location: mViewModel.selectedLocation,
                                    //     locationScore: 0);
                                  },
                                  imagePath: LocalImages.img_location_1,
                                  isUnderText: true,
                                  underText: "None",
                                  imgHeight: 80,
                                  isSelected: mViewModel.selectedLocation == 1,
                                ),
                                CommonSymptomsWidget(
                                  // height: 115,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedLocation = 2;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     location: mViewModel.selectedLocation,
                                    //     locationScore: 1);
                                  },
                                  isUnderText: true,
                                  imagePath: LocalImages.img_location_2,
                                  underText: "1",
                                  imgHeight: 80,
                                  isSelected: mViewModel.selectedLocation == 2,
                                ),
                                CommonSymptomsWidget(
                                  // height: 115,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedLocation = 3;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     location: mViewModel.selectedLocation,
                                    //     locationScore: 2);
                                  },
                                  imagePath: LocalImages.img_location_3,
                                  underText: "2-3",
                                  isUnderText: true,
                                  imgHeight: 80,
                                  isSelected: mViewModel.selectedLocation == 3,
                                ),
                                CommonSymptomsWidget(
                                  // height: 115,
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedLocation = 4;
                                      mViewModel.checkPain();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();

                                    // mViewModel.userSymptomsLogApi(
                                    //     location: mViewModel.selectedLocation,
                                    //     locationScore: 3);
                                  },
                                  isUnderText: true,
                                  imagePath: LocalImages.img_location_4,
                                  underText: "4",
                                  imgHeight: 80,
                                  isSelected: mViewModel.selectedLocation == 4,
                                ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedLocation = 1;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         location: mViewModel.selectedLocation);
                                //   },
                                //   isContainer: true,
                                //   title: 'None',
                                //   bgColor: Color(0xFF91EDFB),
                                //   borderColor: Color(0xFF57E5FE),
                                //   isSelected: mViewModel.selectedLocation == 1,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedLocation = 2;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         location: mViewModel.selectedLocation);
                                //   },
                                //   isContainer: true,
                                //   title: '1',
                                //   bgColor: Color(0xFF91EDFB),
                                //   borderColor: Color(0xFF57E5FE),
                                //   isSelected: mViewModel.selectedLocation == 2,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedLocation = 3;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         location: mViewModel.selectedLocation);
                                //   },
                                //   isContainer: true,
                                //   title: '2-3',
                                //   bgColor: Color(0xFF91EDFB),
                                //   borderColor: Color(0xFF57E5FE),
                                //   isSelected: mViewModel.selectedLocation == 3,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedLocation = 4;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         location: mViewModel.selectedLocation);
                                //   },
                                //   isContainer: true,
                                //   title: '4',
                                //   bgColor: Color(0xFF91EDFB),
                                //   borderColor: Color(0xFF57E5FE),
                                //   isSelected: mViewModel.selectedLocation == 4,
                                // ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       height: 115,
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedLocation = 1;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             location: mViewModel.selectedLocation);
                          //       },
                          //       imagePath: LocalImages.img_location_1,
                          //       isUnderText: true,
                          //       underText: "0",
                          //       imgHeight: 80,
                          //       isSelected: mViewModel.selectedLocation == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       height: 115,
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedLocation = 2;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             location: mViewModel.selectedLocation);
                          //       },
                          //       isUnderText: true,
                          //       imagePath: LocalImages.img_location_2,
                          //       underText: "1",
                          //       imgHeight: 80,
                          //       isSelected: mViewModel.selectedLocation == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       height: 115,
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedLocation = 3;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             location: mViewModel.selectedLocation);
                          //       },
                          //       isUnderText: true,
                          //       imagePath: LocalImages.img_location_3,
                          //       underText: "2-3",
                          //       imgHeight: 80,
                          //       isSelected: mViewModel.selectedLocation == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       height: 115,
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedLocation = 4;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             location: mViewModel.selectedLocation);
                          //       },
                          //       isUnderText: true,
                          //       imagePath: LocalImages.img_location_4,
                          //       underText: "4",
                          //       imgHeight: 80,
                          //       isSelected: mViewModel.selectedLocation == 4,
                          //     ),
                          //     // CommonSymptomsWidget(
                          //     //   height: 95,
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedLocation = 1;
                          //     //       mViewModel.checkPain();
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         location: mViewModel.selectedLocation);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: 'None',
                          //     //   bgColor: Color(0xFF91EDFB),
                          //     //   borderColor: Color(0xFF57E5FE),
                          //     //   isSelected: mViewModel.selectedLocation == 1,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   height: 95,
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedLocation = 2;
                          //     //       mViewModel.checkPain();
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         location: mViewModel.selectedLocation);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '1',
                          //     //   bgColor: Color(0xFF91EDFB),
                          //     //   borderColor: Color(0xFF57E5FE),
                          //     //   isSelected: mViewModel.selectedLocation == 2,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   height: 95,
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedLocation = 3;
                          //     //       mViewModel.checkPain();
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         location: mViewModel.selectedLocation);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '2-3',
                          //     //   bgColor: Color(0xFF91EDFB),
                          //     //   borderColor: Color(0xFF57E5FE),
                          //     //   isSelected: mViewModel.selectedLocation == 3,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   height: 95,
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedLocation = 4;
                          //     //       mViewModel.checkPain();
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         location: mViewModel.selectedLocation);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '4',
                          //     //   bgColor: Color(0xFF91EDFB),
                          //     //   borderColor: Color(0xFF57E5FE),
                          //     //   isSelected: mViewModel.selectedLocation == 4,
                          //     // ),
                          //   ],
                          // ),
                          const CommonSymptomsTitle(
                            title: 'Cramps',
                          ),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCramps = 1;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     cramps: mViewModel.selectedCramps,
                                    //     periodCrampsScore: 0);
                                  },
                                  underText: "No Hurt",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_cramps_1,
                                  isSelected: mViewModel.selectedCramps == 1,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCramps = 2;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     cramps: mViewModel.selectedCramps,
                                    //     periodCrampsScore: 1);
                                  },
                                  underText: "Hurts Little bit",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_cramps_2,
                                  isSelected: mViewModel.selectedCramps == 2,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCramps = 3;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     cramps: mViewModel.selectedCramps,
                                    //     periodCrampsScore: 2);
                                  },
                                  underText: "Hurts More",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_cramps_3,
                                  isSelected: mViewModel.selectedCramps == 3,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedCramps = 4;
                                      mViewModel.checkPain();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();
                                    // mViewModel.userSymptomsLogApi(
                                    //     cramps: mViewModel.selectedCramps,
                                    //     periodCrampsScore: 3);
                                  },
                                  underText: "Hurts Worst",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_cramps_4,
                                  isSelected: mViewModel.selectedCramps == 4,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCramps = 1;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             cramps: mViewModel.selectedCramps);
                          //       },
                          //       imagePath: LocalImages.emoji_sleep,
                          //       isSelected: mViewModel.selectedCramps == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCramps = 2;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             cramps: mViewModel.selectedCramps);
                          //       },
                          //       imagePath: LocalImages.emoji_sleep,
                          //       isSelected: mViewModel.selectedCramps == 2,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCramps = 3;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             cramps: mViewModel.selectedCramps);
                          //       },
                          //       imagePath: LocalImages.emoji_sleep,
                          //       isSelected: mViewModel.selectedCramps == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedCramps = 4;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             cramps: mViewModel.selectedCramps);
                          //       },
                          //       imagePath: LocalImages.emoji_sleep,
                          //       isSelected: mViewModel.selectedCramps == 4,
                          //     ),
                          //   ],
                          // ),
                          const CommonSymptomsTitle(
                            title: 'Days',
                            isHintIcon: true,
                            dialogText:
                                "How many days you experience severe pain?",
                          ),
                          kCommonSpaceV10,
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedDays = 1;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     days: mViewModel.selectedDays,
                                    //     daysScore: 0);
                                  },
                                  imagePath: LocalImages.img_days_1,
                                  imgHeight: 40,
                                  underText: "0",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedDays == 1,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedDays = 2;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     days: mViewModel.selectedDays,
                                    //     daysScore: 1);
                                  },
                                  imgHeight: 40,
                                  underText: "1-2",
                                  isUnderText: true,
                                  imagePath: LocalImages.img_days_2,
                                  isSelected: mViewModel.selectedDays == 2,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedDays = 3;
                                      mViewModel.checkPain();
                                    });
                                    if (mViewModel.count != 0) {
                                      mViewModel.count -= 1;
                                    }
                                    // mViewModel.userSymptomsLogApi(
                                    //     days: mViewModel.selectedDays,
                                    //     daysScore: 2);
                                  },
                                  imagePath: LocalImages.img_days_3,
                                  imgHeight: 40,
                                  underText: "3-4",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedDays == 3,
                                ),
                                CommonSymptomsWidget(
                                  onTap: () {
                                    setState(() {
                                      mViewModel.selectedDays = 4;
                                      mViewModel.checkPain();
                                      mViewModel.count += 1;
                                    });
                                    // mViewModel.checkMoreThenThreeSelected();

                                    // mViewModel.userSymptomsLogApi(
                                    //     days: mViewModel.selectedDays,
                                    //     daysScore: 3);
                                  },
                                  imagePath: LocalImages.img_days_4,
                                  imgHeight: 40,
                                  underText: "5 or 5+",
                                  isUnderText: true,
                                  isSelected: mViewModel.selectedDays == 4,
                                ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedDays = 1;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         days: mViewModel.selectedDays);
                                //   },
                                //   isContainer: true,
                                //   title: '0',
                                //   bgColor: Color(0xFFFBBDFD),
                                //   borderColor: Color(0xFFF98FFF),
                                //   isSelected: mViewModel.selectedDays == 1,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedDays = 2;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         days: mViewModel.selectedDays);
                                //   },
                                //   isContainer: true,
                                //   title: '1-2',
                                //   bgColor: Color(0xFFFBBDFD),
                                //   borderColor: Color(0xFFF98FFF),
                                //   isSelected: mViewModel.selectedDays == 2,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedDays = 3;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         days: mViewModel.selectedDays);
                                //   },
                                //   isContainer: true,
                                //   title: '3-4',
                                //   bgColor: Color(0xFFFBBDFD),
                                //   borderColor: Color(0xFFF98FFF),
                                //   isSelected: mViewModel.selectedDays == 3,
                                // ),
                                // CommonSymptomsWidget(
                                //   onTap: () {
                                //     setState(() {
                                //       mViewModel.selectedDays = 4;
                                //     });
                                //     mViewModel.userSymptomsLogApi(
                                //         days: mViewModel.selectedDays);
                                //   },
                                //   isContainer: true,
                                //   title: '5',
                                //   bgColor: Color(0xFFFBBDFD),
                                //   borderColor: Color(0xFFF98FFF),
                                //   isSelected: mViewModel.selectedDays == 4,
                                // ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedDays = 1;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             days: mViewModel.selectedDays);
                          //       },
                          //       imagePath: LocalImages.img_days_1,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedDays == 1,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedDays = 2;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             days: mViewModel.selectedDays);
                          //       },
                          //       imagePath: LocalImages.img_days_2,
                          //       isSelected: mViewModel.selectedDays == 2,
                          //     ),
                          //     kCommonSpaceH10,
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedDays = 3;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             days: mViewModel.selectedDays);
                          //       },
                          //       imagePath: LocalImages.img_days_3,
                          //       isSelected: mViewModel.selectedDays == 3,
                          //     ),
                          //     CommonSymptomsWidget(
                          //       onTap: () {
                          //         setState(() {
                          //           mViewModel.selectedDays = 4;
                          //           mViewModel.checkPain();
                          //         });
                          //         mViewModel.userSymptomsLogApi(
                          //             days: mViewModel.selectedDays);
                          //       },
                          //       imagePath: LocalImages.img_days_4,
                          //       imgHeight: 40,
                          //       isSelected: mViewModel.selectedDays == 4,
                          //     ),
                          //     // CommonSymptomsWidget(
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedDays = 1;
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         days: mViewModel.selectedDays);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '0',
                          //     //   bgColor: Color(0xFFFBBDFD),
                          //     //   borderColor: Color(0xFFF98FFF),
                          //     //   isSelected: mViewModel.selectedDays == 1,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedDays = 2;
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         days: mViewModel.selectedDays);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '1-2',
                          //     //   bgColor: Color(0xFFFBBDFD),
                          //     //   borderColor: Color(0xFFF98FFF),
                          //     //   isSelected: mViewModel.selectedDays == 2,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedDays = 3;
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         days: mViewModel.selectedDays);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '3-4',
                          //     //   bgColor: Color(0xFFFBBDFD),
                          //     //   borderColor: Color(0xFFF98FFF),
                          //     //   isSelected: mViewModel.selectedDays == 3,
                          //     // ),
                          //     // CommonSymptomsWidget(
                          //     //   onTap: () {
                          //     //     setState(() {
                          //     //       mViewModel.selectedDays = 4;
                          //     //     });
                          //     //     mViewModel.userSymptomsLogApi(
                          //     //         days: mViewModel.selectedDays);
                          //     //   },
                          //     //   isContainer: true,
                          //     //   title: '5',
                          //     //   bgColor: Color(0xFFFBBDFD),
                          //     //   borderColor: Color(0xFFF98FFF),
                          //     //   isSelected: mViewModel.selectedDays == 4,
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

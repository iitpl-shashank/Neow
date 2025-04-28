import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view.dart';
import 'package:provider/provider.dart';

import '../../../../models/common_master.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_symptoms_widget.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../../../widgets/primary_button.dart';
import 'log_your_symptoms_view_model.dart';

class LogYourSymptoms extends StatefulWidget {
  const LogYourSymptoms({super.key});

  @override
  State<LogYourSymptoms> createState() => _LogYourSymptomsState();
}

class _LogYourSymptomsState extends State<LogYourSymptoms>
    with SingleTickerProviderStateMixin {
  late LogYourSymptomsModel mViewModel;
  late AnimationController animationController;

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
  void showDysmenorrheaDialog(BuildContext context) {
    debugPrint("showDysmenorrheaDialog");
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 340, // Custom dimensions, responsive if needed
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dysmenorrhea",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "(severe pain)",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 16),

                /// Image and speech bubble
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      'assets/images/ic_server_img.png',
                      height: 160,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Description
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Possible cause may be:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// Bulleted list
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• Fibroids"),
                      Text("• Endometriosis"),
                      Text("• Pelvic Infections"),
                      Text("• Cyst"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// CTA
                const Text(
                  "Get examined today!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showheavyFlow(BuildContext context) {
    debugPrint("showDysmenorrheaDialog");
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 340, // Custom dimensions, responsive if needed
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Heavy menstrual bleeding",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),


                const SizedBox(height: 16),

                /// Image and speech bubble
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      'assets/images/ic_heavy.png',
                      height: 160,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Description
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Possible cause may be:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// Bulleted list
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("• Fibroids"),
                      Text("• Cyst"),
                      Text("• Endometrial Polyps"),
                      Text("• Cancer"),

                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// CTA
                const Text(
                  "Get examined today!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  // void startBlinkingAnimation() {
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 1000),
  //   );
  //
  //   animationController.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       blinkCount++;
  //       if (blinkCount < 3) {
  //         animationController.reverse();
  //       } else {
  //         setState(() {
  //           showImage = false; // Hide the image after blinking process completes
  //         });
  //       }
  //     } else if (status == AnimationStatus.dismissed && blinkCount < 3) {
  //       animationController.forward();
  //     }
  //   });
  //
  //   animationController.forward();
  // }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LogYourSymptomsModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mWhite,
        appBar: CommonAppBar(
          title: '',
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.primaryColor,
          style: TextStyle(
            color: CommonColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Text(
                S.of(context)!.underStandYourBody,
                textAlign: TextAlign.center,
                style: getAppStyle(
                  color: CommonColors.black87,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV20, */
              Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context)!.flow,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CommonColors.blackColor),
                ),
              ),
              kCommonSpaceV5,
              CommonSymptomsTitle(
                title: S.of(context)!.staining,
              ),
              kCommonSpaceV10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonSymptomsWidget(
                    onTap: () {
                      setState(() {
                        mViewModel.selectedStaining = 1;
                      });
                      if (mViewModel.count != 0) {
                        mViewModel.count -= 1;
                      }
                      mViewModel.userSymptomsLogApi(
                          staining: mViewModel.selectedStaining,
                          stainingScore: 1);
                    },
                    imagePath: LocalImages.img_staining_light,
                    imgWidth: 40,
                    imgHeight: 70,
                    isBoxFit: false,
                    underText: S.of(context)!.low,
                    isUnderText: true,
                    isSelected: mViewModel.selectedStaining == 1,
                  ),
                  kCommonSpaceH10,
                  kCommonSpaceH10,
                  CommonSymptomsWidget(
                    onTap: () {
                      setState(() {
                        mViewModel.selectedStaining = 2;
                      });
                      if (mViewModel.count != 0) {
                        mViewModel.count -= 1;
                      }
                      mViewModel.userSymptomsLogApi(
                          staining: mViewModel.selectedStaining,
                          stainingScore: 5);
                    },
                    imagePath: LocalImages.img_staining_dark,
                    imgWidth: 40,
                    imgHeight: 70,
                    isBoxFit: false,
                    underText: S.of(context)!.medium,
                    isUnderText: true,
                    isSelected: mViewModel.selectedStaining == 2,
                  ),
                  kCommonSpaceH10,
                  kCommonSpaceH10,
                  CommonSymptomsWidget(
                    onTap: () {
                      showheavyFlow(context);
                      setState(() {
                        mViewModel.selectedStaining = 3;
                        mViewModel.count += 1;
                      });
                      //// mViewModel.checkMoreThenThreeSelected();
                      mViewModel.userSymptomsLogApi(
                          staining: mViewModel.selectedStaining,
                          stainingScore: 20);
                    },
                    imagePath: LocalImages.img_staining_extra_dark,
                    imgWidth: 40,
                    imgHeight: 70,
                    isBoxFit: false,
                    underText: S.of(context)!.high,
                    isUnderText: true,
                    isSelected: mViewModel.selectedStaining == 3,
                  ),
                ],
              ),
              CommonSymptomsTitle(
                title: S.of(context)!.clotSize,
              ),
              kCommonSpaceV10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonSymptomsWidget(
                    onTap: () {
                      setState(() {
                        mViewModel.selectedClotSize = 1;
                      });
                      if (mViewModel.count != 0) {
                        mViewModel.count -= 1;
                      }
                      mViewModel.userSymptomsLogApi(
                          clotSize: mViewModel.selectedClotSize,
                          clotSizeScore: 1);
                    },
                    imagePath: LocalImages.img_clot_small,
                    imgWidth: 35,
                    imgHeight: 30,
                    isBoxFit: false,
                    underText: S.of(context)!.small,
                    isUnderText: true,
                    isSelected: mViewModel.selectedClotSize == 1,
                  ),
                  kCommonSpaceH10,
                  kCommonSpaceH10,
                  CommonSymptomsWidget(
                    onTap: () {
                      setState(() {
                        mViewModel.selectedClotSize = 2;
                      });
                      if (mViewModel.count != 0) {
                        mViewModel.count -= 1;
                      }
                      mViewModel.userSymptomsLogApi(
                          clotSize: mViewModel.selectedClotSize,
                          clotSizeScore: 5);
                    },
                    imagePath: LocalImages.img_clot_medium,
                    imgWidth: 55,
                    imgHeight: 50,
                    isBoxFit: false,
                    underText: S.of(context)!.medium,
                    isUnderText: true,
                    // isContainer:true,
                    isSelected: mViewModel.selectedClotSize == 2,
                  ),
                  kCommonSpaceH10,
                  kCommonSpaceH10,
                  CommonSymptomsWidget(
                    // height: 105,
                    onTap: () {
                      setState(() {
                        mViewModel.selectedClotSize = 3;
                        mViewModel.count += 1;
                      });
                      mViewModel.checkMoreThenThreeSelected();
                      mViewModel.userSymptomsLogApi(
                          clotSize: mViewModel.selectedClotSize,
                          clotSizeScore: 10);
                    },
                    imagePath: LocalImages.img_clot_large,
                    imgWidth: 65,
                    imgHeight: 60,
                    isBoxFit: false,
                    underText: S.of(context)!.large,
                    isUnderText: true,
                    isSelected: mViewModel.selectedClotSize == 3,
                  ),
                ],
              ),
              kCommonSpaceV30,
              Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context)!.pain,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CommonColors.blackColor),
                ),
              ),
              kCommonSpaceV15,
              CommonSymptomsTitle(
                title: S.of(context)!.workingAbility,
                isHintIcon: true,
                dialogText: S.of(context)!.capacityToPerform,
              ),
              kCommonSpaceV10,
              IntrinsicHeight(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonSymptomsWidget(
                        // height: 98,
                        onTap: () {
                          setState(() {
                            mViewModel.selectedWorkingAbility = 1;
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              workingAbility: mViewModel.selectedWorkingAbility,
                              workingAbilityScore: 0);
                        },
                        imagePath: LocalImages.img_working_4,
                        // imgHeight: 70,
                        underText: 'Very\nActive',
                        isUnderText: true,
                        isSelected: mViewModel.selectedWorkingAbility == 1,
                      ),
                      kCommonSpaceH15,
                      CommonSymptomsWidget(
                        // height: 116,
                        onTap: () {
                          setState(() {
                            mViewModel.selectedWorkingAbility = 2;
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              workingAbility: mViewModel.selectedWorkingAbility,
                              workingAbilityScore: 1);
                        },
                        imagePath: LocalImages.img_working_3,
                        // imgHeight: 70,
                        underText: 'Active\n',
                        isUnderText: true,
                        isSelected: mViewModel.selectedWorkingAbility == 2,
                      ),
                      kCommonSpaceH15,
                      CommonSymptomsWidget(
                        // height: 116,
                        onTap: () {
                          setState(() {
                            mViewModel.selectedWorkingAbility = 3;
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              workingAbility: mViewModel.selectedWorkingAbility,
                              workingAbilityScore: 1);
                        },
                        imagePath: LocalImages.img_working_2,
                        // imgHeight: 70,
                        underText: 'Somewhat\nActive',
                        isUnderText: true,
                        isSelected: mViewModel.selectedWorkingAbility == 3,
                      ),
                      kCommonSpaceH15,
                      CommonSymptomsWidget(
                        // height: 116,
                        onTap: () {
                          setState(() {
                            mViewModel.selectedWorkingAbility = 4;
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              workingAbility: mViewModel.selectedWorkingAbility,
                              workingAbilityScore: 1);
                        },
                        imagePath: LocalImages.img_working_1,
                        // imgHeight: 70,
                        underText: 'inactive\n',
                        isUnderText: true,
                        isSelected: mViewModel.selectedWorkingAbility == 4,
                      ),
                    ],
                  ),
                ),
              ),
              CommonSymptomsTitle(
                  title: S.of(context)!.location,
                  isHintIcon: true,
                  dialogText: S.of(context)!.periodPainCan),
              kCommonSpaceV10,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        setState(() {
                          mViewModel.selectedLocation = 6;
                          //mViewModel.count += 1;
                          if (mViewModel.selectedLocationArray!.contains(6)) {
                            mViewModel.selectedLocationArray?.remove(6);
                          } else {
                            mViewModel.selectedLocationArray=[];
                            mViewModel.selectedLocationArray?.add(6);
                          }
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            location: mViewModel.selectedLocation,
                            locationScore: 6);
                      },
                      isUnderText: true,
                      imagePath: null,
                      underText: "none",
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(6),
                    ),
                    kCommonSpaceH10,
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        if (!mViewModel.selectedLocationArray!.contains(6)) {
                          setState(() {
                            mViewModel.selectedLocation = 1;
                            if (mViewModel.selectedLocationArray!.contains(1)) {
                              mViewModel.selectedLocationArray?.remove(1);
                            } else {
                              mViewModel.selectedLocationArray?.add(1);
                            }
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              location: mViewModel.selectedLocation,
                              locationScore: 0);
                        }
                      },
                      imagePath: LocalImages.img_location_1,
                      isUnderText: true,
                      underText: 'Headache',
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(1),
                    ),
                    kCommonSpaceH10,
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        if (!mViewModel.selectedLocationArray!.contains(6)) {
                          setState(() {
                            mViewModel.selectedLocation = 2;

                            if (mViewModel.selectedLocationArray!.contains(2)) {
                              mViewModel.selectedLocationArray?.remove(2);
                            } else {
                              mViewModel.selectedLocationArray?.add(2);
                            }
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              location: mViewModel.selectedLocation,
                              locationScore: 1);
                        }
                      },
                      isUnderText: true,
                      imagePath: LocalImages.img_location_2,
                      underText: "Backache",
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(2),
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
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        if (!mViewModel.selectedLocationArray!.contains(6)) {
                          setState(() {
                            mViewModel.selectedLocation = 3;
                            if (mViewModel.selectedLocationArray!.contains(3)) {
                              mViewModel.selectedLocationArray?.remove(3);
                            } else {
                              mViewModel.selectedLocationArray?.add(3);
                            }
                          });
                          if (mViewModel.count != 0) {
                            mViewModel.count -= 1;
                          }
                          mViewModel.userSymptomsLogApi(
                              location: mViewModel.selectedLocation,
                              locationScore: 2);
                        }
                      },
                      imagePath: LocalImages.img_location_3,
                      underText: "Leg Pain",
                      isUnderText: true,
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(3),
                    ),
                    kCommonSpaceH10,
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        if (!mViewModel.selectedLocationArray!.contains(6)) {
                          setState(() {
                            mViewModel.selectedLocation = 4;
                            mViewModel.count += 1;

                            if (mViewModel.selectedLocationArray!.contains(4)) {
                              mViewModel.selectedLocationArray?.remove(4);
                            } else {
                              mViewModel.selectedLocationArray?.add(4);
                            }
                          });
                          mViewModel.checkMoreThenThreeSelected();
                          mViewModel.userSymptomsLogApi(
                              location: mViewModel.selectedLocation,
                              locationScore: 5);
                        }
                      },
                      isUnderText: true,
                      imagePath: LocalImages.img_location_4,
                      underText: "Abdominal Pain",
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(4),
                    ),
                    kCommonSpaceH10,
                    CommonSymptomsBadge(
                      // height: 115,
                      onTap: () {
                        if (!mViewModel.selectedLocationArray!.contains(6)) {
                          setState(() {
                            mViewModel.selectedLocation = 5;
                            mViewModel.count += 1;

                            if (mViewModel.selectedLocationArray!.contains(5)) {
                              mViewModel.selectedLocationArray?.remove(5);
                            } else {
                              mViewModel.selectedLocationArray?.add(5);
                            }
                          });
                          mViewModel.checkMoreThenThreeSelected();
                          mViewModel.userSymptomsLogApi(
                              location: mViewModel.selectedLocation,
                              locationScore: 3);
                        }
                      },
                      isUnderText: true,
                      imagePath: null,
                      underText: "Other",
                      imgHeight: 80,
                      isSelected: mViewModel.selectedLocationArray!.contains(5),
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
              CommonSymptomsTitle(
                title: S.of(context)!.periodCramps,
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
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            cramps: mViewModel.selectedCramps,
                            periodCrampsScore: 0);
                      },
                      underText: S.of(context)!.noHurt,
                      isUnderText: true,
                      imagePath: LocalImages.img_cramps_1,
                      isSelected: mViewModel.selectedCramps == 1,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedCramps = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            cramps: mViewModel.selectedCramps,
                            periodCrampsScore: 1);
                      },
                      underText: S.of(context)!.hurtLittleBit,
                      isUnderText: true,
                      imagePath: LocalImages.img_cramps_2,
                      isSelected: mViewModel.selectedCramps == 2,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedCramps = 3;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            cramps: mViewModel.selectedCramps,
                            periodCrampsScore: 2);
                      },
                      underText: S.of(context)!.hurtMore,
                      isUnderText: true,
                      imagePath: LocalImages.img_cramps_3,
                      isSelected: mViewModel.selectedCramps == 3,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        showDysmenorrheaDialog(context);
                        setState(() {
                          mViewModel.selectedCramps = 4;
                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            cramps: mViewModel.selectedCramps,
                            periodCrampsScore: 3);
                      },
                      underText: S.of(context)!.hurtWorst,
                      isUnderText: true,
                      imagePath: LocalImages.img_cramps_4,
                      isSelected: mViewModel.selectedCramps == 4,
                    ),
                  ],
                ),
              ),
              CommonSymptomsTitle(
                title: "${S.of(context)!.days} of Pain",
                isHintIcon: true,
                dialogText: S.of(context)!.howManyDays,
              ),
              kCommonSpaceV10,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedDays = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            days: mViewModel.selectedDays, daysScore: 0);
                      },
                      imgHeight: 40,
                      underText: "0",
                      isUnderText: true,
                      isSelected: mViewModel.selectedDays == 1,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedDays = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            days: mViewModel.selectedDays, daysScore: 1);
                      },
                      imgHeight: 40,
                      underText: "1-2",
                      isUnderText: true,
                      isSelected: mViewModel.selectedDays == 2,
                    ),
                    /*CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedDays = 3;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            days: mViewModel.selectedDays, daysScore: 1);
                      },
                      imgHeight: 40,
                      underText: "2-3",
                      isUnderText: true,
                      isSelected: mViewModel.selectedDays == 3,
                    ),*/
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedDays = 4;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            days: mViewModel.selectedDays, daysScore: 2);
                      },
                      imgHeight: 40,
                      underText: "3-4",
                      isUnderText: true,
                      isSelected: mViewModel.selectedDays == 4,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedDays = 5;
                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            days: mViewModel.selectedDays, daysScore: 3);
                      },
                      imgHeight: 40,
                      underText: "5+",
                      isUnderText: true,
                      isSelected: mViewModel.selectedDays == 5,
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
              kCommonSpaceV10,
              /* CommonSymptomsTitle(
                title: S.of(context)!.collectionMethod,
                isMiddleTitle: true,
              ), */

              Align(
                alignment: Alignment.center,
                child: Text(
                  S.of(context)!.collectionMethod,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CommonColors.blackColor),
                ),
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
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            collectionMethod: mViewModel.selectedCollection);
                      },
                      underText: S.of(context)!.sanitaryPads,
                      isUnderText: true,
                      imagePath: LocalImages.img_collection_4,
                      isSelected: mViewModel.selectedCollection == 1,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedCollection = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            collectionMethod: mViewModel.selectedCollection);
                      },
                      underText: S.of(context)!.period_panty,
                      isUnderText: true,
                      imagePath: LocalImages.img_collection_1,
                      isSelected: mViewModel.selectedCollection == 2,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedCollection = 3;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            collectionMethod: mViewModel.selectedCollection);
                      },
                      underText: S.of(context)!.tampons,
                      isUnderText: true,
                      imagePath: LocalImages.img_collection_2,
                      isSelected: mViewModel.selectedCollection == 3,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedCollection = 4;

                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            collectionMethod: mViewModel.selectedCollection);
                      },
                      underText: S.of(context)!.cups,
                      isUnderText: true,
                      imagePath: LocalImages.img_collection_3,
                      isSelected: mViewModel.selectedCollection == 4,
                    ),
                  ],
                ),
              ),
              kCommonSpaceV10,
              CommonSymptomsTitle(
                title: S.of(context)!.freqOfChange,
                isMiddleTitle: true,
                isHintIcon: true,
                dialogText: S.of(context)!.howManyTimesYou,
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
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedFrequency = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            frequencyOfChangeDay: mViewModel.selectedFrequency);
                      },
                      imgHeight: 40,
                      underText: "4 times",
                      isUnderText: true,
                      isSelected: mViewModel.selectedFrequency == 1,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedFrequency = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            frequencyOfChangeDay: mViewModel.selectedFrequency);
                      },
                      imgHeight: 40,
                      underText: "3 times",
                      isUnderText: true,
                      isSelected: mViewModel.selectedFrequency == 2,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedFrequency = 3;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            frequencyOfChangeDay: mViewModel.selectedFrequency);
                      },
                      imgHeight: 40,
                      underText: "2 times",
                      isUnderText: true,
                      isSelected: mViewModel.selectedFrequency == 3,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedFrequency = 4;
                          mViewModel.count -= 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            frequencyOfChangeDay: mViewModel.selectedFrequency);
                      },
                      imgHeight: 40,
                      underText: "1 time",
                      isUnderText: true,
                      isSelected: mViewModel.selectedFrequency == 4,
                    ),
                  ],
                ),
              ),
              CommonSymptomsTitle(
                title: S.of(context)!.mood,
                isMiddleTitle: true,
              ),
              kCommonSpaceV10,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CommonSymptomsBadge(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                            });
                            return AlertDialog(
                              content: Text(
                                S.of(context)!.aajMainUpar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: CommonColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        );
                        setState(() {
                          mViewModel.selectedMood = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            mood: mViewModel.selectedMood);
                      },
                      underText: "  ${S.of(context)!.relaxed}",
                      isUnderText: true,
                      imagePath: LocalImages.laugh,
                      isSelected: mViewModel.selectedMood == 1,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedMood = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            mood: mViewModel.selectedMood);
                      },
                      underText: "  ${S.of(context)!.irritated}",
                      isUnderText: true,
                      imagePath: LocalImages.irritability,
                      isSelected: mViewModel.selectedMood == 2,
                    ),
                    CommonSymptomsBadge(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedMood = 3;
                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            mood: mViewModel.selectedMood);
                      },
                      underText: "  ${S.of(context)!.sad}",
                      isUnderText: true,
                      imagePath: LocalImages.sad,
                      isSelected: mViewModel.selectedMood == 3,
                    ),
                  ],
                ),
              ),
              CommonSymptomsTitle(
                title: S.of(context)!.energy,
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
                          mViewModel.selectedEnergy = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            energy: mViewModel.selectedEnergy);
                      },
                      underText: S.of(context)!.lively,
                      isUnderText: true,
                      imagePath: LocalImages.img_energy_1,
                      imgHeight: 75,
                      // isBoxFit: true,
                      isSelected: mViewModel.selectedEnergy == 1,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedEnergy = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            energy: mViewModel.selectedEnergy);
                      },
                      underText: S.of(context)!.normal,
                      isUnderText: true,
                      imagePath: LocalImages.img_energy_2,
                      imgHeight: 75,
                      isSelected: mViewModel.selectedEnergy == 2,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedEnergy = 3;
                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            energy: mViewModel.selectedEnergy);
                      },
                      imagePath: LocalImages.img_energy_3,
                      imgHeight: 75,
                      underText: 'Tired',
                      isUnderText: true,
                      // isBoxFit: true,
                      isSelected: mViewModel.selectedEnergy == 3,
                    ),
                  ],
                ),
              ),
              CommonSymptomsTitle(
                title: S.of(context)!.stress,
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
                          mViewModel.selectedStress = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            stress: mViewModel.selectedStress);
                      },
                      imagePath: LocalImages.img_stress_1,
                      imgHeight: 75,
                      underText: S.of(context)!.low,
                      isUnderText: true,
                      // isBoxFit: true,
                      isSelected: mViewModel.selectedStress == 1,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedStress = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            stress: mViewModel.selectedStress);
                      },
                      imagePath: LocalImages.img_stress_2,
                      imgHeight: 75,
                      underText: S.of(context)!.moderate,
                      isUnderText: true,
                      // isBoxFit: true,
                      isSelected: mViewModel.selectedStress == 2,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedStress = 3;

                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            stress: mViewModel.selectedStress);
                      },
                      imagePath: LocalImages.img_stress_3,
                      imgHeight: 75,
                      underText: S.of(context)!.high,
                      isUnderText: true,
                      // isBoxFit: true,
                      isSelected: mViewModel.selectedStress == 3,
                    ),
                  ],
                ),
              ),
              CommonSymptomsTitle(
                title: S.of(context)!.acne,
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
                          mViewModel.selectedAcne = 1;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            acne: mViewModel.selectedAcne);
                      },
                      /* isContainer: true,
                      inContainerImage: true, */
                      underText: S.of(context)!.none,
                      isUnderText: true,
                      // bgColor: const Color(0xFFF2E9EE).withOpacity(0.4),
                      // borderColor: CommonColors.primaryColor,
                      imagePath: LocalImages.img_acne_1,
                      isSelected: mViewModel.selectedAcne == 1,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedAcne = 2;
                        });
                        if (mViewModel.count != 0) {
                          mViewModel.count -= 1;
                        }
                        mViewModel.userSymptomsLogApi(
                            acne: mViewModel.selectedAcne);
                      },
                      underText: S.of(context)!.minimal,
                      isUnderText: true,
                      // borderColor: CommonColors.primaryColor,
                      imagePath: LocalImages.img_acne_2,
                      isSelected: mViewModel.selectedAcne == 2,
                    ),
                    CommonSymptomsWidget(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedAcne = 3;
                          mViewModel.count += 1;
                        });
                        mViewModel.checkMoreThenThreeSelected();
                        mViewModel.userSymptomsLogApi(
                            acne: mViewModel.selectedAcne);
                      },
                      underText: S.of(context)!.severe,
                      isUnderText: true,
                      imagePath: LocalImages.img_acne_3,
                      isSelected: mViewModel.selectedAcne == 3,
                    ),
                  ],
                ),
              ),
              kCommonSpaceV20,
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 1.3,
                  label: 'Save',
                  buttonColor: CommonColors.primaryColor,
                  onPress: () {
                    mViewModel.postUserSymptomsLogApi(body: {
                      "location": mViewModel.selectedLocationArray,
                      "cramps": mViewModel.selectedCramps,
                      "days": mViewModel.selectedDays,
                      "collectionMethod": mViewModel.selectedCollection,
                      "frequencyOfChangeDay":
                          mViewModel.selectedFrequency.toString(),
                      "mood": mViewModel.selectedMood,
                      "energy": mViewModel.selectedEnergy,
                      "stress": mViewModel.selectedStress,
                      "acne": mViewModel.selectedAcne,
                    });
                    CommonUtils.showSnackBar(
                      ' Data Save Successfully.',
                      color: CommonColors.greenColor,
                    );
                    Navigator.pop(context);
                    // pushAndRemoveUntil(const BottomNavbarView());
                  },
                ),
              )

              // CommonSymptomsTitle(
              //   title: 'Life Style',
              //   isMiddleTitle: true,
              // ),
              // kCommonSpaceV10,
              // IntrinsicHeight(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       CommonSymptomsWidget(
              //         onTap: () {
              //           setState(() {
              //             mViewModel.selectedLifeStyle = 1;
              //           });
              //           mViewModel.userSymptomsLogApi(
              //               lifestyle: mViewModel.selectedLifeStyle);
              //         },
              //         underText: "Sedentary",
              //         isUnderText: true,
              //         imagePath: LocalImages.emoji_sleep,
              //         isSelected: mViewModel.selectedLifeStyle == 1,
              //       ),
              //       CommonSymptomsWidget(
              //         onTap: () {
              //           setState(() {
              //             mViewModel.selectedLifeStyle = 2;
              //           });
              //           mViewModel.userSymptomsLogApi(
              //               lifestyle: mViewModel.selectedLifeStyle);
              //         },
              //         underText: "Light Active",
              //         isUnderText: true,
              //         imagePath: LocalImages.emoji_sleep,
              //         isSelected: mViewModel.selectedLifeStyle == 2,
              //       ),
              //       CommonSymptomsWidget(
              //         onTap: () {
              //           setState(() {
              //             mViewModel.selectedLifeStyle = 3;
              //           });
              //           mViewModel.userSymptomsLogApi(
              //               lifestyle: mViewModel.selectedLifeStyle);
              //         },
              //         underText: "Highly Active",
              //         isUnderText: true,
              //         imagePath: LocalImages.emoji_sleep,
              //         isSelected: mViewModel.selectedLifeStyle == 3,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

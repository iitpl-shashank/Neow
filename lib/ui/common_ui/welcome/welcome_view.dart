import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zodiac/zodiac.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/login_master.dart';
import '../../../ui/common_ui/welcome/welcome_view_model.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_function.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_gender_select_box.dart';
import '../../../widgets/common_relation_select_box.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../naveli_ui/cycle_info/cycle_info_view.dart';
import '../../naveli_ui/cycle_info/cycle_info_view_model.dart';
import '../singin/signin_view_model.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late WelcomeViewModel mViewModel;
  final mNameController = TextEditingController();
  final mOtherController = TextEditingController();
  final mSelectDateController = TextEditingController();
  final mDateController = TextEditingController();
  final mAapkeKonController = TextEditingController();
  final mUniqueIdController = TextEditingController();

  late SignInViewModel singInViewModel =  SignInViewModel();

  final PageController pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;
  bool showFloatingButton = false;
  int? selectedGender;
  int? selectedRelation;
  String? zodiac;
  Map<String, dynamic> allData = {};

  //
  // int calculateAge(String birthDateString) {
  //   // Parse the string date
  //   DateTime birthDate = DateFormat("yyyy-MM-dd").parse(birthDateString);
  //   DateTime currentDate = DateTime.now();
  //
  //   int age = currentDate.year - birthDate.year;
  //
  //   // Adjust if the birthday hasn't occurred yet this year
  //   if (currentDate.month < birthDate.month ||
  //       (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
  //     age--;
  //   }
  //
  //   return age;
  // }


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // singInViewModel.userRoleId = "";
      mViewModel.attachedContext(context);

      mNameController.text = globalUserMaster?.name ?? '';
      if (globalUserMaster?.gender != null) {
        selectedGender = int.parse(globalUserMaster!.gender!.toString());
      }
      mOtherController.text = globalUserMaster?.genderType ?? '';
      if (globalUserMaster?.relationshipStatus != null) {
        selectedRelation =
            int.parse(globalUserMaster!.relationshipStatus!.toString());
      }
      mDateController.text = globalUserMaster?.birthdate ?? '';
      if (globalUserMaster?.birthdate != null) {
        zodiac = Zodiac().getZodiac(globalUserMaster?.birthdate ?? '');
      }
      if (globalUserMaster?.humApkeHeKon != null) {
        mAapkeKonController.text = globalUserMaster?.humApkeHeKon ?? '';
      }
      navigateNextPage();
    });

    super.initState();
  }

  void navigateNextPage() {
    if (currentIndex == 0) {
      /* Future.delayed(const Duration(seconds: 3), () {
        pageController
            .nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            )
            .whenComplete(() => setState(() {
                  showFloatingButton = true;
                }));
      }); */
    }
  }


  Future<void> selectDate() async {
    DateTime today = DateTime.now();
    DateTime minimumAllowedDate = today.subtract(const Duration(days: 365 * 15)); // 15 years ago

    DateTime? picked = await showDatePicker(
      context: mainNavKey.currentContext!,
      initialDate: mDateController.text.isNotEmpty
          ? DateFormat("yyyy-MM-dd").parse(mDateController.text)
          : minimumAllowedDate,
      firstDate: DateTime(1900),
      lastDate: minimumAllowedDate,
    );

    if (picked != null) {
      setState(() {
        mDateController.text = CommonUtils.dateFormatyyyyMMDD(picked.toString());
        int age = calculateAge(mDateController.text);
        debugPrint("Age===>: $age");

        if (age >= 55) {
          // Automatically pop the date picker and show the dialog
          Future.delayed(Duration.zero, () {
            askMenstrualStatus();
          });
        } else {
          // Set default user role for younger users
          singInViewModel.userRoleId = "2";
          gUserType = AppConstants.NEOWME;
        }
      });
    } else {
      print("Date selection canceled");
    }
  }

  void askMenstrualStatus() {
    showDialog(
      context: mainNavKey.currentContext!,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: const Text("Menstrual Status"),
          content: const Text("Are you still having periods?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {


                  singInViewModel.userRoleId = "4"; // Assign role for menopause
                  gUserType = AppConstants.CYCLE_EXPLORER;
                  globalUserMaster = AppPreferences.instance
                      .getUserDetails();

                  UserMaster userMaster = UserMaster(
                      id: globalUserMaster!.id,
                      name: globalUserMaster!.name,
                      email: globalUserMaster!.email,
                      roleId : 4,
                      uuId: globalUserMaster!.uuId,
                      birthdate: globalUserMaster!.birthdate,
                      age: globalUserMaster!.age,
                      height: globalUserMaster!.height,
                      weight: globalUserMaster!.weight,
                      bmiScore: globalUserMaster!.bmiScore,
                      bmiType: globalUserMaster!.bmiType,
                      badTime: globalUserMaster!.badTime,
                      wakeUpTime: globalUserMaster!.wakeUpTime,
                      totalSleepTime: globalUserMaster!.totalSleepTime,
                      waterMl: globalUserMaster!.waterMl,
                      gender: globalUserMaster!.gender,
                      genderType: globalUserMaster!.genderType,
                      mobile: globalUserMaster!.mobile,
                      deviceToken: globalUserMaster!.deviceToken,
                      image: globalUserMaster!.image,
                      relationshipStatus: globalUserMaster!.relationshipStatus,
                      humApkeHeKon: globalUserMaster!.humApkeHeKon,
                      status: globalUserMaster!.status,
                      state: globalUserMaster!.state,
                      city: globalUserMaster!.city
                  );

                  AppPreferences.instance.setUserDetails(
                      jsonEncode(userMaster));
                  gUserType = singInViewModel.userRoleId.toString();


                  debugPrint("Role ID: ${singInViewModel.userRoleId}");
                });
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  singInViewModel.userRoleId = "2"; // Default role
                  gUserType = AppConstants.NEOWME;
                  debugPrint("Role ID: ${singInViewModel.userRoleId}");
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WelcomeViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          body: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
                // if (currentIndex == 4) {
                //   showFloatingButton = false;
                //   navigateNextPage();
                // } else {
                //   showFloatingButton = true;
                // }
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kCommonSpaceV10,
                    Text(
                      "Let us know you better!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CommonColors.blackColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Answer a few questions to help personalise your experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CommonColors.mGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // const Spacer(),
                    // kCommonSpaceV50,
                    kCommonSpaceV30,
                    Image.asset(
                      height: kDeviceHeight / 2,
                      LocalImages.img_saval_javab,
                      fit: BoxFit.cover,
                    ),
                    kCommonSpaceV10,
                    PrimaryButton(
                      width: kDeviceWidth / 1.3,
                      label: 'Get Started',
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        pageController
                            .nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            )
                            .whenComplete(() => setState(() {
                                  showFloatingButton = true;
                                }));
                      },
                    ),
                    kCommonSpaceV10,
                  ],
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: kCommonScreenPadding,
                  child: Column(
                    children: [
                      kCommonSpaceV10,
                      Text(
                        'Neow, Naam to suna hi hoga',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: 
                        ),
                      ), */
                      /* Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            S.of(context)!.sunaHoga,
                            style: GoogleFonts.piedra(
                              color: CommonColors.primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ), */
                      /* Stack(
                        children: [
                          GifView.asset(
                            LocalImages.gif_leaf_animation,
                            height: kDeviceHeight / 4,
                            width: kDeviceWidth,
                            fit: BoxFit.cover,
                          ),
                          GifView.asset(
                            LocalImages.naveli_shahrukh_pose_animation,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ), */
                      kCommonSpaceV30,
                      Image.asset(
                        LocalImages.FlowerImage,
                        //LocalImages.img_naam,

                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(LocalImages.img_image_error);
                        },
                      ),
                      kCommonSpaceV15,
                      Container(
                        width: kDeviceWidth / 1.2,
                        decoration: BoxDecoration(
                          // color: const Color(0xFFEFE5FE).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: CommonColors.black12,
                          //     blurRadius: 5,
                          //     offset: Offset(0, 4),
                          //     spreadRadius: 0,
                          //   )
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kCommonSpaceV15,
                              Text(
                                S.of(context)!.yourFabulousName,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              kCommonSpaceV15,
                              LabelTextField(
                                hintText: 'Type here',
                                controller: mNameController,
                                isOnlyChar: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Icon(Icons.arrow_back,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                      kCommonSpaceV50,
                      Text(
                        S.of(context)!.yourgender,
                        // "Whats your gender vibe? fam?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context)!.wesupport,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.mGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(
                        height: kDeviceHeight / 4,
                        LocalImages.img_gender_screen,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(LocalImages.img_image_error);
                        },
                      ),
                      kCommonSpaceV30,
                      if (gUserType == AppConstants.BUDDY ||
                          gUserType == AppConstants.CYCLE_EXPLORER) ...[

                        kCommonSpaceV30,

                        CommonGenderSelectBox(
                            onTap: () {
                              setState(() {
                                selectedGender = 1;
                                mOtherController.clear();
                              });
                            },
                            text: S.of(context)!.male,
                            imagePath: LocalImages.img_male,
                            isSelected: selectedGender == 1),
                      ],

                      CommonGenderSelectBox(
                          onTap: () {
                            setState(() {
                              selectedGender = 2;
                              mOtherController.clear();
                            });
                          },
                          text: S.of(context)!.female,
                          imagePath: LocalImages.img_female,
                          isSelected: selectedGender == 2),
                      CommonGenderSelectBox(
                          onTap: () {
                            setState(() {
                              selectedGender = 3;
                              mOtherController.clear();
                            });
                          },
                          text: S.of(context)!.transgender,
                          imagePath: LocalImages.img_transgender,
                          isSelected: selectedGender == 3),
                      // kCommonSpaceV30,
                      CommonGenderSelectBox(
                          onTap: () {
                            setState(() {
                              selectedGender = 4;
                              mOtherController.clear();
                            });
                          },
                          text: S.of(context)!.other,
                          imagePath: LocalImages.img_transgender,
                          isSelected: selectedGender == 4),
                      kCommonSpaceV30,
                      /* Container(
                        // height: kDeviceHeight / 7,
                        width: kDeviceWidth / 1.2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE5FE).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: CommonColors.black12,
                          //     blurRadius: 5,
                          //     offset: Offset(0, 4),
                          //     spreadRadius: 0,
                          //   )
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context)!.otherPlSpec,
                                // S.of(context)!.other,
                                style: getAppStyle(
                                    color: CommonColors.primaryColor,
                                    fontSize: 18),
                              ),
                              kCommonSpaceV15,
                              LabelTextField(
                                onEditComplete: (value) {
                                  setState(() {
                                    selectedGender = 4;
                                  });
                                },
                                inputType: TextInputType.text,
                                hintText: S.of(context)!.enterOtherGender,
                                controller: mOtherController,
                                isOnlyChar: true,
                              ),
                            ],
                          ),
                        ),
                      ), */
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Icon(Icons.arrow_back,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                      kCommonSpaceV10,
                      Text(
                        S.of(context)!.relationshipStatus,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kCommonSpaceV50,
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        CommonRelationSelectBox(
                          onTap: () {
                            setState(() {
                              selectedRelation = 1;
                            });
                          },
                          text: S.of(context)!.solo,
                          imagePath: LocalImages.img_solo,
                          // isBoxFit: true,
                          isShowDefaultBorder: true,
                          isSelected: selectedRelation == 1,
                        ),
                        kCommonSpaceH10,
                        kCommonSpaceH10,
                        CommonRelationSelectBox(
                          onTap: () {
                            setState(() {
                              selectedRelation = 2;
                            });
                          },
                          text: S.of(context)!.tied,
                          imagePath: LocalImages.img_naveli_heart,
                          // isBoxFit: true,
                          isShowDefaultBorder: true,
                
                          isSelected: selectedRelation == 2,
                        ),
                      ]),
                      CommonRelationSelectBox(
                        onTap: () {
                          setState(() {
                            selectedRelation = 3;
                          });
                        },
                        text: 'Open for surprises',
                        imagePath: LocalImages.img_open_for_surprises,
                        isShowDefaultBorder: true,
                
                        // isBoxFit: true,
                        isSelected: selectedRelation == 3,
                      ),
                      // ListView.builder(
                      //   scrollDirection: Axis.vertical,
                      //   shrinkWrap: true,
                      //   physics: ClampingScrollPhysics(),
                      //   itemCount: dataList1.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return InkWell(
                      //       onTap: () {
                      //         mViewModel.changeRelationStatusIndex(index);
                      //         print(mViewModel.selectedRelationStatusIndex);
                      //       },
                      //       child: CommonGenderSelectBox(
                      //         text: dataList1[index]['text'],
                      //         imagePath: dataList1[index]['image'],
                      //         isSelected:
                      //             index == mViewModel.selectedRelationStatusIndex,
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
              // Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       selectedRelation == 1
              //           ? Text(
              //               'Akele hain to\nkya gham hai',
              //               style: getGoogleFontStyle(
              //                   color: CommonColors.primaryColor,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 40),
              //             )
              //           // ? Image.asset(
              //           //     LocalImages.img_solo_girl,
              //           //     fit: BoxFit.cover,
              //           //   )
              //           : Container(),
              //       selectedRelation == 2
              //           ? Text(
              //               'Hum Tum!\nHum Tum!',
              //               style: getGoogleFontStyle(
              //                   color: CommonColors.primaryColor,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 40),
              //             )
              //           // ? Image.asset(
              //           //     LocalImages.img_tied_girl,
              //           //     fit: BoxFit.cover,
              //           //   )
              //           : Container(),
              //       selectedRelation == 3
              //           ? Text(
              //               'Woh hai\nkahan',
              //               textAlign: TextAlign.center,
              //               style: getGoogleFontStyle(
              //                   color: CommonColors.primaryColor,
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 40),
              //             )
              //           // ? Image.asset(
              //           //     LocalImages.img_open_girl,
              //           //     fit: BoxFit.cover,
              //           //   )
              //           : Container(),
              //     ],
              //   ),
              // ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Icon(Icons.arrow_back,
                            color: CommonColors.primaryColor),
                      ),
                    ),
                    kCommonSpaceV20,
                    Text(
                      "Your journey in candles",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CommonColors.blackColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your birth date helps us tailor the app for you!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CommonColors.mGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    kCommonSpaceV20,
                    Image.asset(
                      LocalImages.img_your_journey,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    kCommonSpaceV30,
                    /* zodiac != null
                        ? Text(
                            zodiac!,
                            style: getGoogleFontStyle(
                                color: CommonColors.primaryColor, fontSize: 30),
                          )
                        : Text(
                            S.of(context)!.zodiac,
                            style: getGoogleFontStyle(
                                color: CommonColors.primaryColor, fontSize: 30),
                          ),
                    kCommonSpaceV30, */
                    SizedBox(
                      // height: 130,
                      width: kDeviceWidth / 1,
                      /*  decoration: BoxDecoration(
                        // color: const Color(0xFFEFE5FE).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: CommonColors.black12,
                        //     blurRadius: 5,
                        //     offset: Offset(0, 4),
                        //     spreadRadius: 0,
                        //   )
                        // ],
                      ), */
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /* Text(
                              S.of(context)!.yourJourney,
                              style: getGoogleFontStyle(
                                  color: CommonColors.primaryColor,
                                  fontSize: 20),
                            ),
                            Text(
                              S.of(context)!.yourBDayHelp,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: getAppStyle(
                                color: CommonColors.mGrey,
                                fontSize: 15,
                                height: 1,
                                fontWeight: FontWeight.w400,
                              ),
                            ), */
                            kCommonSpaceV10,
                            LabelTextField(
                              onTap: () async {
                                selectDate();
                              },
                              hintText: S.of(context)!.selectDate,
                              controller: mDateController,
                              readOnly: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text(
                    //   S.of(context)!.yourJourney,
                    //   style: getAppStyle(
                    //       color: CommonColors.blackColor,
                    //       fontWeight: FontWeight.w600,
                    //       fontSize: 25),
                    // ),
                    // kCommonSpaceV15,
                    // LabelTextField(
                    //   onTap: () async {
                    //     DateTime? picked = await showDatePicker(
                    //         context: mainNavKey.currentContext!,
                    //         initialDate: DateTime.now(),
                    //         firstDate: new DateTime(2016),
                    //         lastDate: new DateTime(2222));
                    //     if (picked != null) {
                    //       setState(() {
                    //         mDateController.text =
                    //             CommonUtils.dateFormatddMMYYYY(picked.toString());
                    //       });
                    //     } else {
                    //       print(picked);
                    //     }
                    //   },
                    //   hintText: S.of(context)!.selectDate,
                    //   controller: mDateController,
                    //   readOnly: true,
                    // ),
                  ],
                ),
              ),
              if (gUserType == AppConstants.BUDDY)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        kCommonSpaceV30,
                        SizedBox(
                          child: Image.asset(
                            LocalImages.img_ham_aapke_kon,
                            fit: BoxFit.cover,
                          ),
                        ),
                        kCommonSpaceV30,
                        Container(
                          // height: 130,
                          width: kDeviceWidth / 1.2,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFE5FE).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context)!.hamAapkeKon,
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontSize: 18),
                                ),
                                kCommonSpaceV15,
                                LabelTextField(
                                  hintText: S.of(context)!.hamAapkeKon,
                                  controller: mAapkeKonController,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (gUserType == AppConstants.BUDDY)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(
                      //   child: Image.asset(
                      //     LocalImages.img_ham_aapke_kon,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Icon(Icons.arrow_back,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        // height: 130,
                        width: kDeviceWidth / 1.2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE5FE).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context)!.naveliUniqueId,
                                style: getAppStyle(
                                    color: CommonColors.primaryColor,
                                    fontSize: 18),
                              ),
                              kCommonSpaceV15,
                              LabelTextField(
                                hintText: S.of(context)!.enterNaveliUid,
                                controller: mUniqueIdController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              if (gUserType == AppConstants.NEOWME)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Icon(Icons.arrow_back,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                      kCommonSpaceV20,
                      kCommonSpaceV10,
                      Text(
                        'Yo, Quick Survey Time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Help us level up.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.mGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                          height: Screen.width() / 1.6,
                          child: Image.asset(LocalImages.img_quick_survey)),
                      const Spacer()
                    ],
                  ),
                ),
            ],
          ),
          // floatingActionButton: showFloatingButton
          //     ? CommonNextIconButton(
          //         icon: Icons.arrow_forward_ios_rounded,
          //         onPressed: () {
          //           if (isValid()) {
          //             pageController.nextPage(
          //                 duration: Duration(milliseconds: 300),
          //                 curve: Curves.easeIn);
          //             if (gUserType == AppConstants.NEOWME ||
          //                 gUserType == AppConstants.CYCLE_EXPLORER) {
          //               allData['name'] = mNameController.text.trim();
          //               allData['gender'] = selectedGender.toString();
          //               if (mOtherController.text.trim().isNotEmpty) {
          //                 allData['otherGender'] = mOtherController.text.trim();
          //               }
          //               allData['relation'] = selectedRelation.toString();
          //               allData['birthdate'] = mDateController.text.trim();
          //               if (currentIndex == 6 &&
          //                   gUserType == AppConstants.NEOWME) {
          //                 push(CycleInfoView(welcomeData: allData));
          //               } else if (currentIndex == 5 &&
          //                   gUserType == AppConstants.CYCLE_EXPLORER) {
          //                 CycleInfoViewModel().userUpdateDetailsApi(
          //                   name: allData['name'],
          //                   birthdate: allData['birthdate'],
          //                   gender: allData['gender'],
          //                   genderType: allData['otherGender'],
          //                   relationshipStatus: allData['relation'],
          //                 );
          //               }
          //             }
          //             if (gUserType == AppConstants.BUDDY && currentIndex == 6) {
          //               allData['name'] = mNameController.text.trim();
          //               allData['gender'] = selectedGender.toString();
          //               if (mOtherController.text.trim().isNotEmpty) {
          //                 allData['otherGender'] = mOtherController.text.trim();
          //               }
          //               allData['relation'] = selectedRelation.toString();
          //               allData['birthdate'] = mDateController.text.trim();
          //               allData['humAapkeKon'] = mAapkeKonController.text.trim();
          //               CycleInfoViewModel().userUpdateDetailsApi(
          //                 name: allData['name'],
          //                 birthdate: allData['birthdate'],
          //                 gender: allData['gender'],
          //                 genderType: allData['otherGender'],
          //                 relationshipStatus: allData['relation'],
          //                 humAapkeHeKon: allData['humAapkeKon'],
          //               );
          //             }
          //           }
          //         },
          //         color: Colors.white,
          //         size: 26.0,
          //       )
          //     : null,
          bottomNavigationBar: showFloatingButton
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDeviceWidth / 6, vertical: 20),
                  child: PrimaryButton(
                    label: S.of(context)!.next,
                    buttonColor: CommonColors.primaryColor,
                    onPress: () {
                      if (isValid()) {
                        if (currentIndex == 3) {
                          Future.delayed(const Duration(milliseconds: 3200),
                              () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          });
                        } else {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                        if (currentIndex == 3 && selectedRelation == 1) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: CommonColors.mTransparent,
                                content: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          LocalImages.img_solo_alert,
                                          width: kDeviceWidth / 1.4,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          color: CommonColors.mWhite,
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            'Akele hain to\nkya gham hai',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CommonColors.blackColor,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 25),
                                          ),
                                        )
                                      ]),
                                ),
                              );
                            },
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        }
                        else if (currentIndex == 3 && selectedRelation == 2) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: CommonColors.mTransparent,
                                content: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: kDeviceHeight / 1.5,
                                  // padding:const EdgeInsets.all(0.0),
                                  /* decoration:BoxDecoration(
                                    border:Border.all(
                                    width:1,
                                    color:CommonColors.blackColor,
                                  ),
                                  ), */
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Stack(children: [
                                    /*Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          color: CommonColors.mTransparent,
                                          *//*padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),*//*
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CommonColors.blackColor,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 25),
                                          ),
                                        )),*/
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        LocalImages.heartHands,
                                        height: 240,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ]),
                                ),
                                insetPadding: const EdgeInsets.all(1.0),
                              );
                            },
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        }
                        else if (currentIndex == 3 && selectedRelation == 3) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: CommonColors.mTransparent,
                                content: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: kDeviceHeight / 1.5,
                                  // padding:const EdgeInsets.all(0.0),
                                  /* decoration:BoxDecoration(
                                    border:Border.all(
                                    width:1,
                                    color:CommonColors.blackColor,
                                  ),
                                  ), */
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Stack(children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          color: CommonColors.mWhite,
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            'Woh hai kahan?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: CommonColors.blackColor,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 25),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                        LocalImages.img_waiting_alert,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ]),
                                ),
                                insetPadding: const EdgeInsets.all(1.0),
                              );
                            },
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        }
                        if (gUserType == AppConstants.NEOWME ||
                            gUserType == AppConstants.CYCLE_EXPLORER) {
                          print("neow... & cycle...");
                          allData['name'] = mNameController.text.trim();
                          allData['gender'] = selectedGender.toString();
                          if (mOtherController.text.trim().isNotEmpty) {
                            allData['otherGender'] =
                                mOtherController.text.trim();
                          }
                          allData['relation'] = selectedRelation.toString();
                          allData['birthdate'] = mDateController.text.trim();
                          if (currentIndex == 5 &&
                              gUserType == AppConstants.NEOWME ) {
                            push(CycleInfoView(welcomeData: allData));
                          } else if (currentIndex == 4 &&
                              gUserType == AppConstants.CYCLE_EXPLORER) {
                            print("cycle...");
                            CycleInfoViewModel().userUpdateDetailsApi(
                              isFromCycle: true,
                              roleId: "4",
                              name: allData['name'],
                              birthdate: allData['birthdate'],
                              gender: allData['gender'],
                              genderType: allData['otherGender'],
                              relationshipStatus: allData['relation'],
                            );
                          }
                        }
                        if (currentIndex == 6 &&
                            gUserType == AppConstants.BUDDY) {
                          print("buddy...");
                          allData['name'] = mNameController.text.trim();
                          allData['gender'] = selectedGender.toString();
                          if (mOtherController.text.trim().isNotEmpty) {
                            allData['otherGender'] =
                                mOtherController.text.trim();
                          }
                          allData['relation'] = selectedRelation.toString();
                          allData['birthdate'] = mDateController.text.trim();
                          allData['humAapkeKon'] =
                              mAapkeKonController.text.trim();
                          if (mUniqueIdController.text.trim().isEmpty) {
                            CommonUtils.showSnackBar(
                              S.of(context)!.plEnterUid,
                              color: CommonColors.mRed,
                            );
                          } else {
                            CycleInfoViewModel()
                                .userUpdateDetailsApi(
                              isFromCycle: true,
                              roleId: "3",
                              name: allData['name'],
                              birthdate: allData['birthdate'],
                              gender: allData['gender'],
                              genderType: allData['otherGender'],
                              relationshipStatus: allData['relation'],
                              humAapkeHeKon: allData['humAapkeKon'],
                            ).whenComplete(() {
                              mViewModel.verifyUniqueIdApi(
                                  uniqueId: mUniqueIdController.text.trim(),
                                  isFromCycle: true);
                            });
                          }
                        }
                      }
                    },
                  ),
                )
              : null,
        ),
      ),
    );
  }

  bool isValid() {
    if (currentIndex == 1 && mNameController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterName,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 2 &&
        selectedGender == null &&
        mOtherController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourGender,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 3 && selectedRelation == null) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourRelation,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 4 && mDateController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourBday,
        color: CommonColors.mRed,
      );
      return false;
    } else if (gUserType == AppConstants.BUDDY &&
        currentIndex == 5 &&
        mAapkeKonController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterHamAapkeKon,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}



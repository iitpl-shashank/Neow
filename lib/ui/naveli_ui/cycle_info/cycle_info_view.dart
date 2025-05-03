import 'dart:convert';
import 'dart:developer';

import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../models/login_master.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/common_text_field.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../app/app_model.dart';
import '../../common_ui/singin/signin_view_model.dart';
import '../../common_ui/splash/splash_view_model.dart';
import 'cycle_info_view_model.dart';

class CycleInfoView extends StatefulWidget {
  Map<String, dynamic> welcomeData;

  CycleInfoView({super.key, required this.welcomeData});

  @override
  State<CycleInfoView> createState() => _CycleInfoViewState();
}

class _CycleInfoViewState extends State<CycleInfoView> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  final mDateController = TextEditingController();
  late CycleInfoViewModel mViewModel;
  int? selectedCycleLength = 21;
  String? selectedPreviousPeriodDate;
  late SignInViewModel singInViewModel = SignInViewModel();

  // String? selectedPreviousPeriodMonth;
  int? selectedPeriodsLength = 5;
  late FixedExtentScrollController scrollController;
  late FixedExtentScrollController scrollPeriodLengthController;
  Map<String, dynamic> cycleData = {};
  bool isPeriodsOnAfter55 = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getCurrentMonthDays();
    });

    scrollController = FixedExtentScrollController(initialItem: 0);
    scrollPeriodLengthController = FixedExtentScrollController(initialItem: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateToItem(
        0, // Target position
        duration: const Duration(seconds: 2), // Animation duration
        curve: Curves.easeInOut, // Animation curve
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("data=>>dd");
      scrollPeriodLengthController.animateToItem(
        4, // Target position
        duration: const Duration(seconds: 2), // Animation duration
        curve: Curves.easeInOut, // Animation curve
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("CycleInfoView:${singInViewModel.userRoleId}");
    mViewModel = Provider.of<CycleInfoViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Scaffold(
            backgroundColor: CommonColors.mWhite,
            body: PageView(
              onPageChanged: (int page) {
                /*setState(() {
                    _currentPage = page; // Update the current page index
                  });*/
                if (page == 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      print("data=>>dd11");
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollController.animateToItem(
                          (selectedCycleLength ?? 30) - 1, // Target position
                          duration: const Duration(seconds: 2),
                          // Animation duration
                          curve: Curves.easeInOut, // Animation curve
                        );
                      });
                    }
                  });
                } else if (page == 1) {
                  print("Page 2 is fully loaded!");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollPeriodLengthController.hasClients) {
                      print("data=>>dd");
                      scrollPeriodLengthController.animateToItem(
                        (selectedPeriodsLength ?? 4) - 1, // Target position
                        duration: const Duration(seconds: 2),
                        // Animation duration
                        curve: Curves.easeInOut, // Animation curve
                      );
                    }
                  });
                  // Add your logic here for when a specific page is fully loaded
                }
              },
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: kCommonScreenPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        kCommonSpaceV30,
                        Text(
                          S.of(context)!.cycleLengthDiff,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 24,
                            fontWeight: lang == "hi"
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        Text(
                          S.of(context)!.numberOfDays,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.greyText,
                            fontSize: 14,
                            height: 1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        kCommonSpaceV50,
                        SizedBox(
                          child: Image.asset(
                            LocalImages.img_naveli_with_calendar,
                            width: kDeviceWidth / 1.3,
                          ),
                        ),
                        Expanded(
                          child: ListWheelScrollView(
                            itemExtent: 40,
                            diameterRatio: .8,
                            perspective: 0.005,
                            controller:
                                scrollController, // Use the initialized scrollController
                            physics: FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (value) {
                              selectedCycleLength = value +
                                  21; // Ensuring the range starts from 21
                              print("Selected length: $selectedCycleLength");
                            },
                            children: List.generate(
                              25, // Total count (from 21 to 45) = 45 - 21 + 1
                              (index) => Container(
                                height: 80,
                                width: 120,
                                decoration: const BoxDecoration(
                                  color: CommonColors.mWhite,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${index + 21} ${index == 0 ? 'Day' : 'Days'}",
                                  style: getAppStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: CommonColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        kCommonSpaceV10,
                        PrimaryButton(
                          width: kDeviceWidth / 1.3,
                          borderRadius: BorderRadius.circular(50),
                          label: S.of(context)!.next,
                          onPress: () {
                            if (selectedCycleLength != 0) {
                              int seleCylen = selectedCycleLength != null
                                  ? int.parse(selectedCycleLength.toString())
                                  : 0;
                              print(seleCylen);
                              print(
                                  "==================================seleCylen");

                              if (seleCylen > 35 || seleCylen < 21) {
                                cycleData['cycleLength'] = seleCylen;
                                cycleData['cycleLength'] =
                                    selectedCycleLength.toString();

                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          CommonColors.mTransparent,
                                      content: Container(
                                        height: kDeviceHeight / 2.5,
                                        decoration: BoxDecoration(
                                          color: CommonColors.mWhite,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: SecondaryButton(
                                                    width: 40,
                                                    isRounded: false,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 20),
                                                    onPress: () {
                                                      Navigator.pop(context);
                                                    },
                                                    label: 'X',
                                                    labelColor: CommonColors
                                                        .primaryColor,
                                                  )),
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
                                                    top: 10,
                                                    bottom: 5),
                                                child: Text(
                                                  S.of(context)!.unusualCycle,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: CommonColors
                                                          .blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Container(
                                                color: CommonColors.mWhite,
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  S
                                                      .of(context)!
                                                      .unusualCycleDescription,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: CommonColors
                                                          .blackColor,
                                                      fontSize: 14),
                                                ),
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                ).then((_) {
                                  // Navigate to the next screen after the dialog is dismissed
                                  pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                });
                              } else {
                                cycleData['cycleLength'] =
                                    selectedCycleLength.toString();
                                pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }

                              // print("Selected Cycle length: $selectedCycleLength");
                            }
                          },
                        ),
                        kCommonSpaceV20,
                        SecondaryButton(
                          isRounded: false,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          onPress: () {
                            cycleData['cycleLength'] = selectedCycleLength;
                            pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          label: S.of(context)!.iDontRemember,
                          labelColor: CommonColors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
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
                      ),
                      kCommonSpaceV30,
                      Text(
                        S.of(context)!.periodLengthDiff,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 24,
                          fontWeight:
                              lang == "hi" ? FontWeight.w200 : FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context)!.howLongDosePeriod,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: getAppStyle(
                          color: CommonColors.greyText,
                          fontSize: 13,
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      kCommonSpaceV50,
                      SizedBox(
                        child: Image.asset(
                          LocalImages.img_naveli_with_tree,
                          width: kDeviceWidth / 1.7,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 40,
                          diameterRatio: .8,
                          controller: scrollPeriodLengthController,
                          physics: FixedExtentScrollPhysics(),
                          perspective: 0.004,
                          onSelectedItemChanged: (value) {
                            selectedPeriodsLength =
                                value + 1; // Ensuring range starts from 1
                          },
                          children: List.generate(
                            12, // Now limited to 1–5
                            (index) => Container(
                              height: 80,
                              width: 120,
                              decoration: const BoxDecoration(
                                color: CommonColors.mWhite,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${index + 1} ${index == 0 ? 'Day' : 'Days'}",
                                style: getAppStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      kCommonSpaceV10,
                      PrimaryButton(
                        width: kDeviceWidth / 1.3,
                        label: S.of(context)!.next,
                        borderRadius: BorderRadius.circular(50),
                        onPress: () {
                          // print(selectedPeriodsLength);
                          if (selectedPeriodsLength != 0) {
                            int seleCylen = selectedPeriodsLength != null
                                ? int.parse(selectedPeriodsLength.toString())
                                : 0;
                            if (seleCylen > 7 || seleCylen < 2) {
                              cycleData['periodsLength'] = seleCylen;
                              cycleData['periodsLength'] =
                                  selectedPeriodsLength.toString();

                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: CommonColors.mTransparent,
                                    content: Container(
                                      height: kDeviceHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: CommonColors.mWhite,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: SecondaryButton(
                                                  width: 40,
                                                  isRounded: false,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 20),
                                                  onPress: () {
                                                    Navigator.pop(context);
                                                  },
                                                  label: 'X',
                                                  labelColor:
                                                      CommonColors.primaryColor,
                                                )),
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
                                                  left: 10,
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 5),
                                              child: Text(
                                                S.of(context)!.unusualPeriod,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                      CommonColors.blackColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: CommonColors.mWhite,
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                S
                                                    .of(context)!
                                                    .unusualPeriodDescription,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontSize: 14),
                                              ),
                                            )
                                          ]),
                                    ),
                                  );
                                },
                              ).then((_) {
                                // Navigate to the next screen after the dialog is dismissed
                                pageController.animateToPage(2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              });
                            } else {
                              cycleData['periodsLength'] =
                                  selectedPeriodsLength.toString();
                              pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            }
                          }
                        },
                      ),
                      kCommonSpaceV15,
                      SecondaryButton(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        onPress: () {
                          cycleData['periodsLength'] = '5';
                          pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        isRounded: false,
                        label: S.of(context)!.iDontRemember,
                        labelColor: CommonColors.primaryColor,
                      ),
                      kCommonSpaceV15,
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Text(
                          S.of(context)!.lastPeriodDay,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 24,
                            fontWeight: lang == "hi"
                                ? FontWeight.w200
                                : FontWeight.w500,
                          ),
                        ),
                        kCommonSpaceV50,
                        // kCommonSpaceV50,
                        SizedBox(
                          child: Image.asset(
                            LocalImages.img_naveli_cloud,
                            width: kDeviceWidth / 1.7,
                          ),
                        ),

                        kCommonSpaceV50,

                        LabelTextField(
                          onTap: () async {
                            DateTime now = DateTime.now();
                            DateTime firstSelectableDate =
                                DateTime(now.year, now.month - 1, 1);

                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstSelectableDate,
                              lastDate: now,
                            );

                            if (picked != null) {
                              setState(() {
                                mDateController.text =
                                    CommonUtils.dateFormatyyyyMMDD(
                                        picked.toString());
                                print(mDateController.text);
                                selectedPreviousPeriodDate =
                                    mDateController.text;
                              });
                            } else {
                              print("No date selected");
                            }
                          },
                          hintText: S.of(context)!.selectDate,
                          controller: mDateController,
                          readOnly: true,
                        ),

                        Visibility(
                          visible:
                              calculateAge(widget.welcomeData['birthdate']) >=
                                      55 &&
                                  isPeriodsOnAfter55,
                          child: LabelTextField(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 365 * 60)),
                                  lastDate: DateTime.now());
                              if (picked != null) {
                                setState(() {
                                  mDateController.text =
                                      CommonUtils.dateFormatyyyyMMDD(
                                          picked.toString());
                                  print(mDateController.text.toString());
                                  selectedPreviousPeriodDate =
                                      mDateController.text.toString();
                                  /* zodiac = Zodiac().getZodiac(
                                              mDateController.text.toString()); */
                                });
                              } else {
                                print(picked);
                              }
                            },
                            hintText: S.of(context)!.selectDate,
                            controller: mDateController,
                            readOnly: true,
                          ),
                        ),
                        kCommonSpaceV50,
                        // kCommonSpaceV50,
                        /* Expanded(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: ListWheelScrollView(
                                itemExtent: 100,
                                diameterRatio: .8,
                                physics: const FixedExtentScrollPhysics(),
                                perspective: 0.005,
                                controller: scrollController,
                                onSelectedItemChanged: (value) {
                                  // DateTime selectedDate = DateTime.now().subtract(Duration(days: value));
                                  // selectedPreviousPeriodDate = selectedDate.day;
                                  DateTime selectedDate = DateTime.now()
                                      .subtract(Duration(days: value));
                                  selectedPreviousPeriodDate =
                                      '${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}';
                                },
                                children: List.generate(
                                  60,
                                  (index) {
                                    DateTime date = DateTime.now()
                                        .subtract(Duration(days: index));
                                    String formattedDate =
                                        DateFormat('d MMM yyyy').format(date);
            
                                    return Container(
                                      height: 120,
                                      width: 120,
                                      decoration: const BoxDecoration(
                                        color: CommonColors.A43786,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: RotatedBox(
                                        quarterTurns: -1,
                                        child: Text(
                                          formattedDate,
                                          textAlign: TextAlign.center,
                                          style: getAppStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: CommonColors.mWhite,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ), */

                        // Expanded(
                        //   child: LabelTextField(
                        //     onTap: () async {
                        //       DateTime? picked = await showDatePicker(
                        //           context: mainNavKey.currentContext!,
                        //           initialDate: DateTime.now(),
                        //           firstDate: new DateTime(2016),
                        //           lastDate: new DateTime(2222));
                        //       if (picked != null) {
                        //         setState(() {
                        //           mDateController.text =
                        //               CommonUtils.dateFormatddMMYYYY(
                        //                   picked.toString());
                        //         });
                        //       } else {
                        //         print(picked);
                        //       }
                        //     },
                        //     hintText: S.of(context)!.selectDate,
                        //     controller: mDateController,
                        //     readOnly: true,
                        //   ),
                        // ),
                        // kCommonSpaceV10,
                        // Text(
                        //   S.of(context)!.date,
                        //   style: getAppStyle(
                        //     color: CommonColors.mGrey,
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Spacer(),
                        PrimaryButton(
                          width: kDeviceWidth / 1.3,
                          label: S.of(context)!.next,
                          borderRadius: BorderRadius.circular(50),
                          onPress: () {
                            // if(isValid()){
                            //   print(selectedPreviousPeriodMonth);
                            //   print(selectedPreviousPeriodDate);
                            // }
                            if (isValid()) {
                              // print(selectedPreviousPeriodDate);
                              cycleData['previousPeriodDate'] =
                                  selectedPreviousPeriodDate;
                              // cycleData['previousPeriodMonth'] = selectedPreviousPeriodMonth.toString();
                              pageController.animateToPage(3,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);

                              mViewModel.userUpdateDetailsApi(
                                isFromCycle: true,
                                name: widget.welcomeData['name'],
                                birthdate: widget.welcomeData['birthdate'],
                                gender: widget.welcomeData['gender'],
                                genderType: widget.welcomeData['otherGender'],
                                relationshipStatus:
                                    widget.welcomeData['relation'],
                                averageCycleLength:
                                    cycleData['cycleLength'].toString(),
                                previousPeriodsBegin:
                                    cycleData['previousPeriodDate'],
                                previousPeriodsMonth:
                                    cycleData['previousPeriodMonth'],
                                averagePeriodLength:
                                    cycleData['periodsLength'].toString(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  // fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
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
                    ),
                    /*  GifView.asset(
                        LocalImages.gif_star,
                        // height: kDeviceHeight / 2,
                        // width: kDeviceWidth / 2,
                      ), */
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                LocalImages.gif_star,
                                width: kDeviceWidth / 1.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                LocalImages.img_sprinkle,
                                width: kDeviceWidth / 1.3,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                        /* Image.asset(
                            LocalImages.img_sprinkle,
                            width: kDeviceWidth / 1.3,
                            fit: BoxFit.cover,
                          ), */
                        kCommonSpaceV20,
                        Text(
                          S.of(context)!.personalisingExp,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // kCommonSpaceV50,
                        // PrimaryButton(
                        //   width: kDeviceWidth / 1.3,
                        //   label: S.of(context)!.next,
                        //   borderRadius: BorderRadius.circular(50),
                        //   onPress: () async {
                        //
                        //
                        //
                        //     // mViewModel.userUpdateDetailsApi(
                        //     //   isFromCycle: true,
                        //     //   name: widget.welcomeData['name'],
                        //     //   birthdate: widget.welcomeData['birthdate'],
                        //     //   gender: widget.welcomeData['gender'],
                        //     //   genderType: widget.welcomeData['otherGender'],
                        //     //   relationshipStatus: widget.welcomeData['relation'],
                        //     //   averageCycleLength: cycleData['cycleLength'],
                        //     //   previousPeriodsBegin:
                        //     //   cycleData['previousPeriodDate'],
                        //     //   previousPeriodsMonth:
                        //     //   cycleData['previousPeriodMonth'],
                        //     //   averagePeriodLength: cycleData['periodsLength'],
                        //     // );
                        //
                        //
                        //
                        //
                        //
                        //     // if ( calculateAge(widget
                        //     //     .welcomeData['birthdate']) >=
                        //     //     55 ) {
                        //     //
                        //     //   debugPrint("IN  if ");
                        //     //    if(isPeriodsOnAfter55){
                        //     //   mViewModel.userUpdateDetailsApi(
                        //     //     isFromCycle: true,
                        //     //     name: widget.welcomeData['name'],
                        //     //     birthdate: widget.welcomeData['birthdate'],
                        //     //     gender: widget.welcomeData['gender'],
                        //     //     genderType: widget.welcomeData['otherGender'],
                        //     //     relationshipStatus: widget.welcomeData['relation'],
                        //     //     averageCycleLength: cycleData['cycleLength'],
                        //     //     previousPeriodsBegin:
                        //     //     cycleData['previousPeriodDate'],
                        //     //     previousPeriodsMonth:
                        //     //     cycleData['previousPeriodMonth'],
                        //     //     averagePeriodLength: cycleData['periodsLength'],
                        //     //   );
                        //     //    } else {
                        //     //      // debugPrint("IN  else ");
                        //     //      // debugPrint("IN IF Condition");
                        //     //      singInViewModel.userRoleId = "4";
                        //     //      globalUserMaster = AppPreferences.instance
                        //     //          .getUserDetails();
                        //     //
                        //     //      UserMaster userMaster = UserMaster(
                        //     //          id: globalUserMaster!.id,
                        //     //          name: globalUserMaster!.name,
                        //     //          email: globalUserMaster!.email,
                        //     //          roleId : int.parse(singInViewModel.userRoleId),
                        //     //          uuId: globalUserMaster!.uuId,
                        //     //          birthdate: globalUserMaster!.birthdate,
                        //     //          age: globalUserMaster!.age,
                        //     //          height: globalUserMaster!.height,
                        //     //          weight: globalUserMaster!.weight,
                        //     //          bmiScore: globalUserMaster!.bmiScore,
                        //     //          bmiType: globalUserMaster!.bmiType,
                        //     //          badTime: globalUserMaster!.badTime,
                        //     //          wakeUpTime: globalUserMaster!.wakeUpTime,
                        //     //          totalSleepTime: globalUserMaster!.totalSleepTime,
                        //     //          waterMl: globalUserMaster!.waterMl,
                        //     //          gender: globalUserMaster!.gender,
                        //     //          genderType: globalUserMaster!.genderType,
                        //     //          mobile: globalUserMaster!.mobile,
                        //     //          deviceToken: globalUserMaster!.deviceToken,
                        //     //          image: globalUserMaster!.image,
                        //     //          relationshipStatus: globalUserMaster!.relationshipStatus,
                        //     //          averageCycleLength: cycleData['cycleLength'],
                        //     //          previousPeriodsBegin: cycleData['previousPeriodDate'],
                        //     //          previousPeriodsMonth: cycleData['previousPeriodMonth'],
                        //     //          averagePeriodLength: cycleData['periodsLength'],
                        //     //          humApkeHeKon: globalUserMaster!.humApkeHeKon,
                        //     //          status: globalUserMaster!.status,
                        //     //          state: globalUserMaster!.state,
                        //     //          city: globalUserMaster!.city
                        //     //      );
                        //     //
                        //     //      AppPreferences.instance.setUserDetails(
                        //     //          jsonEncode(userMaster));
                        //     //      gUserType = singInViewModel.userRoleId.toString();
                        //     //
                        //     //
                        //     //
                        //     //      mViewModel.userUpdateDetailsApi(
                        //     //        isFromCycle: true,
                        //     //        name: widget.welcomeData['name'],
                        //     //        roleId: "4",
                        //     //        birthdate: widget.welcomeData['birthdate'],
                        //     //        gender: widget.welcomeData['gender'],
                        //     //        genderType: widget.welcomeData['otherGender'],
                        //     //        relationshipStatus: widget.welcomeData['relation'],
                        //     //        averageCycleLength: cycleData['cycleLength'],
                        //     //        previousPeriodsBegin:
                        //     //        cycleData['previousPeriodDate'],
                        //     //        previousPeriodsMonth:
                        //     //        cycleData['previousPeriodMonth'],
                        //     //        averagePeriodLength: cycleData['periodsLength'],
                        //     //      ).whenComplete(() {
                        //     //        // SplashViewModel().checkGlobalUserData();
                        //     //      });
                        //     //    }
                        //     //
                        //     // }
                        //     // else  {
                        //     //
                        //     //   mViewModel.userUpdateDetailsApi(
                        //     //     isFromCycle: true,
                        //     //     name: widget.welcomeData['name'],
                        //     //     birthdate: widget.welcomeData['birthdate'],
                        //     //     gender: widget.welcomeData['gender'],
                        //     //     genderType: widget.welcomeData['otherGender'],
                        //     //     relationshipStatus: widget.welcomeData['relation'],
                        //     //     averageCycleLength: cycleData['cycleLength'],
                        //     //     previousPeriodsBegin:
                        //     //     cycleData['previousPeriodDate'],
                        //     //     previousPeriodsMonth:
                        //     //     cycleData['previousPeriodMonth'],
                        //     //     averagePeriodLength: cycleData['periodsLength'],
                        //     //   );
                        //     //
                        //     //
                        //     // }
                        //
                        //
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isValid() {
    if (pageController.page == 2 &&
        selectedPreviousPeriodDate == null &&
        isPeriodsOnAfter55) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectPreviousPeriodDate,
        color: CommonColors.mRed,
      );
      return false;
    }
    // else if (currentIndex == 2 && selectedGender == null && mOtherController.text.trim().isEmpty) {
    //   CommonUtils.showSnackBar(
    //     S.of(context)!.plSelectYourGender,
    //     color: CommonColors.mRed,
    //   );
    //   return false;
    // }
    else {
      return true;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollPeriodLengthController.dispose();
    super.dispose();
  }
}

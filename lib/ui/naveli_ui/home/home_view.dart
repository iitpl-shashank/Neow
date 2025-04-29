import 'dart:async';

// import 'package:widgets_easier/widgets_easier.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/healthmix_detail_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/shorts/short_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/track_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track_helath_view_all/track_health_view_all_view.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

// import 'package:naveli_2023/ui/navaeli_ui/symptom_bot/symptom_bot_view.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/common_daily_insight_container.dart';
import '../../../widgets/healthmix_category_card.dart';
import '../../../widgets/horiozntal.dart';
import '../../../widgets/latest_videos_card.dart';
import '../calendar/calendar_view.dart';
import '../health_mix/health_mix_view_model.dart';
import '../health_mix/post_list.dart';
import '../health_mix/video_particular.dart';
import '../profile/your_naveli/your_naveli_view_model.dart';
import '../symptom_bot/symptom_bot_view.dart';
import 'all_about_periods/all_about_periods_view.dart';
import 'de_stress/de_stress_view.dart';
import 'health_mix_category/health_mix_category_all.dart';
import 'home_view_model.dart';
import 'log_your_symptoms/compulsory_symptoms/compulsory_symptoms_log_view.dart';
import 'log_your_symptoms/log_your_symptoms_view.dart';
import 'log_your_symptoms/log_your_symptoms_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel mViewModel;
  LogYourSymptomsModel? mViewSymptomsModel;
  late HealthMixViewModel mViewHealthMixModel;
  late YourNaveliViewModel mViewYourNaveliModel;
  late VideoPlayerController vdo_Controller;

  // final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  // DateTime previousDate = DateTime(int.parse(globalUserMaster?.previousPeriodsBegin ?? ''));

  int cycleLength = int.parse(globalUserMaster?.averageCycleLength ?? "28");

//Shifted to bottom view
  // String dateString = globalUserMaster?.previousPeriodsBegin ?? '';

  //String daysToGo = "";

  String? acceptedUniqueId;

  var bgColor = 0XFFFBF5F7;

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startAutoSlide();
    vdo_Controller = VideoPlayerController.asset('assets/video/home_screen.mp4')
      ..initialize().then((_) {
        vdo_Controller.setLooping(true); // Set looping for continuous playback
        vdo_Controller.play();
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });

    Future.delayed(
      Duration.zero,
      () {
        mViewModel.attachedContext(context);
        //Shifted to bottom view
        // mViewModel.fetchHealthMixCategoryList();

        // Loading Issue
        // mViewModel.getDialogBox(context);

        mViewYourNaveliModel =
            Provider.of<YourNaveliViewModel>(context, listen: false);
        mViewHealthMixModel =
            Provider.of<HealthMixViewModel>(context, listen: false);
        mViewSymptomsModel =
            Provider.of<LogYourSymptomsModel>(context, listen: false);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          //Shifted to bottom view
          // mViewModel.getPeriodInfoList();

          await handleFirstBloc();
          //Shifted to bottom view
          // await mViewModel.handleSecondBloc(dateString);
          await handleThirdBloc();
          print("diipppka1");
          //mViewModel.fetchData();
          _setTimeout();
          //Shifted to bottom view
          // mViewModel.updateSelectedDate(DateTime.now());
        });
      },
    );

    // handleFirstBloc();
    // handleSecondBloc();
    // handleThirdBloc();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mViewModel.currentPage < 3) {
        mViewModel.currentPage++;
      } else {
        mViewModel.currentPage = 0; // Reset to the first page
      }
      mViewModel.pageController.animateToPage(
        mViewModel.currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void navigateToCalendarView() async {
    isLogEdit = true;
    // Push to CalendarView page and wait for result when back is pressed
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarView()),
    ).then((onValue) {
      print("DIPAKAKKA");
      callApiAfterBack();
    });

    // Call your API after the user goes back
    /*Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);

      mViewYourNaveliModel =
          Provider.of<YourNaveliViewModel>(context, listen: false);
      mViewHealthMixModel =
          Provider.of<HealthMixViewModel>(context, listen: false);
      mViewSymptomsModel =
          Provider.of<LogYourSymptomsModel>(context, listen: false);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        timeoutValue = 1;
        await mViewModel.fetchData();
        // await handleFirstBloc();
        // await handleSecondBloc();
        // await handleThirdBloc();
        setState(() {
          timeoutValue = 2;
        });
        _setTimeout();
      });
    });*/
  }

// Function to call API after coming back from the CalendarView
  void callApiAfterBack() async {
    //mViewModel.fetchData();
    mViewModel.getPeriodInfoList();
    /*if (peroidCustomeList.length > 0) {
      await handleSecondBloc(peroidCustomeList[0].predicated_period_start_date);
    }*/
  }

  int timeoutValue = 1;

  void _setTimeout() {
    Future.delayed(Duration(seconds: 5, milliseconds: 500), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          timeoutValue = 2;
        });
      });
    });
  }

  bool isCycleStartFromTommorw() {
//     if (peroidCustomeList.isNotEmpty) {
//       DateTime startPredicatedPeriods =
//       // DateTime.parse(peroidCustomeList[0].predicated_period_start_date);
//       // Get the current date and add one day to it
// //       DateTime tomorrow = DateTime.now().add(Duration(days: 1));
// // // Check if startDate is tomorrow
// //       bool isTomorrow = startPredicatedPeriods.year == tomorrow.year &&
// //           startPredicatedPeriods.month == tomorrow.month &&
// //           startPredicatedPeriods.day == tomorrow.day;
//
//       // return isTomorrow;
//     }
    return false;
  }

  Future<void> handleFirstBloc() async {
    if (gUserType == AppConstants.BUDDY) {
      await mViewYourNaveliModel.getBuddyAlreadySendRequestApi();
      for (var buddyData
          in mViewYourNaveliModel.buddyAlreadySendRequestDataList) {
        if (buddyData.notificationStatus == "accepted") {
          acceptedUniqueId = buddyData.uniqueId;
          break;
        }
      }
      if (acceptedUniqueId != null) {
        AppPreferences.instance.setBuddyAccess(true);
        await mViewYourNaveliModel.getDataFromUidApi(
            uniqueId: acceptedUniqueId);
      } else {
        AppPreferences.instance.setBuddyAccess(false);
      }
    }
  }

  Future<void> handleThirdBloc() async {
    DateTime currentDate = DateTime.now();
    DateTime dateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    // mViewModel.startSlider();
    mViewHealthMixModel.getHealthMixPostsApi(titleId: 1, type: "Popular");
    /* mViewModel.getSliderVideoApi().whenComplete(
          () => mViewHealthMixModel
              .getHealthMixPostsApi(titleId: 7)
              .whenComplete(
                () => mViewSymptomsModel
                    ?.getUserSymptomsLogApi(
                        date: globalUserMaster?.previousPeriodsBegin ?? '')
                    .whenComplete(() {
                  if (gUserType == AppConstants.NEOWME) {
                    if (mViewModel.nextCycleDates.contains(dateWithoutTime)) {
                      checkForCompulsorySymptoms();
                    }
                  }
                }),
              ),
        ); */
  }

  void checkForCompulsorySymptoms() {
    mViewModel.timerSymptoms = Timer.periodic(
      const Duration(minutes: 3),
      (timer) {
        if (gUserType == AppConstants.NEOWME &&
            (mViewSymptomsModel?.userSymptomsData?.staining == null ||
                mViewSymptomsModel?.userSymptomsData?.clotSize == null ||
                mViewSymptomsModel?.userSymptomsData?.collectionMethod ==
                    null ||
                mViewSymptomsModel?.userSymptomsData?.frequencyOfChangeDay ==
                    null ||
                mViewSymptomsModel?.userSymptomsData?.workingAbility == null ||
                mViewSymptomsModel?.userSymptomsData?.location == null ||
                mViewSymptomsModel?.userSymptomsData?.cramps == null ||
                mViewSymptomsModel?.userSymptomsData?.days == null)) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop();
                mViewModel.timerSymptoms?.cancel();
                push(const CompulsorySymptomsLogView()).then((value) =>
                    mViewSymptomsModel
                        ?.getUserSymptomsLogApi(
                            date: globalUserMaster?.previousPeriodsBegin ?? '')
                        .whenComplete(() => checkForCompulsorySymptoms()));
              });
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kCommonSpaceV20,
                    Text(
                      'Please log your\n Symptoms',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.piedra(
                        color: CommonColors.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    kCommonSpaceV20,
                    Image.asset(
                      LocalImages.img_pl_log_symptoms,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          mViewModel.timerSymptoms?.cancel();
          print(".....All is well.....");
        }
      },
    );
  }

  bool getLogSymtopmActive() {
    if (mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 1" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 2" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 3" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 4" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 5" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 6") {
      return true;
    } else {
      return false;
    }
  }

  String getUrlOntimeOut() {
    if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("Period Day")) {
      return LocalImages.red_Static;
    } else if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("late")) {
      return LocalImages.white_Static;
    } else if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("after")) {
      //red
      return LocalImages.not_fertile;
    } else if (mViewModel
            .getCycleDayOrDaysToGo(mViewModel.selectedDate)
            .contains("Ovulation Day") ||
        mViewModel
            .getCycleDayOrDaysToGo(mViewModel.selectedDate)
            .contains("Ovulation in") ||
        mViewModel
            .getCycleDayOrDaysToGo(mViewModel.selectedDate)
            .contains("before")) {
      return LocalImages.green_Static;
    } else {
      return LocalImages.white_Static;
    }
  }

  String getUrlForGif() {
    if (mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 1" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 2" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 3" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 4" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 5" ||
        mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) ==
            "Period day 6") {
      return LocalImages.red_loader;
    } else if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("late")) {
      return LocalImages.white_loader;
    } else if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("after")) {
      //red
      return LocalImages.not_fertile_loader;
    } else if (mViewModel
        .getCycleDayOrDaysToGo(mViewModel.selectedDate)
        .contains("Period in")) {
      return LocalImages.green_loader;
    } else {
      return LocalImages.white_loader;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    vdo_Controller.dispose();
    mViewModel.timerSlider?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    mViewHealthMixModel = Provider.of<HealthMixViewModel>(context);
    mViewSymptomsModel = Provider.of<LogYourSymptomsModel>(context);
    mViewYourNaveliModel = Provider.of<YourNaveliViewModel>(context);
    String username = globalUserMaster?.name.toString().split(' ')[0] ?? '';
    int no = 0;

    // print(username);
    // var calender2 = Container(
    //   height: 80.0,
    //   // color: Colors.amberAccent,
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Stack(
    //       children: [
    //         // Positioned(
    //         //   bottom: 14.0,
    //         //   child: Container(
    //         //     height: 15.0,
    //         //     width: 50 * (mViewModel.gradientColorsList().length - 1),
    //         //     margin: EdgeInsets.only(left: 40.0),
    //         //     decoration: BoxDecoration(
    //         //       gradient: LinearGradient(
    //         //         begin: Alignment.centerLeft,
    //         //         end: Alignment.centerRight,
    //         //         colors: mViewModel.gradientColorsList(),
    //         //       ),
    //         //     ),
    //         //   ),
    //         // ),
    //         ListView.separated(
    //           itemCount: mViewModel.daysList.length,
    //           shrinkWrap: true,
    //           padding: EdgeInsets.only(left: 5.0),
    //           physics: ClampingScrollPhysics(),
    //           scrollDirection: Axis.horizontal,
    //           separatorBuilder: (context, index) {
    //             return Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Container(
    //                   color: Colors.transparent,
    //                   width: 10.00,
    //                   height: 20.0,
    //                 ),
    //                 SizedBox(
    //                   height: 12.0,
    //                 ),
    //               ],
    //             );
    //           },
    //           itemBuilder: (context, index) {
    //             DateTime currentDate = mViewModel.daysList[index];
    //             String weekDay = mViewModel.getWeekDay(currentDate);
    //             String formattedDate = '${currentDate.day}';
    //             bool isCycleDate = mViewModel.nextCycleDates.any((date) =>
    //                 date.year == currentDate.year &&
    //                 date.month == currentDate.month &&
    //                 date.day == currentDate.day);
    //             return Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   weekDay,
    //                   style: getAppStyle(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 18.0,
    //                     color: isCycleDate
    //                         ? CommonColors.primaryColor.withOpacity(0.9)
    //                         : CommonColors.color_8b8b8b,
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     print("ala ayyyyyy haaaaaaaaaaa......");
    //                   },
    //                   child: Container(
    //                     height: 45.0,
    //                     width: 42.0,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                           isCycleDate ? LocalImages.img_drop_blood : "",
    //                         ),
    //                       ),
    //                       // color: isCycleDate ? null : Colors.transparent,
    //                       // gradient: isCycleDate ? mViewModel.getGradient() : null,
    //                       // shape: BoxShape.circle,
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(top: 12),
    //                       child: Center(
    //                         child: Text(
    //                           formattedDate,
    //                           style: TextStyle(
    //                             color: isCycleDate
    //                                 ? CommonColors.mWhite
    //                                 : CommonColors.blackColor,
    //                             fontWeight: FontWeight.w500,
    //                             fontSize: 15.0,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     // Center(
    //                     //   child: Text(
    //                     //     formattedDate,
    //                     //     style: getAppStyle(
    //                     //       fontWeight: FontWeight.w500,
    //                     //       fontSize: 18.0,
    //                     //       color: isCycleDate
    //                     //           ? CommonColors.mWhite
    //                     //           : CommonColors.blackColor,
    //                     //     ),
    //                     //   ),
    //                     // ),
    //                   ),
    //                 ),
    //               ],
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    var calender2 = HorizontalCalendar(
      mViewModel: mViewModel,
    );

    // Column(
    //   children: [
    //
    //     Container(
    //       color: Color(bgColor),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(DateFormat('MMMM').format(mViewModel.selectedDate),style: TextStyle(
    //             fontWeight: FontWeight.w500,
    //             fontSize: 25.0,
    //           ) ,)
    //         ],
    //       ),
    //     ),
    //     Container(
    //       color: Color(bgColor),
    //       height: 10,),
    //     SizedBox(
    //       height: 80.0,
    //       child: Container(
    //         padding: const EdgeInsets.only(left: 15, right: 15),
    //         color: Color(bgColor),
    //         child: SingleChildScrollView(
    //           // Container(const BoxDecoration(backgroundColor:CommonColors.bglightPinkColor)),
    //
    //           scrollDirection: Axis.horizontal,
    //           // padding: const EdgeInsets.only(left: 12, right: 12),
    //           child: ListView.separated(
    //             itemCount: mViewModel.daysList.length,
    //             shrinkWrap: true,
    //             physics: const ClampingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             separatorBuilder: (context, index) {
    //               DateTime currentDate = mViewModel.daysList[index];
    //               String weekDay = mViewModel.getWeekDay(currentDate);
    //               String formattedDate = '${currentDate.day}';
    //               bool isCycleDate = false;
    //               int countDay = 0;
    //
    //               for (var dateRange in peroidCustomeList) {
    //                 DateTime start = DateTime.parse(dateRange.period_start_date);
    //                 DateTime end = DateTime.parse(dateRange.period_end_date);
    //                 int cycleLength = int.parse(dateRange.period_cycle_length);
    //                 if (currentDate.isAfter(start) && currentDate.isBefore(end) ||
    //                     currentDate.isAtSameMomentAs(start) ||
    //                     currentDate.isAtSameMomentAs(end)) {
    //                   isCycleDate = true;
    //                   print('countDay:  $countDay');
    //                 }
    //               }
    //               countDay++;
    //
    //               int clen = int.parse(peroidCustomeList.last.period_length ?? "5");
    //               double opc = 0.0;
    //
    //               if (isCycleDate) {
    //                 no++;
    //                 opc = (1 - ((1 / clen) * no)).clamp(0.0, 1.0);
    //               }
    //               if (no > clen) {
    //                 no = 0;
    //               }
    //
    //               //
    //               // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //               //   mViewModel.getPeriodInfoList();
    //               //   await handleFirstBloc();
    //               //   // await mViewModel.handleSecondBloc(dateString);
    //               //   await handleThirdBloc();
    //               //   print("diipppka1");
    //               //   //mViewModel.fetchData();
    //               //   _setTimeout();
    //               // });
    //
    //               return Container(
    //                 color: isCycleDate
    //                     ? (no < clen
    //                     ? Color(0xFFFFB5AE).withOpacity(opc)
    //                     : Color(bgColor))
    //                     : Color(bgColor),
    //                 width: 35,
    //                 child: Column(
    //                   children: [
    //                     SizedBox(
    //                       height: 40.0,
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                           color: Color(bgColor),
    //                           borderRadius: BorderRadius.vertical(
    //                               bottom: Radius.elliptical(20.0, 8.0)),
    //                         ),
    //                       ),
    //                     ),
    //                     kCommonSpaceV10,
    //                     SizedBox(
    //                       height: 30.0,
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                           color: Color(bgColor),
    //                           borderRadius: BorderRadius.vertical(
    //                               top: Radius.elliptical(15.0, 8.0)),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //             itemBuilder: (context, index) {
    //               DateTime currentDate = mViewModel.daysList[index];
    //               String weekDay = mViewModel.getWeekDay(currentDate);
    //               String formattedDate = '${currentDate.day}';
    //               bool isCycleDate = false;
    //               bool isPredictedDate = false;
    //
    //               for (var dateRange in peroidCustomeList) {
    //                 DateTime start = DateTime.parse(dateRange.period_start_date);
    //                 DateTime end = DateTime.parse(dateRange.period_end_date)
    //                     .add(Duration(days: 1));
    //                 cycleLength = int.parse(dateRange.period_cycle_length);
    //
    //                 if ((currentDate.isAfter(start) && currentDate.isBefore(end)) ||
    //                     currentDate.isAtSameMomentAs(start) ||
    //                     currentDate.isAtSameMomentAs(end)) {
    //                   isCycleDate = true;
    //                   break;
    //                 }
    //
    //                 DateTime startPredicated =
    //                 DateTime.parse(dateRange.predicated_period_start_date);
    //                 DateTime endPredicated =
    //                 DateTime.parse(dateRange.predicated_period_end_date);
    //
    //                 if ((currentDate.isAfter(startPredicated) &&
    //                     currentDate.isBefore(endPredicated)) ||
    //                     currentDate.isAtSameMomentAs(startPredicated) ||
    //                     currentDate.isAtSameMomentAs(endPredicated)) {
    //                   isPredictedDate = true;
    //                   break;
    //                 }
    //               }
    //
    //               DateTime today = DateTime.now();
    //               bool isToday = currentDate.year == today.year &&
    //                   currentDate.month == today.month &&
    //                   currentDate.day == today.day;
    //               bool isSelectedDate = currentDate.year == mViewModel.selectedDate.year &&
    //                   currentDate.month == mViewModel.selectedDate.month &&
    //                   currentDate.day == mViewModel.selectedDate.day;
    //               // currentDate.isAtSameMomentAs(mViewModel.selectedDate);
    //               int clen = int.parse(peroidCustomeList.last.period_length ?? "5");
    //               double opc =
    //               isCycleDate ? (1 - ((1 / clen) * no)).clamp(0.0, 1.0) : 0.0;
    //
    //               return Container(
    //                 decoration: BoxDecoration(color: Color(bgColor)),
    //                 child: Column(
    //                   children: [
    //                     Text(
    //                       isToday ? "Today" : weekDay,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.w500,
    //                           fontSize: 16.0,
    //                           color: Colors.black),
    //                     ),
    //                     GestureDetector(
    //                       onTap: () => mViewModel.updateSelectedDate(currentDate),
    //                       child: Container(
    //                         height: 45.0,
    //                         width: 42.0,
    //                         decoration: BoxDecoration(
    //                           gradient: isSelectedDate
    //                               ? isCycleDate
    //                               ? LinearGradient(
    //                               colors: [Colors.white, Colors.white])
    //                               : LinearGradient(colors: [
    //                             Color(0xFFDBDBDB),
    //                             Color(0xFFDBDBDB)
    //                           ])
    //                               : isCycleDate
    //                               ? LinearGradient(colors: [
    //                             Color(0xFFFF9D93),
    //                             Color(0xFFFFB5AE).withOpacity(opc)
    //                           ])
    //                               : isPredictedDate
    //                               ? LinearGradient(
    //                               colors: [Colors.white, Colors.white])
    //                               : null,
    //                           shape: BoxShape.circle,
    //                         ),
    //                         child: DottedBorder(
    //                           color: isSelectedDate
    //                               ? (isCycleDate
    //                               ? CommonColors.mRed
    //                               : CommonColors.mTransparent)
    //                               : (isPredictedDate
    //                               ? CommonColors.mRed
    //                               : CommonColors.mTransparent),
    //                           dashPattern: [4, 3],
    //                           strokeWidth:
    //                           isSelectedDate || isPredictedDate ? 2 : 0,
    //                           borderType: BorderType.Circle,
    //                           child: Center(
    //                             child: Text(
    //                               formattedDate,
    //                               style: TextStyle(
    //                                 color: isSelectedDate
    //                                     ? Colors.black
    //                                     : (isCycleDate
    //                                     ? CommonColors.mRed
    //                                     : Colors.black),
    //                                 fontWeight: FontWeight.w500,
    //                                 fontSize: 15.0,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //
    //           // ListView.separated(
    //           //   // backgroundColor:CommonColors.bglightPinkColor,
    //           //   itemCount: mViewModel.daysList.length,
    //           //   shrinkWrap: true,
    //           //   // padding: const EdgeInsets.only(left: 5.0),
    //           //   physics: const ClampingScrollPhysics(),
    //           //   scrollDirection: Axis.horizontal,
    //           //   separatorBuilder: (context, index) {
    //           //     DateTime currentDate = mViewModel.daysList[index];
    //           //     String weekDay = mViewModel.getWeekDay(currentDate);
    //           //     String formattedDate = '${currentDate.day}';
    //           //     bool isCycleDate = false;
    //           //     int countDay = 0;
    //           //     for (var dateRange in peroidCustomeList) {
    //           //       DateTime start = DateTime.parse(dateRange.period_start_date);
    //           //
    //           //       DateTime end = DateTime.parse(dateRange.period_end_date);
    //           //       int cycleLength = int.parse(dateRange.period_cycle_length);
    //           //       if (currentDate.isAfter(start) && currentDate.isBefore(end) ||
    //           //           currentDate.isAtSameMomentAs(start) ||
    //           //           currentDate.isAtSameMomentAs(end)) {
    //           //         isCycleDate = true;
    //           //         print('countDay:  $countDay');
    //           //       }
    //           //     }
    //           //
    //           //     countDay++;
    //           //     // bool isCycleDate = mViewModel.nextCycleDates.any((date) =>
    //           //     //     date.year == currentDate.year &&
    //           //     //     date.month == currentDate.month &&
    //           //     //     date.day == currentDate.day);
    //           //     /* CycleDates cd = gCycleDates.any((cycleDate)=>
    //           //     cycleDate.date.year == currentDate.year &&
    //           //     cycleDate.date.month == currentDate.month &&
    //           //     cycleDate.date.day == currentDate.day
    //           //   );
    //           //   bool isCycleDate = false
    //           //   int cycleDay = 0;
    //           //   if(cd!=null){
    //           //     isCycleDate = true;
    //           //     cycleDay = cd.periodDay;
    //           //   } */
    //           //
    //           //     // int clen = int.parse(globalUserMaster?.averagePeriodLength ?? "5");
    //           //     int clen = int.parse(
    //           //         peroidCustomeList[peroidCustomeList.length - 1]
    //           //             .period_length ?? "5");
    //           //     double opc = 0.0;
    //           //     /* no++;
    //           //   print(no); */
    //           //     if (isCycleDate) {
    //           //       no++;
    //           //       opc = 1 - ((1 / clen) * no);
    //           //     }
    //           //     if (no > clen) {
    //           //       no = 0;
    //           //     }
    //           //
    //           //     // opc = (1 - ((1 / clen) * no)).clamp(0.0, 1.0);
    //           //
    //           //     return
    //           //     //   SizedBox(
    //           //     //   width: 35,
    //           //     // );
    //           //
    //           //       Container(
    //           //         color:
    //           //         isCycleDate ? no < clen
    //           //             ? Color(0xFFFFB5AE).withOpacity(opc)
    //           //             : Color(bgColor)
    //           //             : Color(bgColor),
    //           //         width: 35,
    //           //         // padding: EdgeInsets.only(left: 0.0, right: 0.0),
    //           //         child: Column(
    //           //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //           children: [
    //           //             SizedBox(
    //           //                 height: 40.0,
    //           //                 child: Container(
    //           //                   decoration: BoxDecoration(
    //           //                     color: Color(bgColor),
    //           //                     borderRadius: BorderRadius.vertical(
    //           //                         bottom: Radius.elliptical(20.0, 8.0)),
    //           //                   ),
    //           //                 )),
    //           //             kCommonSpaceV10,
    //           //             SizedBox(
    //           //                 height: 30.0,
    //           //                 child: Container(
    //           //                   decoration: BoxDecoration(
    //           //                     color: Color(bgColor),
    //           //                     borderRadius: BorderRadius.vertical(
    //           //                         top: Radius.elliptical(15.0, 8.0)),
    //           //                   ),
    //           //                 )),
    //           //           ],
    //           //         ));
    //           //   },
    //           //   itemBuilder: (context, index) {
    //           //     DateTime currentDate = mViewModel.daysList[index];
    //           //     String weekDay = mViewModel.getWeekDay(currentDate);
    //           //     String formattedDate = '${currentDate.day}';
    //           //
    //           //     bool isCycleDate = false;
    //           //     bool isPredictedDate = false;
    //           //
    //           //     for (var dateRange in peroidCustomeList) {
    //           //       DateTime start = DateTime.parse(dateRange.period_start_date);
    //           //       DateTime end = DateTime.parse(dateRange.period_end_date);
    //           //
    //           //       // Add 1 day to the end date
    //           //       end = end.add(Duration(days: 1));
    //           //
    //           //       cycleLength = int.parse(dateRange.period_cycle_length);
    //           //
    //           //       // Check if the current date is within the range, considering the adjusted end date
    //           //       if ((currentDate.isAfter(start) && currentDate.isBefore(end)) ||
    //           //           currentDate.isAtSameMomentAs(start) ||
    //           //           currentDate.isAtSameMomentAs(end)) {
    //           //         isCycleDate = true;
    //           //         break; // Exit loop once you find the matching range
    //           //       }
    //           //
    //           //       ///This calculation for future predicated dates
    //           //       DateTime startPredicatedPeriods = DateTime.parse(
    //           //           dateRange.predicated_period_start_date);
    //           //       DateTime endPredicatedPeriods = DateTime.parse(
    //           //           dateRange.predicated_period_end_date);
    //           //
    //           //       // Add 1 day to the end date
    //           //       endPredicatedPeriods =
    //           //           endPredicatedPeriods.add(Duration(days: 1));
    //           //
    //           //       if ((currentDate.isAfter(startPredicatedPeriods) &&
    //           //           currentDate.isBefore(endPredicatedPeriods)) ||
    //           //           currentDate.isAtSameMomentAs(startPredicatedPeriods) ||
    //           //           currentDate.isAtSameMomentAs(endPredicatedPeriods)) {
    //           //         isPredictedDate = true;
    //           //         break; // Exit loop once you find the matching range
    //           //       }
    //           //     }
    //           //     // bool isCycleDate = mViewModel.nextCycleDates.any((date) =>
    //           //     //     date.year == currentDate.year &&
    //           //     //     date.month == currentDate.month &&
    //           //     //     date.day == currentDate.day);
    //           //
    //           //     DateTime today = DateTime.now();
    //           //     bool isToday = currentDate.year == today.year &&
    //           //         currentDate.month == today.month &&
    //           //         currentDate.day == today.day;
    //           //     bool isSelectedDate =
    //           //         currentDate.year == mViewModel.selectedDate.year &&
    //           //             currentDate.month == mViewModel.selectedDate.month &&
    //           //             currentDate.day == mViewModel.selectedDate.day;
    //           //     int clen = int.parse(
    //           //         peroidCustomeList[peroidCustomeList.length - 1]
    //           //             .period_length ?? "5");
    //           //     /*int.parse(globalUserMaster?.averagePeriodLength ?? "5");*/
    //           //     double opc = 0.0;
    //           //     /* no++;
    //           //   print(no); */
    //           //     if (isCycleDate) {
    //           //       // no++;
    //           //       opc = 1 - ((1 / clen) * no);
    //           //       /* if(no>0){
    //           //       opc == 1/no;
    //           //     } */
    //           //       print(opc);
    //           //     }
    //           //     /* if(no>clen){
    //           //     no = 0;
    //           //   } */
    //           //     /* bool isOvulation = mViewModel.ovulationDates.any((date) =>
    //           //       date.year == currentDate.year &&
    //           //       date.month == currentDate.month &&
    //           //       date.day == currentDate.day);
    //           //
    //           //   bool isFirtile = mViewModel.firtileDates.any((date) =>
    //           //       date.year == currentDate.year &&
    //           //       date.month == currentDate.month &&
    //           //       date.day == currentDate.day); */
    //           //
    //           //     return Container(
    //           //       padding: const EdgeInsets.only(left: 0, right: 0),
    //           //       decoration: BoxDecoration(
    //           //         color: Color(bgColor),
    //           //       ),
    //           //       child: Column(
    //           //         mainAxisSize: MainAxisSize.min,
    //           //         crossAxisAlignment: CrossAxisAlignment.center,
    //           //         children: [
    //           //           Text(
    //           //             isToday ? "Today" : weekDay,
    //           //             style: TextStyle(
    //           //               fontWeight: FontWeight.w500,
    //           //               fontSize: 16.0,
    //           //               color: Colors.black,
    //           //             ),
    //           //           ),
    //           //           GestureDetector(
    //           //             onTap: () {
    //           //               mViewModel.updateSelectedDate(currentDate);
    //           //             },
    //           //             child: Container(
    //           //               height: 45.0,
    //           //               width: 42.0,
    //           //               padding: const EdgeInsets.all(0.0),
    //           //               // padding: const EdgeInsets.only(left: 12, right: 12),
    //           //               decoration: BoxDecoration(
    //           //                 gradient: isSelectedDate
    //           //                     ? isCycleDate
    //           //                     ? const LinearGradient(
    //           //                   begin: Alignment.topCenter,
    //           //                   end: Alignment.bottomCenter,
    //           //                   colors: [
    //           //                     Color(0xFFFFFFFF),
    //           //                     Color(0xFFFFFFFF),
    //           //                   ],
    //           //                 )
    //           //                     : const LinearGradient(
    //           //                   begin: Alignment.topCenter,
    //           //                   end: Alignment.bottomCenter,
    //           //                   colors: [
    //           //                     Color(0xFFDBDBDB),
    //           //                     Color(0xFFDBDBDB),
    //           //                   ],
    //           //                 )
    //           //                     : isCycleDate
    //           //                     ? LinearGradient(
    //           //                   begin: Alignment.centerLeft,
    //           //                   end: Alignment.centerRight,
    //           //                   colors: [
    //           //                     Color(0xFFFF9D93),
    //           //                     Color(0xFFFFB5AE).withOpacity(opc),
    //           //                   ],
    //           //                 )
    //           //                     : isPredictedDate ? LinearGradient(
    //           //                   begin: Alignment.topCenter,
    //           //                   end: Alignment.bottomCenter,
    //           //                   colors: [
    //           //                     Color(0xFFFFFFFF),
    //           //                     Color(0xFFFFFFFF),
    //           //                   ],
    //           //                 ) : null,
    //           //                 shape: BoxShape.circle,
    //           //                 // border: Border.all(width: 1.5, color: CommonColors.mRed,style:BorderStyle.solid)
    //           //               ),
    //           //               child: DottedBorder(
    //           //                 color: isSelectedDate
    //           //                     ? isCycleDate
    //           //                     ? CommonColors.mRed
    //           //                     : CommonColors.mTransparent
    //           //                     : isPredictedDate
    //           //                     ? CommonColors.mRed
    //           //                     : CommonColors.mTransparent,
    //           //                 dashPattern: [4, 3],
    //           //                 strokeWidth: isSelectedDate
    //           //                     ? isCycleDate
    //           //                     ? 2
    //           //                     : 0
    //           //                     : isPredictedDate ? 2 : 0,
    //           //                 borderType: BorderType.Circle,
    //           //                 child: Padding(
    //           //                   padding: const EdgeInsets.only(
    //           //                     top: 0,
    //           //                     left: 0,
    //           //                     right: 0,
    //           //                   ),
    //           //                   child: Center(
    //           //                     child: Text(
    //           //                       formattedDate,
    //           //                       style: TextStyle(
    //           //                         color: isSelectedDate
    //           //                             ? Colors.black
    //           //                             : isCycleDate
    //           //                             ? CommonColors.mRed
    //           //                             : Colors.black,
    //           //                         fontWeight: FontWeight.w500,
    //           //                         fontSize: 15.0,
    //           //                       ),
    //           //                     ),
    //           //                   ),
    //           //                 ),
    //           //               ),
    //           //             ),
    //           //           ),
    //           //         ],
    //           //       ),
    //           //     );
    //           //   },
    //           // ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    ///

    // var calender2 = Container(
    //   // height: kDeviceHeight / 8.5,
    //   height: 88.0,
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           bottom: 14.0,
    //           child: Container(
    //             height: 15.0,
    //             width: 50 * (mViewModel.gradientColorsList().length - 1),
    //             margin: EdgeInsets.only(left: 40.0),
    //             decoration: BoxDecoration(
    //                 gradient: LinearGradient(
    //                     begin: Alignment.centerLeft,
    //                     end: Alignment.centerRight,
    //                     colors: mViewModel.gradientColorsList())),
    //           ),
    //         ),
    //         ListView.separated(
    //           itemCount: tempData.length,
    //           shrinkWrap: true,
    //           padding: EdgeInsets.only(left: 5.0),
    //           physics: ClampingScrollPhysics(),
    //           scrollDirection: Axis.horizontal,
    //           separatorBuilder: (context, index) {
    //             return Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Container(
    //                   color: Colors.transparent,
    //                   width: 10.0,
    //                   height: 20.0,
    //                 ),
    //                 SizedBox(
    //                   height: 12.0,
    //                 ),
    //               ],
    //             );
    //           },
    //           itemBuilder: (context, index) {
    //             return Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   weekDay[index],
    //                   style: getAppStyle(
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 18.0,
    //                       color:
    //                           index > mViewModel.gradientColorsList().length - 1
    //                               ? CommonColors.color_8b8b8b
    //                               : CommonColors.primaryColor),
    //                 ),
    //                 SizedBox(
    //                   height: 13.0,
    //                 ),
    //                 Container(
    //                   height: 42.0,
    //                   width: 42.0,
    //                   decoration: BoxDecoration(
    //                     color:
    //                         index > mViewModel.gradientColorsList().length - 1
    //                             ? Colors.transparent
    //                             : mViewModel.gradientColorsList()[index],
    //                     shape: BoxShape.circle,
    //                   ),
    //                   child: Center(
    //                     child: Text(
    //                       tempData[index].toString(),
    //                       style: getAppStyle(
    //                           fontWeight: FontWeight.w500,
    //                           fontSize: 18.0,
    //                           color: index >
    //                                   mViewModel.gradientColorsList().length - 1
    //                               ? CommonColors.blackColor
    //                               : CommonColors.mWhite),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        /* image: DecorationImage(
          image: AssetImage(LocalImages.img_background),
          fit: BoxFit.cover,
        ), */
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor:Colors.red,
            title: Text("Hi, NeoW $username!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),

            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () {
                    isLogEdit = false;
                    push(CalendarView());
                  }),
            ],
            backgroundColor: Color(bgColor),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            // padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (gUserType == AppConstants.NEOWME ||
                    gUserType == AppConstants.BUDDY) ...[
                  // kCommonSpaceV10,
                  calender2,
                ],
                // Container(
                //   height: 60,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //         LocalImages.img_drop_blood,
                //       ),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 10),
                //     child: Center(
                //       child: Text(
                //         "30",
                //         style: TextStyle(
                //           color: CommonColors.mWhite,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 18.0,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // kCommonSpaceV10,
                /* SizedBox(
                  height: kDeviceHeight / 7,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: <Widget>[
                      CommonRoundedContainer(
                        onTap: () {
                          push(const YouKnowView());
                        },
                        text: S.of(context)!.doYouKnow,
                        image: LocalImages.img_you_know,
                      ),
                      CommonRoundedContainer(
                        onTap: () {
                          push(const MythVsFactsView());
                        },
                        text: S.of(context)!.mythVsFacts,
                        image: LocalImages.img_myth,
                      ),
                      CommonRoundedContainer(
                        onTap: () {
                          push(const AllAboutPeriodsView());
                        },
                        text: S.of(context)!.allAboutPeriods,
                        image: LocalImages.img_about_period,
                      ),
                      CommonRoundedContainer(
                        onTap: () {
                          push(const NutritionView());
                        },
                        text: S.of(context)!.nutrition,
                        image: LocalImages.img_nutrition,
                      ),
                      CommonRoundedContainer(
                        onTap: () {
                          push(const WomenInNewsView());
                        },
                        text: S.of(context)!.neowInNews,
                        image: LocalImages.img_women_news,
                      ),
                      CommonRoundedContainer(
                        onTap: () {
                          push(const AskYourQuestionView());
                        },
                        text: S.of(context)!.askYourQuestion,
                        image: LocalImages.img_quiz,
                      ),
                    ]),
                  ),
                ), */
                // kCommonSpaceV20,
                // SizedBox(
                //   height: kDeviceHeight / 3,
                //   child: PageView(
                //     controller: mViewModel.pageController,
                //     onPageChanged: (value) {
                //       setState(() {
                //         mViewModel.currentPage = value;
                //       });
                //     },
                //     children: [
                //       Stack(
                //         children: [
                //           Align(
                //             alignment: Alignment.topLeft,
                //             child: InkWell(
                //               onTap: () {
                //                 push(ReminderView());
                //                 // TimeOfDay? picked = await showTimePicker(
                //                 //   barrierDismissible: false,
                //                 //   context: context,
                //                 //   initialTime: TimeOfDay.now(),
                //                 //   initialEntryMode:
                //                 //       TimePickerEntryMode.inputOnly,
                //                 //   builder:
                //                 //       (BuildContext? context, Widget? child) {
                //                 //     return MediaQuery(
                //                 //       data: MediaQuery.of(context!).copyWith(
                //                 //           alwaysUse24HourFormat: false),
                //                 //       child: child!,
                //                 //     );
                //                 //   },
                //                 // ).then(
                //                 //   (value) => showDialog(
                //                 //     barrierDismissible: false,
                //                 //     context: context,
                //                 //     builder: (BuildContext context) {
                //                 //       Future.delayed(Duration(seconds: 3), () {
                //                 //         Navigator.of(context).pop();
                //                 //       });
                //                 //       return AlertDialog(
                //                 //         content: Column(
                //                 //           mainAxisSize: MainAxisSize.min,
                //                 //           mainAxisAlignment:
                //                 //               MainAxisAlignment.center,
                //                 //           children: [
                //                 //             kCommonSpaceV50,
                //                 //             Text(
                //                 //               'Main Wapas Aunga!\nMain Wapas Aunga!',
                //                 //               textAlign: TextAlign.center,
                //                 //               style: GoogleFonts.piedra(
                //                 //                 color:
                //                 //                     CommonColors.primaryColor,
                //                 //                 fontSize: 30,
                //                 //                 fontWeight: FontWeight.bold,
                //                 //               ),
                //                 //             ),
                //                 //             kCommonSpaceV30,
                //                 //             Image.asset(
                //                 //               LocalImages.img_vapas_aaunga,
                //                 //               fit: BoxFit.cover,
                //                 //               height: MediaQuery.of(context)
                //                 //                       .size
                //                 //                       .height /
                //                 //                   2.5,
                //                 //             ),
                //                 //           ],
                //                 //         ),
                //                 //       );
                //                 //     },
                //                 //   ),
                //                 // );
                //               },
                //               child: Image.asset(
                //                 LocalImages.img_clock,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           Align(
                //             alignment: Alignment.center,
                //             child: Image.asset(
                //               LocalImages.img_naveli_heart,
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //           Align(
                //             alignment: Alignment.topRight,
                //             child: InkWell(
                //               onTap: () {
                //                 push(CalendarView());
                //               },
                //               child: Image.asset(
                //                 LocalImages.img_calendar,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             'Video title...',
                //             style: getAppStyle(fontSize: 22),
                //           ),
                //           Expanded(
                //             child: Container(
                //               color: CommonColors.bglightPinkColor,
                //               child: Center(
                //                 child: Text(
                //                   'Video...',
                //                   style: getAppStyle(fontSize: 25),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                if (gUserType == AppConstants.NEOWME ||
                    gUserType == AppConstants.BUDDY) ...[
                  SizedBox(
                    height: kDeviceHeight / 3,
                    child: Stack(
                      children: [
                        Container(
                          // width:500,
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Color(bgColor),
                            // width:500,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 90.0)),
                            /* borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(360),
                                          bottomRight: Radius.circular(360),
                                        ), */
                            /* borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(6),
                                          ),*/
                          ),
                        ),
                        /* Align(
                                        alignment: Alignment.topLeft,
                                        child: InkWell(
                                          onTap: () {
                                            push(const ReminderView());

                                          },
                                          child: Image.asset(
                                            LocalImages.img_clock,
                                            fit: BoxFit.cover,
                                            height: 50,
                                          ),
                                        ),
                                      ), */
                        /* Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          // width:300,
                                          LocalImages.img_naveli_heart,
                                          // Replace with your image path
                                          fit: BoxFit.cover,
                                        ),
                                      ), */

                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (mViewModel.isLoading)
                                  ? CircularProgressIndicator()
                                  : Visibility(
                                      visible: timeoutValue == 2,
                                      child: Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(mViewModel
                                                  .dateWiseTextList.msg.image),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              mViewModel.dateWiseTextList.msg
                                                  .periodMsg,
                                              style: TextStyle(
                                                  color: mViewModel
                                                          .dateWiseTextList
                                                          .msg
                                                          .color
                                                          .contains("black")
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          )),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          mViewModel
                                              .dateWiseTextList.msg.description,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  CommonColors.darkPrimaryColor,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              )

                              // kCommonSpaceV5,
                              // Container(
                              //     padding: EdgeInsets.symmetric(horizontal: 20),
                              //     child: Text(/*cycleLength <= 14*/
                              //         isWithinFourteenDays
                              //             ? 'That doesn\’t seem right! Irregular periods are usually harmless, but it\'s best to consult your doctor.'
                              //             : 'Unusual Period',
                              //         style: TextStyle(fontSize: 12)),
                              //     alignment: Alignment.center
                              // ),
                              ,
                              kCommonSpaceV5,
                              ElevatedButton(
                                onPressed: () {
                                  navigateToCalendarView();
                                },
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all<Size>(
                                    Size(
                                        120.0, 30.0), // Button width and height
                                  ),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          CommonColors.primaryColor),
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: Text('Log Period',
                                    style: TextStyle(fontSize: 14)),
                              ),
                              /* InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  // barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // backgroundColor: CommonColors.mTransparent,
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "What you want to Edit?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: getAppStyle(
                                                                color: CommonColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22),
                                                          ),
                                                          kCommonSpaceV20,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodDateView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodDate,
                                                            labelColor:
                                                                CommonColors
                                                                    .mWhite,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditCycleLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .cycleLength,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodLength,
                                                            lblSize: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                "Log Period",

                                                style: TextStyle(
                                                    color:
                                                        CommonColors.darkPink,
                                                    fontSize: 20),
                                              ),
                                            ), */
                            ],
                          ),
                        ),

                        /* PageView.builder(
                          controller: mViewModel.pageController,
                          onPageChanged: (value) {
                            setState(() {
                              mViewModel.currentPage = value;
                            });
                          },
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Stack(

                                    children: [
                                      Container(
                                        // width:500,
                                        padding:const EdgeInsets.only(left: 12, right: 12),
                                        decoration:BoxDecoration(color:Color(bgColor),
                                        // width:500,
                                        borderRadius: BorderRadius.vertical(
                                        bottom: Radius.elliptical(
                                        MediaQuery.of(context).size.width, 90.0)
                                        ),
                                        /* borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(360),
                                          bottomRight: Radius.circular(360),
                                        ), */
                                        /* borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(6),
                                          ),*/
                                        ),
                                      ),
                                      /* Align(
                                        alignment: Alignment.topLeft,
                                        child: InkWell(
                                          onTap: () {
                                            push(const ReminderView());

                                          },
                                          child: Image.asset(
                                            LocalImages.img_clock,
                                            fit: BoxFit.cover,
                                            height: 50,
                                          ),
                                        ),
                                      ), */
                                      /* Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          // width:300,
                                          LocalImages.img_naveli_heart,
                                          // Replace with your image path
                                          fit: BoxFit.cover,
                                        ),
                                      ), */
                                      Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            kCommonSpaceV10,
                                            if (mViewModel
                                                    .getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) ==
                                                "Period day")
                                              Text(
                                                mViewModel
                                                    .getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1,

                                                  fontWeight: FontWeight.bold,
                                                  color: CommonColors.mRed,
                                                ),
                                              ),
                                            if (mViewModel.getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) ==
                                                    "Ovulation in 1 Days\n" ||
                                                mViewModel.getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) ==
                                                    "Ovulation in 15 Days\n")
                                              const Text(
                                                "",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1,
                                                  fontWeight: FontWeight.bold,
                                                  color: CommonColors
                                                      .darkPrimaryColor,
                                                ),
                                              ),
                                            if (mViewModel
                                                    .getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) ==
                                                "Ovulation in 0 Days\n")
                                              const Text(
                                                "Predection:\nDay of Ovulation",
                                                textAlign:TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1,

                                                  fontWeight: FontWeight.bold,
                                                  color: CommonColors
                                                      .darkPrimaryColor,
                                                ),
                                              ),
                                            if (mViewModel.getCycleDayOrDaysToGo(mViewModel.selectedDate) != "Ovulation in - 1 Days\n" &&
                                                mViewModel.getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) !=
                                                    "Ovulation in 0 Days\n" &&
                                                mViewModel.getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) !=
                                                    "Ovulation in 15 Days\n" &&
                                                mViewModel.getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate) !=
                                                    "Period day")
                                              Text(
                                                mViewModel
                                                    .getCycleDayOrDaysToGo(
                                                        mViewModel
                                                            .selectedDate),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1,
                                                  fontWeight: FontWeight.w500,
                                                  color: CommonColors
                                                      .darkPrimaryColor,
                                                ),
                                              ),
                                              kCommonSpaceV30,
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Button onPressed action
                                                  push(CalendarView());
                                                  /* showDialog(
                                                  context: context,
                                                  // barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // backgroundColor: CommonColors.mTransparent,
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "What you want to Edit?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: getAppStyle(
                                                                color: CommonColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22),
                                                          ),
                                                          kCommonSpaceV20,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodDateView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodDate,
                                                            labelColor:
                                                                CommonColors
                                                                    .mWhite,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditCycleLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .cycleLength,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodLength,
                                                            lblSize: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ); */
                                                },
                                                style: ButtonStyle(
                                                  fixedSize: MaterialStateProperty.all<Size>(
                                                    Size(150.0, 40.0), // Button width and height
                                                  ),
                                                  backgroundColor:MaterialStateProperty.all<Color>(CommonColors.primaryColor),
                                                  foregroundColor:MaterialStateProperty.all<Color>(Colors.white),
                                                ),
                                                child: Text('Log Period',
                                                style: TextStyle(

                                                    fontSize: 16)
                                                ),
                                              ),
                                            /* InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  // barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // backgroundColor: CommonColors.mTransparent,
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "What you want to Edit?",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: getAppStyle(
                                                                color: CommonColors
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22),
                                                          ),
                                                          kCommonSpaceV20,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodDateView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodDate,
                                                            labelColor:
                                                                CommonColors
                                                                    .mWhite,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditCycleLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .cycleLength,
                                                            lblSize: 15,
                                                          ),
                                                          kCommonSpaceV10,
                                                          PrimaryButton(
                                                            buttonColor:
                                                                CommonColors
                                                                    .primaryColor,
                                                            height: 40,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              push(
                                                                  const EditPeriodLengthView());
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            label: S
                                                                .of(context)!
                                                                .periodLength,
                                                            lblSize: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                "Log Period",

                                                style: TextStyle(
                                                    color:
                                                        CommonColors.darkPink,
                                                    fontSize: 20),
                                              ),
                                            ), */
                                          ],
                                        ),
                                      ),



                                      /* Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            push(const CalendarView());
                                          },
                                          child: Image.asset(
                                            LocalImages.img_calendar,
                                            // Replace with your image path
                                            fit: BoxFit.cover,
                                            height: 50,
                                          ),
                                        ),
                                      ), */
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mViewModel.sliderVideo.first.title ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: getAppStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                        // Replace with your style
                                      ),
                                      kCommonSpaceV10,
                                      Expanded(
                                        child: VideoPlayerScreen(
                                            link: mViewModel
                                                    .sliderVideo.first.link ??
                                                ''),
                                      ),
                                    ],
                                  );
                          },
                        ), */
                      ],
                    ),
                  ),
                  kCommonSpaceV10,
                  /* Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: buildIndicator(),
                    ),
                  ), */
                ],
                if (gUserType == AppConstants.CYCLE_EXPLORER) ...[
                  const VideoPlayerScreen(
                      link: "https://www.youtube.com/watch?v=VaVIvmQx_Xw"),
                  kCommonSpaceV20
                ],
                kCommonSpaceV10,
                SizedBox(
                    height: 180,
                    child: Stack(children: [
                      PageView.builder(
                        controller: mViewModel.pageController,
                        onPageChanged: (value) {
                          setState(() {
                            mViewModel.currentPage = value;
                          });
                        },
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 20),
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: CommonColors.bglightPinkColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      child: Stack(children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                /*Text(
                                                  'You may experience cramps today',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF8B8B8B),
                                                  ),
                                                ),
                                                kCommonSpaceV10,*/
                                                Text(
                                                  'Let\'s take a dive\ninto your day!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                kCommonSpaceV10,
                                                ElevatedButton(
                                                  onPressed: () {
                                                    push(
                                                        const SymptomsBotView());
                                                  },
                                                  style: ButtonStyle(
                                                    padding: WidgetStateProperty
                                                        .all<EdgeInsets>(
                                                            EdgeInsets.zero),
                                                    fixedSize:
                                                        WidgetStateProperty.all<
                                                            Size>(
                                                      Size(90.0,
                                                          25.0), // Button width and height
                                                    ),
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            Color.fromARGB(255,
                                                                242, 94, 180)),
                                                    foregroundColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            Colors.white),
                                                  ),
                                                  child: Text('Chat Now',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ),
                                              ]),
                                        ),

                                        /* Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  push(const ReminderView());
                                                },
                                                child:
                                              ),
                                            ), */

                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            /* onTap: () {
                                                  push(const ReminderView());
                                                }, */
                                            child: Image.asset(
                                              LocalImages.img_welcome_home,
                                              fit: BoxFit.contain,
                                              height: 150,
                                            ),
                                          ),
                                        ),
                                      ])),
                                )
                              : index == 1
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12, bottom: 20),
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          height: 160,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFDDEBFF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                          child: Stack(children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Have any questions, our experts\n are here to guide',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xFF8B8B8B),
                                                      ),
                                                    ),
                                                    kCommonSpaceV10,
                                                    Text(
                                                      'Ask A Doctor',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    kCommonSpaceV10,
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        push(
                                                            const SymptomsBotView());
                                                      },
                                                      style: ButtonStyle(
                                                        fixedSize:
                                                            WidgetStateProperty
                                                                .all<Size>(
                                                          Size(90.0,
                                                              25.0), // Button width and height
                                                        ),
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all<Color>(Color(
                                                                    0xFF3D73BF)),
                                                        foregroundColor:
                                                            WidgetStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                      ),
                                                      child: Text('Here',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                    ),
                                                  ]),
                                            ),

                                            /* Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  push(const ReminderView());
                                                },
                                                child:
                                              ),
                                            ), */

                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                /* onTap: () {
                                                  push(const ReminderView());
                                                }, */
                                                child: Image.asset(
                                                  LocalImages.img_naveli_nurse,
                                                  fit: BoxFit.contain,
                                                  height: 150,
                                                ),
                                              ),
                                            ),
                                          ])),
                                    )
                                  : index == 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12, bottom: 20),
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              height: 160,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: Color(0XFFFFEEEE),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                              child: Stack(children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Leading Ladies: Women making\nHeadlines',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        kCommonSpaceV10,
                                                        Text(
                                                          'The Neow Story',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        kCommonSpaceV10,
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            //TODO : Slider onTap required
                                                            push(PostList(
                                                              position: 0,
                                                              selectedTabIndex:
                                                                  0,
                                                              postTitle: "",
                                                            ));
                                                          },
                                                          style: ButtonStyle(
                                                            fixedSize:
                                                                WidgetStateProperty
                                                                    .all<Size>(
                                                              Size(90.0,
                                                                  25.0), // Button width and height
                                                            ),
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all<Color>(
                                                                        Color(
                                                                            0xFFD15151)),
                                                            foregroundColor:
                                                                WidgetStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .white),
                                                          ),
                                                          child: Text('Here',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                      ]),
                                                ),

                                                /* Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  push(const ReminderView());
                                                },
                                                child:
                                              ),
                                            ), */

                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: InkWell(
                                                    /* onTap: () {
                                                  push(const ReminderView());
                                                }, */
                                                    child: Image.asset(
                                                      LocalImages
                                                          .img_naveli_mike,
                                                      fit: BoxFit.contain,
                                                      height: 150,
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12, bottom: 20),
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              height: 160,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: Color(0XFFFFEEEE),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                              child: Stack(children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Leading Ladies: Women Making Headlines',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        kCommonSpaceV10,
                                                        Text(
                                                          'Groove with Neow',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        kCommonSpaceV10,
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            //TODO : Slider onTap required
                                                            push(PostList(
                                                              position: 0,
                                                              selectedTabIndex:
                                                                  0,
                                                              postTitle:
                                                                  "Slider",
                                                            ));
                                                          },
                                                          style: ButtonStyle(
                                                            fixedSize:
                                                                WidgetStateProperty
                                                                    .all<Size>(
                                                              Size(90.0,
                                                                  25.0), // Button width and height
                                                            ),
                                                            backgroundColor:
                                                                WidgetStateProperty.all<
                                                                        Color>(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        175,
                                                                        34,
                                                                        34)),
                                                            foregroundColor:
                                                                WidgetStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .white),
                                                          ),
                                                          child: Text('Here',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12)),
                                                        ),
                                                      ]),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: InkWell(
                                                    child: Image.asset(
                                                      LocalImages.grovewithnew,
                                                      fit: BoxFit.contain,
                                                      height: 150,
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: buildIndicator(),
                        ),
                      ),
                    ])),
                kCommonSpaceV30,
                Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Track and Learn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            push(const TrackHealthViewAllView());
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      /* Align(
                        alignment:Alignment.topRight,
                        child:Text(
                          "View All",
                          style: TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize:14,
                            color:CommonColors.primaryColor,
                          ),
                        ),
                      ), */
                    ])),
                kCommonSpaceV20,
                SizedBox(
                  height: 160,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      // scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      children: <Widget>[
                        if (gUserType == AppConstants.NEOWME)
                          CommonDailyInsightContainer(
                            onTap: () {
                              push(const LogYourSymptoms()).then((value) =>
                                  mViewSymptomsModel?.getUserSymptomsLogApi(
                                      date: globalUserMaster
                                              ?.previousPeriodsBegin ??
                                          ''));
                              // if (getLogSymtopmActive() == true) {
                              //   push(const LogYourSymptoms()).then((value) =>
                              //       mViewSymptomsModel?.getUserSymptomsLogApi(
                              //           date: globalUserMaster
                              //                   ?.previousPeriodsBegin ??
                              //               ''));
                              // } else {
                              //   CommonUtils.showSnackBar(
                              //     'You can log your symtomps only in peroid days.',
                              //     color: CommonColors.greenColor,
                              //   );
                              // }
                            },
                            text: S.of(context)!.logYourSymptoms,
                            image: LocalImages.img_log_symptoms,
                            gradientColors: const [
                              Color(0xFFFFFFFF),
                              Color(0xFFFFFFFF),
                            ],
                            borderColor: CommonColors.bglightPinkColor,
                          ),
                        kCommonSpaceH10,
                        CommonDailyInsightContainer(
                          onTap: () {
                            push(const TrackView());
                          },
                          text: S.of(context)!.track,
                          image: LocalImages.img_track,
                          gradientColors: const [
                            Color(0xFF9E72C3),
                            Color(0xFF7338A0),
                          ],
                          borderColor: CommonColors.bglightPinkColor,
                        ),
                        kCommonSpaceH10,
                        CommonDailyInsightContainer(
                          onTap: () {
                            // push(const KnowYourBodyView());
                            push(const AllAboutPeriodsView());
                          },
                          text: 'Articles',
                          image: LocalImages.img_know_your_body,
                          gradientColors: const [
                            Color(0xFF9E72C3),
                            Color(0xFF7338A0),
                          ],
                          borderColor: CommonColors.bglightPinkColor,
                        ),
                        kCommonSpaceH10,
                        if (gUserType == AppConstants.NEOWME ||
                            gUserType == AppConstants.CYCLE_EXPLORER)
                          CommonDailyInsightContainer(
                            onTap: () {
                              // showPopusDialog();
                              // showSymptomsDialog(context);
                              push(const QuizView());
                            },
                            text: S.of(context)!.quickQuestion,
                            image: LocalImages.img_quick_question,
                            gradientColors: const [
                              Color(0xFF9E72C3),
                              Color(0xFF7338A0),
                            ],
                            borderColor: CommonColors.bglightPinkColor,
                          ),
                        kCommonSpaceH10,
                        CommonDailyInsightContainer(
                          onTap: () {
                            // showPopusDialog();
                            push(const DeStressView());
                          },
                          text: S.of(context)!.deStress,
                          image: LocalImages.img_de_stress,
                          gradientColors: const [
                            Color(0xFF9E72C3),
                            Color(0xFF7338A0),
                          ],
                          borderColor: CommonColors.bglightPinkColor,
                        ),
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV20,
                // kCommonSpaceV30,
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              push(HealthMixCategoryAll());
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF6F4085)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                kCommonSpaceV10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final firstCard =
                          mViewModel.healthMixCategoryList[index * 2];
                      final secondCard = index * 2 + 1 <
                              mViewModel.healthMixCategoryList.length
                          ? mViewModel.healthMixCategoryList[index * 2 + 1]
                          : null;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HealthmixCategoryCard(
                              title: firstCard.name ?? "",
                              imagePath: firstCard.iconUrl ?? "",
                              backgroundColor: CommonColors.mWhite,
                              onTap: () => push(PostList(
                                position: 0,
                                selectedTabIndex: firstCard.id ?? 0,
                                postTitle: firstCard.name ?? "",
                              )),
                            ),
                            if (secondCard != null)
                              HealthmixCategoryCard(
                                title: secondCard.name ?? "",
                                imagePath: secondCard.iconUrl ?? "",
                                backgroundColor: CommonColors.mWhite,
                                onTap: () => push(PostList(
                                  position: 0,
                                  selectedTabIndex: secondCard.id ?? 0,
                                  postTitle: secondCard.name ?? "",
                                )),
                              )
                            else
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                kCommonSpaceV15,
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest Videos",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      // ShortsView
                      GestureDetector(
                        onTap: () {
                          // Define the action when the text is clicked
                          push(ShortsView(
                              healthPostsList:
                                  mViewHealthMixModel.healthPostsList));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CommonColors
                                .bglightPinkColor, // Replace with your custom color
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3F000000), // Shadow color
                                blurRadius: 5, // Blur radius
                                offset: Offset(0, 2), // Shadow offset
                                spreadRadius: 0, // Spread radius
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/ic_short.png',
                                ),
                                const SizedBox(
                                    width: 8), // Space between image and text
                                Text(
                                  "Shorts",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: CommonColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                kCommonSpaceV10,
                ListView.builder(
                  itemCount: mViewHealthMixModel.healthPostsList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final post = mViewHealthMixModel.healthPostsList[index];
                    return LatestVideoCard(
                      imageUrl: post.media!.contains("youtube")
                          ? "https://cdn.pixabay.com/photo/2020/11/22/04/10/youtube-5765608_640.png"
                          : post.media ??
                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                      title: post.description ?? "Unknown Description",
                      category: post.id.toString(),
                      timeDifference: post.diffrenceTime,
                      onTap: () {
                          push(HealthmixDetailView(
                                    post: post,
                                  ));
                      },
                    );
                  },
                ),
                kCommonSpaceV20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: mViewModel.currentPage == index
                ? CommonColors.primaryColor
                : CommonColors.mGrey,
          ),
        ),
      ),
    );
  }

  Future<void> showSymptomsScoreDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.76, 0.65),
                  end: Alignment(-0.76, -0.65),
                  colors: [Color(0xFFA43886), Color(0xFF6A41A5)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      'As a later pop up, if the user scores more than 100',
                      style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kCommonSpaceV10,
                    Text(
                      'You might have heavy Menstrual Bleeding. Get Yourself Examine For',
                      textAlign: TextAlign.center,
                      style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    kCommonSpaceV10,
                    Text(
                      'FIBROIDS CYST ENDOMETRIAL POLYP CANCER',
                      style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: CommonColors.mWhite,
                          side: const BorderSide(
                            width: 1.0,
                            color: CommonColors.blackColor,
                          ),
                        ),
                        child: Text(
                          'OK',
                          style: getAppStyle(color: CommonColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  loadVideoPlayer(String vpath) {
    vdo_Controller = VideoPlayerController.asset(vpath);
    vdo_Controller.addListener(() {
      setState(() {});
    });
    vdo_Controller.initialize().then((value) {
      vdo_Controller.play();
      vdo_Controller.setLooping(true);
      setState(() {});
    });
  }
}

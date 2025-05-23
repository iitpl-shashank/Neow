import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

// import 'package:widgets_easier/widgets_easier.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:naveli_2023/ui/naveli_ui/ai_chatbot/views/ai_chatbot_screen.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/healthmix_detail_view.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/healthmix_latest_detail_view.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/video_particular.dart';
import 'package:naveli_2023/ui/naveli_ui/home/inapp_notificatons/custom_notification.dart';
import 'package:naveli_2023/ui/naveli_ui/home/quiz/quiz_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/shorts/short_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/track_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track_helath_view_all/track_health_view_all_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/user_notifications/notification_screen.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import '../../app/app_model.dart';
import '../calendar/calendar_view.dart';
import '../health_mix/health_mix_view_model.dart';
import '../health_mix/post_list.dart';

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
  String dateString = globalUserMaster?.previousPeriodsBegin ?? '';

  //String daysToGo = "";

  String? acceptedUniqueId;

  var bgColor = 0XFFFBF5F7;

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String username = globalUserMaster?.name.toString().split(' ')[0] ?? '';
      // TODO  Removed as per client feedback
      // mViewModel.getHindiTranslation(string: username);

      _startAutoSlide();
      // TODO : Here is the InAPP Notification

      vdo_Controller =
          VideoPlayerController.asset('assets/video/home_screen.mp4')
            ..initialize().then((_) {
              vdo_Controller
                  .setLooping(true); // Set looping for continuous playback
              vdo_Controller.play();
              // Ensure the first frame is shown after the video is initialized
              setState(() {});
            });

      mViewModel.attachedContext(context);
      mViewModel.fetchHealthMixCategoryList();

      // Loading Issue
      // mViewModel.getDialogBox(context);

      mViewYourNaveliModel =
          Provider.of<YourNaveliViewModel>(context, listen: false);
      mViewHealthMixModel =
          Provider.of<HealthMixViewModel>(context, listen: false);
      mViewSymptomsModel =
          Provider.of<LogYourSymptomsModel>(context, listen: false);

      mViewModel.attachedContext(context);
      mViewHealthMixModel.getHealthMixLatestPosts();

      if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
        await mViewModel.getPeriodInfoList();
        if (gUserType == AppConstants.NEOWME)
          showCustomDayDialog(
            context,
            username,
            null,
          );
      }

      //TODO  First and Second block to be in hindi or not !!!!
      await handleFirstBloc();
      await mViewModel.handleSecondBloc(dateString);
      print("diipppka1");
      // mViewModel.fetchData();

      mViewModel.updateSelectedDate(DateTime.now());
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mViewModel.currentPage < 1) {
        mViewModel.currentPage++;
      } else {
        mViewModel.currentPage = 0; // Reset to the first page
      }
      mViewModel.pageController.animateToPage(
        mViewModel.currentPage,
        duration: Duration(milliseconds: 1000),
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
  }

// Function to call API after coming back from the CalendarView
  void callApiAfterBack() async {
    //mViewModel.fetchData();
    mViewModel.getPeriodInfoList();
    /*if (peroidCustomeList.length > 0) {
      await handleSecondBloc(peroidCustomeList[0].predicated_period_start_date);
    }*/
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

  void showCustomDayDialog(
    BuildContext context,
    String username,
    int? day,
  ) async {
    developer.log("INSIDE: Dialog");
    if (day == null) day = 100;
    if (mViewModel.parsedDate != null) {
      DateTime today = DateTime.now();
      int daysLeft = mViewModel.parsedDate!
          .difference(DateTime(today.year, today.month, today.day))
          .inDays;
      developer.log("INSIDE: ${daysLeft}");
      if (daysLeft == 2) {
        day = 1;
      } else if (daysLeft == 1) {
        day = 2;
      } else if (daysLeft == 0) {
        day = 3;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final key = 'custom_dialog_shown_day_$day';
    final lastShown = prefs.getString(key);

    final todayStr = "${today.year}-${today.month}-${today.day}";

    if (lastShown == todayStr) {
      return;
    }
    await prefs.setString(key, todayStr);

    if (day == 1) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
          imagePath: LocalImages.heartFace,
          imageText: S.of(context)!.jiyaDhadakDhadak,
          subtitleText: S.of(context)!.periodExpectedToStartIn2Days,
        ),
      );
    } else if (day == 2) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
          imagePath: LocalImages.oldWomanEng,
          height: 300,
          width: 300,
          subtitleText: S.of(context)!.periodExpectedToStartTomorrow,
          isLeftShift: true,
          prepareText: S.of(context)!.bePrepared,
        ),
      );
    } else if (day == 3) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
            imagePath: LocalImages.alertPad,
            imageText: "${S.of(context)!.heyNeoW} ${username}",
            height: 120,
            width: 120,
            subtitleText: S.of(context)!.expectPeriodToday,
            prepareText: S.of(context)!.getReady,
            purpleLabel: S.of(context)!.logPeriod,
            purpleOnPress: () {
              Navigator.of(context).pop();
              navigateToCalendarView();
            }),
      );
    } else if (day == 4) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
          imagePath: LocalImages.womanUnderground,
          height: 250,
          width: 280,
          isLeftShift: true,
          subtitleText: S.of(context)!.hasPeriodStarted,
          purpleLabel: S.of(context)!.yesLogSymptoms,
          purpleOnPress: () {
            Navigator.of(context).pop();
            push(
              const LogYourSymptoms(),
            );
          },
          whiteLabel: S.of(context)!.no,
          whiteOnPress: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => CustomNotification(
                imagePath: LocalImages.cryingWoman,
                height: 250,
                width: 270,
                imageText: S.of(context)!.derNaHoJaye,
                subtitleText: S.of(context)!.dontWorryWaitFewHours,
              ),
            );
          },
        ),
      );
    } else if (day == 5) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
          imagePath: LocalImages.cryingWoman2,
          isLeftShift: true,
          height: 250,
          width: 250,
          subtitleText: S.of(context)!.periodSeemsDelayed,
        ),
      );
    }
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    mViewModel = Provider.of<HomeViewModel>(context, listen: false);
    mViewModel.isDateWiseTextLoader = true;
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          mViewModel.isDateWiseTextLoader = false;
        });
      }
    });
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

    final List<Widget> insightWidgets = [
      if (gUserType == AppConstants.NEOWME)
        CommonDailyInsightContainer(
          onTap: () {
            if (mViewModel.dateWiseTextList.msg.periodMsg!
                    .contains("Period Day") ||
                mViewModel.dateWiseTextList.msg.periodMsg!
                    .contains("पीरियड दिन")) {
              push(const LogYourSymptoms());
            } else {
              CommonUtils.showToastMessage(
                S.of(context)!.logOnlyOnPeriodDay,
              );
            }
          },
          text: S.of(context)!.logYourSymptoms,
          image: LocalImages.img_log_symptoms,
          gradientColors: const [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF),
          ],
          borderColor: CommonColors.purple,
        ),
      if (false) kCommonSpaceH10,
      if (false) //TODO : Hidden for now
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
          borderColor: CommonColors.purple,
        ),
      kCommonSpaceH10,
      CommonDailyInsightContainer(
        onTap: () {
          push(const AllAboutPeriodsView());
        },
        text: S.of(context)!.articles,
        image: LocalImages.img_know_your_body,
        gradientColors: const [
          Color(0xFF9E72C3),
          Color(0xFF7338A0),
        ],
        borderColor: CommonColors.purple,
      ),
      kCommonSpaceH10,
      if (false) //TODO : Hidden for now
        CommonDailyInsightContainer(
          onTap: () {
            push(const QuizView());
          },
          text: S.of(context)!.quickQuestion,
          image: LocalImages.img_quick_question,
          gradientColors: const [
            Color(0xFF9E72C3),
            Color(0xFF7338A0),
          ],
          borderColor: CommonColors.purple,
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
        borderColor: CommonColors.purple,
      ),
    ];

    var calender2 = HorizontalCalendar(
      mViewModel: mViewModel,
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Scaffold(
            appBar: AppBar(
              // backgroundColor:Colors.red,
              title: Text(
                  // "${S.of(context)!.hi}, NeoW ${lang == 'hi' ? (mViewModel.hindiTransliterations.isNotEmpty ? mViewModel.hindiTransliterations[0] : '') : globalUserMaster?.name.toString().split(' ')[0] ?? ''} !",
                  "${S.of(context)!.hi}, NeoW ${globalUserMaster?.name.toString().split(' ')[0] ?? ''} !",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight:
                        lang == "hi" ? FontWeight.w500 : FontWeight.bold,
                    fontSize: 18,
                  )),

              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    push(NotificationScreen());
                  },
                ),
                if (gUserType == AppConstants.NEOWME)
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      isLogEdit = false;
                      push(CalendarView());
                    },
                  ),
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
                    calender2,
                  ],
                  Container(
                    height: 10,
                    color: Color(0xFFFBF5F7),
                  ),
                  if (gUserType == AppConstants.NEOWME ||
                      gUserType == AppConstants.BUDDY) ...[
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: CommonColors.appBackground,
                            // width:500,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 90.0)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Consumer<HomeViewModel>(
                            builder: (context, vModel, child) {
                              final imageUrl =
                                  vModel.dateWiseTextList.msg.image;
                              if (vModel.dateWiseTextList.msg.periodMsg !=
                                      null &&
                                  (vModel.dateWiseTextList.msg.periodMsg! ==
                                          "Period late by 1" ||
                                      vModel.dateWiseTextList.msg.periodMsg! ==
                                          "पीरियड 1 दिन लेट।")) {
                                showCustomDayDialog(context, "", 5);
                              }

                              print(
                                  "Image not shwoing issue: ${vModel.dateWiseTextList.msg.image}");
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CommonColors.appBackground,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.elliptical(
                                          MediaQuery.of(context).size.width,
                                          90.0)),
                                ),
                                child: (vModel.isDateWiseTextLoading ||
                                        vModel.isDateWiseTextLoader)
                                    ? Container(
                                        child: Image.asset(
                                          LocalImages.syncing_vibe,
                                          height: 200,
                                          width: 180,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (imageUrl != null)
                                            Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    imageUrl,
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  vModel.dateWiseTextList.msg
                                                      .periodMsg!,
                                                  style: TextStyle(
                                                      color: vModel
                                                              .dateWiseTextList
                                                              .msg
                                                              .color!
                                                              .contains("black")
                                                          ? Colors.black
                                                          : Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          if (imageUrl == null)
                                            SizedBox(
                                              height: 30,
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      vModel.dateWiseTextList
                                                          .msg.description,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: CommonColors
                                                              .darkPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          kCommonSpaceV5,
                                          ElevatedButton(
                                            onPressed: () {
                                              navigateToCalendarView();
                                            },
                                            style: ButtonStyle(
                                              fixedSize:
                                                  WidgetStateProperty.all<Size>(
                                                Size(lang == 'hi' ? 170 : 120.0,
                                                    30.0), // Button width and height
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty
                                                      .all<Color>(CommonColors
                                                          .primaryColor),
                                              foregroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(Colors.white),
                                            ),
                                            child: Text(
                                              S.of(context)!.logPeriod,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    kCommonSpaceV10,
                  ],
                  if (gUserType == AppConstants.CYCLE_EXPLORER) ...[
                    SizedBox(
                      height: 250,
                      child: const VideoPlayerScreen(
                          link: "https://www.youtube.com/watch?v=VaVIvmQx_Xw"),
                    ),
                    kCommonSpaceV20,
                  ],
                  kCommonSpaceV10,
                  SizedBox(
                    height: 170,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: mViewModel.pageController,
                          onPageChanged: (value) {
                            setState(() {
                              mViewModel.currentPage = value;
                            });
                          },
                          itemCount: 2,
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
                                                  Text(
                                                    S.of(context)!.letsTakeDive,
                                                    style: TextStyle(
                                                      fontWeight: lang == "hi"
                                                          ? FontWeight.w500
                                                          : FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  kCommonSpaceV10,
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // TODO : Change here from old chatbot to new ai chatbot
                                                      // push(
                                                      //     const SymptomsBotView());
                                                      push(
                                                        AiChatBotScreen(),
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                      padding:
                                                          WidgetStateProperty
                                                              .all<EdgeInsets>(
                                                                  EdgeInsets
                                                                      .zero),
                                                      fixedSize:
                                                          WidgetStateProperty
                                                              .all<Size>(
                                                        Size(90.0,
                                                            25.0), // Button width and height
                                                      ),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      242,
                                                                      94,
                                                                      180)),
                                                      foregroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                      S.of(context)!.chatNow,
                                                      style: TextStyle(
                                                        fontWeight: lang == "hi"
                                                            ? FontWeight.w500
                                                            : FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context)!.theNeowStory,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  kCommonSpaceV10,
                                                  Text(
                                                    S
                                                        .of(context)!
                                                        .leadingLadies1,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  kCommonSpaceV10,
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      //TODO : Slider onTap required
                                                      push(PostList(
                                                        position: 0,
                                                        selectedTabIndex: 0,
                                                        postTitle: "",
                                                      ));
                                                    },
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          WidgetStateProperty
                                                              .all<Size>(
                                                        Size(120.0,
                                                            25.0), // Button width and height
                                                      ),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(Color(
                                                                  0xFFD15151)),
                                                      foregroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                    ),
                                                    child: Text(
                                                        S.of(context)!.tapHere,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                lang == "hi"
                                                                    ? FontWeight
                                                                        .w500
                                                                    : FontWeight
                                                                        .bold,
                                                            fontSize: 12)),
                                                  ),
                                                ]),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              /* onTap: () {
                                                      push(const ReminderView());
                                                    }, */
                                              child: Image.asset(
                                                LocalImages.img_naveli_mike,
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
                      ],
                    ),
                  ),
                  if (gUserType == AppConstants.NEOWME ||
                      gUserType == AppConstants.BUDDY)
                    kCommonSpaceV30,
                  if (gUserType == AppConstants.NEOWME ||
                      gUserType == AppConstants.BUDDY)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S.of(context)!.trackAndLearn,
                              style: TextStyle(
                                fontWeight: lang == "hi"
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                fontSize: 18,
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
                                S.of(context)!.viewAll,
                                style: TextStyle(
                                  fontWeight: lang == "hi"
                                      ? FontWeight.w500
                                      : FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6F4085),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  kCommonSpaceV20,
                  if (gUserType == AppConstants.NEOWME ||
                      gUserType == AppConstants.BUDDY)
                    SizedBox(
                      height: 160,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: insightWidgets,
                        ),
                      ),
                    )
                  else if (gUserType == AppConstants.CYCLE_EXPLORER)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.5,
                        children: insightWidgets
                            .where((w) => w is CommonDailyInsightContainer)
                            .toList(),
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
                              S.of(context)!.explore,
                              style: TextStyle(
                                fontWeight: lang == "hi"
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                push(HealthMixCategoryAll());
                              },
                              child: Text(
                                S.of(context)!.viewAll,
                                style: TextStyle(
                                  fontWeight: lang == "hi"
                                      ? FontWeight.w500
                                      : FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF6F4085),
                                ),
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
                      itemBuilder: (context, rowIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (rowIndex * 2 <
                                  mViewModel.healthMixCategoryList.length)
                                HealthmixCategoryCard(
                                  title: mViewModel
                                          .healthMixCategoryList[rowIndex * 2]
                                          .name ??
                                      "",
                                  imagePath: mViewModel
                                          .healthMixCategoryList[rowIndex * 2]
                                          .iconUrl ??
                                      "",
                                  backgroundColor: CommonColors.mWhite,
                                  onTap: () => push(PostList(
                                    position: 0,
                                    selectedTabIndex: mViewModel
                                            .healthMixCategoryList[rowIndex * 2]
                                            .id ??
                                        0,
                                    postTitle: mViewModel
                                            .healthMixCategoryList[rowIndex * 2]
                                            .name ??
                                        "",
                                  )),
                                ),
                              if (rowIndex * 2 + 1 <
                                  mViewModel.healthMixCategoryList.length)
                                HealthmixCategoryCard(
                                  title: mViewModel
                                          .healthMixCategoryList[
                                              rowIndex * 2 + 1]
                                          .name ??
                                      "",
                                  imagePath: mViewModel
                                          .healthMixCategoryList[
                                              rowIndex * 2 + 1]
                                          .iconUrl ??
                                      "",
                                  backgroundColor: CommonColors.mWhite,
                                  onTap: () => push(PostList(
                                    position: 0,
                                    selectedTabIndex: mViewModel
                                            .healthMixCategoryList[
                                                rowIndex * 2 + 1]
                                            .id ??
                                        0,
                                    postTitle: mViewModel
                                            .healthMixCategoryList[
                                                rowIndex * 2 + 1]
                                            .name ??
                                        "",
                                  )),
                                )
                              else
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                ),
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
                          S.of(context)!.latestVideos,
                          style: TextStyle(
                            fontWeight: lang == "hi"
                                ? FontWeight.w500
                                : FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        // ShortsView
                        GestureDetector(
                          onTap: () {
                            // Define the action when the text is clicked
                            push(
                              ShortsView(),
                            );
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
                                    S.of(context)!.shorts,
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
                    itemCount: min(
                      5,
                      mViewHealthMixModel.healthLatestPostsList.length,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final post =
                          mViewHealthMixModel.healthLatestPostsList[index];
                      return LatestVideoCard(
                        imageUrl: post.media!.contains("youtube")
                            ? "https://i.cdn.newsbytesapp.com/images/l51320241229130933.jpeg"
                            : post.media ??
                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                        title: post.description ?? "Unknown Description",
                        category: post.category?.title ?? "Category",
                        timeDifference: post.diffrenceTime,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthmixLatestDetailView(
                                key: ValueKey(
                                    post.id), // Use a unique key for each post
                                post: post,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  kCommonSpaceV20,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
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

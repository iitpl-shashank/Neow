import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// import 'dart:developer';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/hindi_translation.dart';
import '../../../database/app_preferences.dart';
import '../../../models/healthmix_category_model.dart';
import '../../../models/period_phase_model.dart';
import '../../../models/slider_video_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';

class HomeViewModel with ChangeNotifier {
  DateTime? parsedDate;
  late BuildContext context;
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  final _services = Services();
  Timer? timerSlider;
  Timer? timerSymptoms;
  List<SliderVideoData> sliderVideo = [];
  List<String> dateParts = [];
  int year = 0;
  int month = 0;
  int day = 0;
  List<DateTime> nextCycleDates = [];
  List<DateTime> ovulationDates = [];
  List<DateTime> firtileDates = [];
  List<DateTime> daysList = [];
  DateTime selectedDate = DateTime.now();
  List<Record> healthMixCategoryList = [];

  List<String> hindiTransliterations = [];
  List<String> englishTransliterations = [];

  Future<void> getHindiTranslation({required String string}) async {
    CommonUtils.showProgressDialog();
    TransliterationResponse? _response =
        await HindiTranslation.transliterate(string, Languages.HINDI);
    hindiTransliterations = _response!.transliterationSuggestions;
    notifyListeners();
    CommonUtils.hideProgressDialog();
    log("Hindi Translation : ${hindiTransliterations}");
  }

  Future<void> getEnglishTranslation({required String string}) async {
    TransliterationResponse? _response =
        await HindiTranslation.transliterate(string, Languages.ENGLISH);
    englishTransliterations = _response!.transliterationSuggestions;
    notifyListeners();
    log("English Translation : ${englishTransliterations}");
  }

  List<Color> gradientColorsList() => [
        Colors.red,
        Colors.red.withOpacity(0.9),
        Colors.red.withOpacity(0.8),
        Colors.red.withOpacity(0.7),
        Colors.red.withOpacity(0.5),
      ];

  List<Color> gradientColorsListPink() => [
        Colors.pink,
        Colors.pink.withOpacity(0.9),
        Colors.pink.withOpacity(0.8),
        Colors.pink.withOpacity(0.7),
        Colors.pink.withOpacity(0.5),
      ];

  List<Color> gradientColorsListGreen() => [
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.6),
        Colors.green.withOpacity(0.5),
        Colors.green.withOpacity(0.4),
      ];

  LinearGradient getGradient() {
    List<Color> gradientColors = gradientColorsList();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  LinearGradient getGradientPink() {
    List<Color> gradientColors = gradientColorsListPink();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  LinearGradient getGradientGreen() {
    List<Color> gradientColors = gradientColorsListGreen();
    return LinearGradient(
      colors: gradientColors,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: List.generate(gradientColors.length,
          (index) => index / (gradientColors.length - 1)),
    );
  }

  DateTime currentDateTime = DateTime.now();

  void attachedContext(BuildContext context) {
    this.context = context;
    daysList.clear();
    selectedDate = DateTime.now();
    // generateDaysList();
  }

  Future<void> getDialogBox(BuildContext context) async {
    isLoading = true; // Start loading
    notifyListeners();

    try {
      debugPrint("Fetching dialog box data...");
      Map<String, dynamic> master = await _services.api!.getDialogBoxData();
      debugPrint("Dialog box data fetched: $master");
      showDysmenorrheaDialog(context, master);
    } catch (e) {
      debugPrint("Error in getDialogBox: $e");
    } finally {
      isLoading = false; // Stop loading
      notifyListeners();
      debugPrint("getDialogBox completed, isLoading: $isLoading");
    }
  }

  void showDysmenorrheaDialog(BuildContext context, Map<String, dynamic> data) {
    debugPrint("showDysmenorrheaDialog called");
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  // Future<void> getDialogBox(BuildContext context) async {
  //   Map<String, dynamic> master = await _services.api!.getDialogBoxData();
  //   showDysmenorrheaDialog(context, master);
  //   // generateDaysList();
  // }
  // void showDysmenorrheaDialog(BuildContext context,Map<String,dynamic> data) {
  //   debugPrint("showDysmenorrheaDialog");
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //         child: Container(
  //           width: 340, // Custom dimensions, responsive if needed
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               /// Header row
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     "Dysmenorrhea",
  //                     style: TextStyle(
  //                       color: Colors.red,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   GestureDetector(
  //                     onTap: () => Navigator.pop(context),
  //                     child: const Icon(Icons.close),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 4),
  //               const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "(severe pain)",
  //                   style: TextStyle(fontSize: 14, color: Colors.black87),
  //                 ),
  //               ),

  //               const SizedBox(height: 16),

  //               /// Image and speech bubble
  //               Stack(
  //                 alignment: Alignment.topRight,
  //                 children: [
  //                   Image.asset(
  //                     'assets/images/ic_server_img.png',
  //                     height: 160,
  //                   ),
  //                 ],
  //               ),

  //               const SizedBox(height: 20),

  //               /// Description
  //               const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Possible cause may be:",
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //               ),

  //               const SizedBox(height: 8),

  //               /// Bulleted list
  //               const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text("• Fibroids"),
  //                     Text("• Endometriosis"),
  //                     Text("• Pelvic Infections"),
  //                     Text("• Cyst"),
  //                   ],
  //                 ),
  //               ),

  //               const SizedBox(height: 20),

  //               /// CTA
  //               const Text(
  //                 "Get examined today!",
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16,
  //                   color: Colors.black87,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  List<DateTime> calculateCycleDatesInYear(
      DateTime previousDate, int cycleLength) {
    List<DateTime> nextCycleDates = [];

    // print('PrevousDate : $previousDate CycleLength: $cycleLength');
    //
    // DateTime nextDate = previousDate;
    //
    // DateTime now = DateTime.now();
    // DateTime twelveMonthsLater = now.add(const Duration(days: 365));
    // List<DateTime> ovulationDates = [];
    //
    // print("ppppppp ${globalUserMaster!.averagePeriodLength ?? '5'}");
    // DateTime startDate = DateTime.parse(
    //     peroidCustomeList[peroidCustomeList.length - 1].period_start_date);
    // DateTime endDate = DateTime.parse(
    //     peroidCustomeList[peroidCustomeList.length - 1].period_end_date);
    // int periodLength = startDate.difference(endDate).inDays.abs();
    // print(
    //     "ppppppp ${peroidCustomeList[peroidCustomeList.length - 1].period_length}");
    //
    // while (nextDate.isBefore(twelveMonthsLater)) {
    //   // Add all days of the period to the list
    //   for (int i = 0;
    //       i <
    //           int.parse(peroidCustomeList[peroidCustomeList.length - 1]
    //               .period_length) /*globalUserMaster!.averagePeriodLength ?? '5')*/;
    //       i++) {
    //     if (i == 0) {
    //       ovulationDates.add(nextDate.add(Duration(days: 14)));
    //     }
    //     nextCycleDates.add(nextDate.add(Duration(days: i)));
    //     gCycleDates.add(CycleDates(
    //         nextDate.add(Duration(days: i)), true, false, false, (i + 1)));
    //   }
    //   // Move to the next cycle start date
    //   nextDate = nextDate.add(Duration(days: cycleLength));
    // }

    return nextCycleDates;
  }

  List<DateTime> calculateOvolutionDatesInYear(
      DateTime previousDate, int cycleLength) {
    List<DateTime> nextCycleDates = [];
    // DateTime nextDate = previousDate;
    //
    // DateTime now = DateTime.now();
    // DateTime twelveMonthsLater = now.add(const Duration(days: 365));
    // List<DateTime> ovulationDates = [];
    //
    // while (nextDate.isBefore(twelveMonthsLater)) {
    //   // Add all days of the period to the list
    //   for (int i = 0;
    //       i <
    //           int.parse(peroidCustomeList[peroidCustomeList.length - 1]
    //               .period_length) /*int.parse(globalUserMaster!.averagePeriodLength ?? '5')*/;
    //       i++) {
    //     if (i == 0) {
    //       int ovdays = 6 + (cycleLength - 21);
    //       ovulationDates.add(nextDate.add(Duration(days: ovdays)));
    //     }
    //     nextCycleDates.add(nextDate.add(Duration(days: i)));
    //   }
    //
    //   // Move to the next cycle start date
    //   nextDate = nextDate.add(Duration(days: cycleLength));
    // }

    // log("OvulationDates===> $ovulationDates", name: "OvulationDates");
    return ovulationDates;
  }

  List<DateTime> calculateFertileDatesInYear({
    required DateTime previousPeriodStartDate,
    required int cycleLength,
    required int periodLength,
  }) {
    List<DateTime> fertileDates = [];

    // Predict next cycle start date
    DateTime nextCycleStartDate =
        previousPeriodStartDate.add(Duration(days: cycleLength));

    // Calculate ovulation date (14 days before next cycle start)
    DateTime ovulationDate = nextCycleStartDate.subtract(Duration(days: 14));

    // Add fertile window (5 days before + ovulation day + 2 days after)
    for (int j = 5; j > 0; j--) {
      fertileDates.add(ovulationDate.subtract(Duration(days: j)));
    }
    fertileDates.add(ovulationDate);
    for (int j = 1; j <= 2; j++) {
      fertileDates.add(ovulationDate.add(Duration(days: j)));
    }

    // log("Fertile dates ===> $fertileDates", name: "FertileDates");
    return fertileDates;
  }

  Future<void> getSliderVideoApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    SliderVideoMaster? master =
        await _services.api!.getHomeSliderVideo(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      sliderVideo = master.data ?? [];
    }
    notifyListeners();
  }

  Future<void> updateCycleDates({
    required DateTime startDate,
    required int cycleLength,
  }) async {
    // Clear the existing cycle data to avoid conflicts.
    gCycleDates.clear();

    // Recalculate the new cycle, ovulation, and fertile dates
    List<DateTime> newCycleDates =
        calculateCycleDatesInYear(startDate, cycleLength);
    List<DateTime> newOvulationDates =
        calculateOvolutionDatesInYear(startDate, cycleLength);
    List<DateTime> newFertileDates = calculateFertileDatesInYear(
        previousPeriodStartDate: startDate,
        cycleLength: cycleLength,
        periodLength: int.parse(globalUserMaster?.averagePeriodLength ?? "5"));

    // Optionally, you can print out the recalculated dates or store them in the model
    print("New Cycle Dates: $newCycleDates");
    print("New Ovulation Dates: $newOvulationDates");
    print("New Fertile Dates: $newFertileDates");

    // Update your model or state with the new data
    nextCycleDates = newCycleDates;
    ovulationDates = newOvulationDates;
    firtileDates = newFertileDates;

    // You can add additional logic here as needed
  }

  void generateDaysList() {
    DateTime currentDate = DateTime.now();
    selectedDate = currentDate;
    for (int i = 0; i < 90; i++) {
      daysList.add(currentDate.add(Duration(days: i)));
    }
    notifyListeners();
  }

  String calculateDaysToGo(DateTime currentDate) {
    nextCycleDates.sort();
    nextCycleDates = nextCycleDates.toSet().toList();
    DateTime nextCycleStartDate = nextCycleDates.firstWhere(
        (date) => date.isAfter(currentDate),
        orElse: () => nextCycleDates.last);

    int daysRemaining = nextCycleStartDate.difference(currentDate).inDays + 1;

    return "$daysRemaining days";
  }

  bool getPredictedDaySelected(DateTime currentDate) {
    // for (int i = 0; i < peroidCustomeList.length; i++) {
    //   DateTime startPredicatedPeriods =
    //       DateTime.parse(peroidCustomeList[i].predicated_period_start_date);
    //   DateTime endPredicatedPeriods =
    //       DateTime.parse(peroidCustomeList[i].predicated_period_end_date);
    //
    //   if ((currentDate.isAfter(startPredicatedPeriods) &&
    //           currentDate.isBefore(endPredicatedPeriods)) ||
    //       currentDate.isAtSameMomentAs(startPredicatedPeriods) ||
    //       currentDate.isAtSameMomentAs(endPredicatedPeriods)) {
    //     return true;
    //   }
    // }
    return false;
  }

  DateTime parseDDMMYYYY(DateTime dateStr) {
    int day = dateStr.day;
    int month = dateStr.month;
    int year = dateStr.year;
    return DateTime(year, month, day);
  }

  String getCycleDayOrDaysToGo(DateTime date) {
    if (peroidCustomeList.isEmpty) {
      return "No cycle dates available";
    }
    String value = "";
    DateTime now = DateTime.now();
    int currentYear = now.year;

    List<DateTime> fertileDates = [];
    List<DateTime> ovulationDates = [];
    List<DateTime> loggedPeriodDates = [];
    Set<DateTime> predictedPeriodDates = {};

    // DateTime now = DateTime.now();
    // int currentYear = now.year;

    // DateTime now = DateTime.now();
    // int currentYear = now.year;

    // for (var dateRange in peroidCustomeList) {
    //   DateTime start = DateTime.parse(dateRange.period_start_date);
    //   DateTime end = DateTime.parse(dateRange.period_end_date);
    //   int cycleLength = int.parse(dateRange.period_cycle_length);
    //
    //   DateTime? startDate = dateRange.fertile_window_start != null
    //       ? DateTime.parse(dateRange.fertile_window_start!)
    //       : null;
    //
    //   DateTime? endDate = dateRange.fertile_window_end != null
    //       ? DateTime.parse(dateRange.fertile_window_end!)
    //       : null;
    //
    //   for (DateTime date = startDate ?? DateTime.now();
    //   date.isBefore((endDate ?? DateTime.now()).add(Duration(days: 1)));
    //   date = date.add(Duration(days: 1))) {
    //     fertileDates.add(date);
    //   }
    //
    //   if (dateRange.ovulation_day != null && dateRange.ovulation_day!.isNotEmpty) {
    //     DateTime ovulationDay = DateTime.parse(dateRange.ovulation_day!);
    //     ovulationDates.add(ovulationDay);
    //
    //     // Ensure fertile window exists for this ovulation date
    //     DateTime fertileStart = ovulationDay.subtract(Duration(days: 5));
    //     DateTime fertileEnd = ovulationDay.add(Duration(days: 2));
    //
    //     List<DateTime> tempFertileDates = List.generate(
    //       fertileEnd.difference(fertileStart).inDays + 1,
    //           (i) => fertileStart.add(Duration(days: i)),
    //     );
    //
    //     for (var date in tempFertileDates) {
    //       if (!fertileDates.contains(date)) {
    //         fertileDates.add(date);
    //       }
    //     }
    //   }
    //
    //   loggedPeriodDates.addAll(List.generate(
    //     end.difference(start).inDays + 1,
    //         (i) => start.add(Duration(days: i)),
    //   ).where((date) => date.isBefore(DateTime.now()) || date.isAtSameMomentAs(DateTime.now())));
    //
    //   DateTime startPredictedPeriods = DateTime.parse(dateRange.predicated_period_start_date);
    //   DateTime endPredictedPeriods = DateTime.parse(dateRange.predicated_period_end_date);
    //   int length = int.parse(dateRange.avg_cycle_length ?? "28");
    //
    //   if (startPredictedPeriods.year == currentYear) {
    //     predictedPeriodDates.addAll(List.generate(
    //       endPredictedPeriods.difference(startPredictedPeriods).inDays,
    //           (i) => startPredictedPeriods.add(Duration(days: i)),
    //     ));
    //   }
    //
    //   if (DateTime.now().difference(end).inDays <= 40) {
    //     for (int i = 0; i < 12; i++) {
    //       startPredictedPeriods = startPredictedPeriods.add(Duration(days: length));
    //       endPredictedPeriods = startPredictedPeriods.add(Duration(days: int.parse(dateRange.period_length)));
    //
    //       if (startPredictedPeriods.year > currentYear) break;
    //
    //       List<DateTime> tempPeriodDates = List.generate(
    //         int.parse(dateRange.period_length),
    //             (i) => startPredictedPeriods.add(Duration(days: i)),
    //       ).where((date) => date.year == currentYear).toList();
    //
    //       int actualPeriodLength = end.difference(start).inDays + 1;
    //       int averagePeriodLength = int.parse(globalUserMaster?.averagePeriodLength ?? "5");
    //
    //       int remainingDays = averagePeriodLength - actualPeriodLength;
    //
    //       if (remainingDays > 0) {
    //         tempPeriodDates.addAll(List.generate(
    //           remainingDays,
    //               (i) => end.add(Duration(days: i + 1)),
    //         ));
    //       }
    //
    //       predictedPeriodDates.addAll(tempPeriodDates);
    //     }
    //   }
    //
    //
    //
    //   List<DateTime> periodStartDates = [];
    //   List<DateTime> periodEndDates = [];
    //
    //   for (int i = 0; i < predictedPeriodDates.length; i++) {
    //     if (i == 0 || predictedPeriodDates.elementAt(i).difference(predictedPeriodDates.elementAt(i - 1)).inDays > 1) {
    //
    //       periodStartDates.add(predictedPeriodDates.elementAt(i));
    //
    //       if (i > 0) {
    //         periodEndDates.add(predictedPeriodDates.elementAt(i - 1));
    //       }
    //     }
    //   }
    //
    //   if (predictedPeriodDates.isNotEmpty) {
    //     periodEndDates.add(predictedPeriodDates.last);
    //   }
    //
    //
    //   for (int i = 0; i < periodStartDates.length; i++) {
    //     DateTime currentPeriodStart = periodStartDates[i];
    //     DateTime? nextPeriodStart = (i + 1 < periodStartDates.length) ? periodStartDates[i + 1] : null;
    //
    //     DateTime futureOvulationDay;
    //     if (nextPeriodStart != null) {
    //       futureOvulationDay = nextPeriodStart.subtract(Duration(days: 14));
    //     } else {
    //       int estimatedCycleLength = (i > 0)
    //           ? periodStartDates[i].difference(periodStartDates[i - 1]).inDays
    //           : 28;
    //       futureOvulationDay = currentPeriodStart.add(Duration(days: estimatedCycleLength - 14));
    //     }
    //
    //     bool ovulationExistsInMonth = ovulationDates.any(
    //           (date) => date.year == futureOvulationDay.year && date.month == futureOvulationDay.month,
    //     );
    //
    //     if (!ovulationExistsInMonth && futureOvulationDay.year == currentYear) {
    //       ovulationDates.add(futureOvulationDay);
    //     } else {
    //       ovulationDates.removeWhere(
    //               (date) => date.year == futureOvulationDay.year && date.month == futureOvulationDay.month);
    //       ovulationDates.add(futureOvulationDay);
    //     }
    //
    //     DateTime futureFertileStart = futureOvulationDay.subtract(Duration(days: 5));
    //     DateTime futureFertileEnd = futureOvulationDay.add(Duration(days: 2));
    //
    //     bool fertileWindowExistsInMonth = fertileDates.any(
    //           (date) => date.year == futureFertileStart.year && date.month == futureFertileStart.month,
    //     );
    //
    //     if (!fertileWindowExistsInMonth && futureFertileStart.year == currentYear && futureFertileEnd.year == currentYear) {
    //       fertileDates.removeWhere(
    //               (date) => date.year == futureFertileStart.year && date.month == futureFertileStart.month);
    //
    //       List<DateTime> tempFertileDates = List.generate(
    //         futureFertileEnd.difference(futureFertileStart).inDays + 1,
    //             (i) => futureFertileStart.add(Duration(days: i)),
    //       ).where((date) => date.year == currentYear).toList();
    //
    //       fertileDates.addAll(tempFertileDates);
    //     }
    //   }
    // }

    List<DateTime> uniquePredictedDates = predictedPeriodDates.toList()
      ..sort((a, b) => a.compareTo(b));

    value = getPeriodStatus(date, uniquePredictedDates, fertileDates,
        ovulationDates, loggedPeriodDates);

    return value;
  }

  String getPeriodStatus(
      DateTime date,
      List<DateTime> predictedPeriodDates,
      List<DateTime> fertileDates,
      List<DateTime> ovulationDates,
      List<DateTime> loggedDates) {
    // predictedPeriodDates.sort();
    //
    // fertileDates.sort();
    // ovulationDates.sort();
    //
    // // Find the next predicted period start date
    // DateTime? nextPeriodStart = predictedPeriodDates.firstWhere(
    //   (d) => d.isAfter(date) || d.isAtSameMomentAs(date),
    //   orElse: () => DateTime(9999),
    // );
    //
    // // Find the last predicted period end date
    // DateTime? lastPeriodDate = predictedPeriodDates.lastWhere(
    //   (d) => d.isBefore(date),
    //   orElse: () => DateTime(0),
    // );
    //
    // // Find the next predicted period start date
    // DateTime? PeriodStartLogged = loggedDates.firstWhere(
    //   (d) => d.isBefore(date),
    //   orElse: () => DateTime(0),
    // );
    //
    // // Find the last predicted period end date
    // DateTime? PeriodEndLogged = predictedPeriodDates.lastWhere(
    //   (d) => d.isBefore(date) || d.isAtSameMomentAs(date),
    //   orElse: () => DateTime(0),
    // );
    //
    // // Find the next fertile start date
    // DateTime? nextFertileStart = fertileDates.firstWhere(
    //   (d) => d.isAfter(date),
    //   orElse: () => DateTime(9999),
    // );
    //
    // // Find the last fertile end date
    // DateTime? lastFertileDate = fertileDates.lastWhere(
    //   (d) => d.isBefore(date),
    //   orElse: () => DateTime(0),
    // );
    //
    // // Find the next ovulation date
    // DateTime? nextOvulationDate = ovulationDates.firstWhere(
    //   (d) => d.isAfter(date) || d.isAtSameMomentAs(date),
    //   orElse: () => DateTime(9999),
    // );
    //
    // // Find the last ovulation date
    // DateTime? lastOvulationDate = ovulationDates.lastWhere(
    //   (d) => d.isBefore(date),
    //   orElse: () => DateTime(0),
    // );
    //
    // // Case 1: The given date is within the predicted period days
    // // Find the most recent predicted period start date
    // DateTime? recentPeriodStart;
    // for (int i = 0; i < predictedPeriodDates.length; i++) {
    //   if (predictedPeriodDates[i].isAfter(date)) break;
    //   if (i == 0 ||
    //       predictedPeriodDates[i]
    //               .difference(predictedPeriodDates[i - 1])
    //               .inDays >
    //           1) {
    //     recentPeriodStart = predictedPeriodDates[i];
    //   }
    // }
    //
    // // // Find the next predicted period start date
    // // DateTime? nextPeriodStart = predictedPeriodDates.firstWhere(
    // //       (d) => d.isAfter(date) || d.isAtSameMomentAs(date),
    // //   orElse: () => DateTime(9999),
    // // );
    //
    // debugPrint("recentPeriodStart===> ${recentPeriodStart}");
    // debugPrint("date===> ${date}");
    // debugPrint("predictedPeriodDates===> ${predictedPeriodDates}");
    //
    // loggedDates.sort((a, b) {
    //   if (a.year == b.year) {
    //     if (a.month == b.month) {
    //       return a.day.compareTo(b.day);
    //     }
    //     return a.month.compareTo(b.month);
    //   }
    //   return a.year.compareTo(b.year);
    // });
    //
    // if (DateTime.now().difference(loggedDates.last).inDays > 40) {
    //   return "Period late";
    // }
    //
    // if (loggedDates.contains(date)) {
    //   int daysLate = date.difference(PeriodStartLogged).inDays + 1;
    //   return "Period Day ${daysLate}";
    // }
    //
    // // Case 1: If the date is within the predicted period days
    // if (predictedPeriodDates.contains(date)) {
    //   int index = predictedPeriodDates.indexOf(date);
    //
    //   if (date.month == DateTime.now().month) {
    //     int periodDay = date.difference(recentPeriodStart!).inDays;
    //     // If it's the same month and Day 1 or Day 2, show "Period may start today"
    //     if (periodDay == 0 || periodDay == 1) {
    //       return "Period may start today";
    //     }
    //     // If the period is late, show how many days late
    //     else if (date.isAfter(recentPeriodStart!)) {
    //       return "Period late by ${periodDay + 1} days";
    //     }
    //   } else {
    //     log("Predicted Period ==> $predictedPeriodDates");
    //     int periodDay = date.difference(recentPeriodStart!).inDays;
    //     // If the month is different, show the exact period day
    //     if (periodDay == 0 || periodDay == 1) {
    //       return "Period may start today";
    //     }
    //
    //     debugPrint("recentPeriodStart ====> $recentPeriodStart");
    //
    //     return "Period Day ${periodDay + 1}";
    //   }
    // }
    //
    // // Case 2: If the given date is exactly the ovulation date
    // if (ovulationDates.contains(date)) {
    //   return "Ovulation Day";
    // }
    //
    // String data = getClosestDate(nextPeriodStart, nextOvulationDate, date);
    //
    // debugPrint("data ====> $data");
    //
    // if (data == "date1") {
    //   // Case 4: The given date is after ovulation and within the fertile window, before the next period
    //   if ((date.isAfter(lastOvulationDate) &&
    //       date.isSameDayOrBefore(nextPeriodStart))) {
    //     if (date.isAfter(lastOvulationDate) &&
    //         date.isSameDayOrBefore(lastOvulationDate.add(Duration(days: 2)))) {
    //       return "Period in ${nextPeriodStart.difference(date).inDays} days before";
    //     }
    //     return "Period in ${nextPeriodStart.difference(date).inDays} days after";
    //   }
    // } else {
    //   // Case 3: The given date is after the last period but before the next ovulation date
    //   if (date.isAfter(lastPeriodDate) && date.isBefore(nextOvulationDate)) {
    //     return "Ovulation in ${nextOvulationDate.difference(date).inDays} days";
    //   }
    // }

    return "";
  }

  String getClosestDate(DateTime date1, DateTime date2, DateTime targetDate) {
    return (targetDate.difference(date1).abs() <
            targetDate.difference(date2).abs())
        ? "date1"
        : "date2";
  }

  String getCyclePhaseMessage({required HomeViewModel mViewModel}) {
    getDateWiseText();
    Future.delayed(Duration(seconds: 1));
    return mViewModel.dateWiseTextList.msg.description;
  }

  // String getCycleDayOrDaysToGo(DateTime currentDate) {
  //   nextCycleDates.sort();
  //
  //   // Find the most recent period start date before or on the current date
  //   DateTime previousCycleStartDate = nextCycleDates.lastWhere(
  //     (date) =>
  //         date.isBefore(currentDate) || date.isAtSameMomentAs(currentDate),
  //     orElse: () => nextCycleDates.first,
  //   );
  //
  //   // Find the next cycle start date after the current date
  //   DateTime nextCycleStartDate = nextCycleDates.firstWhere(
  //     (date) => date.isAfter(currentDate),
  //     orElse: () => nextCycleDates.last,
  //   );
  //
  //   int cycleDay = currentDate.difference(previousCycleStartDate).inDays +
  //       1; // Cycle day including the current date
  //
  //   // Check if the current date is within the period days
  //   bool isPeriodDay = nextCycleDates.any((date) =>
  //       date.year == currentDate.year &&
  //       date.month == currentDate.month &&
  //       date.day == currentDate.day);
  //
  //   if (isPeriodDay) {
  //     // This is a period day
  //     return "Period day";
  //   } else if (currentDate.isBefore(nextCycleStartDate)) {
  //     // Show the day of the current cycle if the current date is before the next cycle start date
  //     // return "Day $cycleDay of current cycle";
  //     return "Day ${cycleDay + int.parse(globalUserMaster?.averagePeriodLength ?? "5") - 1} of current cycle";
  //   } else {
  //     // Calculate days to go until the next period starts
  //     int daysToNextCycle = nextCycleStartDate.difference(currentDate).inDays;
  //     return "$daysToNextCycle days to go";
  //   }
  // }

  void updateSelectedDate(DateTime date) {
    // Setting time to 00:00:00.000
    DateTime modifiedDate = DateTime(date.year, date.month, date.day);
    selectedDate = modifiedDate;
    notifyListeners();
    getDateWiseText();
  }

  String getWeekDay(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.sunday:
        return 'S';
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'T';
      case DateTime.friday:
        return 'F';
      case DateTime.saturday:
        return 'S';
      default:
        return '';
    }
  }

  Future<void> fetchData() async {
    String accessToken = AppPreferences.instance.getAccessToken();
    String numberString = "${globalUserMaster?.id}";
    peroidCustomeList.clear();
    final url = Uri.parse(
        "https://neowindia.com/customeApi/periodinfo.php?user_id=" +
            numberString); // Replace with your API endpoint
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };
    final response =
        await http.get(url, headers: headers).timeout(Duration(seconds: 30));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server returns a successful response, parse the JSON.
      var data = jsonDecode(response.body);
      // debugPrint("data ====>$data");
      List<dynamic> jsonList = jsonDecode(response.body);
      // peroidCustomeList =
      //     jsonList.map((json) => PeriodObj.fromJson(json)).toList();
      peroidCustomeList
          .addAll(jsonList.map((json) => PeriodObj.fromJson(json)).toList());

      // if (peroidCustomeList.isNotEmpty) {
      //   // startDate: newStartDate, cycleLength:
      //   // String periodStartDateString =
      //   //     peroidCustomeList[peroidCustomeList.length - 1].period_start_date;
      //   // DateTime periodStartDate = DateTime.parse(periodStartDateString);
      //   // updateCycleDates(
      //   //   startDate: periodStartDate,
      //   //   cycleLength: int.parse(
      //   //       peroidCustomeList[peroidCustomeList.length - 1].period_length),
      //   // );
      // }

      notifyListeners();

      print('Response data: $jsonList');
      // print('peroidCustomeList data: $peroidCustomeList');
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> getPeriodInfoList() async {
    peroidCustomeList = [];

    PeriodInfoListResponse? master = await _services.api!.getPeriodInfoList();
    ;
    await Future.delayed(Duration(seconds: 1));
    if (master == null) {
      // CommonUtils.oopsMSG();

      getDateWiseText();
      notifyListeners();
      print(
          "................................period info list data oops.............................");
    } else if (master.success == false) {
      // CommonUtils.showSnackBar(
      //   master.message ?? "--",
      //   color: CommonColors.mRed,

      getDateWiseText();
      notifyListeners();
      // );
    } else if (master.success == true) {
      debugPrint("data master ====>${master.data!.toJson()}");
      peroidCustomeList.clear();
      int currentMonth = DateTime.now().month;
      log("currentMonth ====> $currentMonth");
      var data = PeriodObj.fromJson(master.data!.toJson());
      peroidCustomeList.add(data);
      log("True check out check ====> $currentMonth");
      if (currentMonth == int.parse(data.predictions.first.month)) {
        log("True check in check ====> $currentMonth");
        String predictedDate = data.predictions.first.predictedStart;
        log("predictedDate ====> $predictedDate");
        parsedDate = DateFormat('yyyy-MM-dd').parse(predictedDate);
      }
      notifyListeners();
      getDateWiseText();

      updateSelectedDate(DateTime.now());
      print("daaa =>${peroidCustomeList[0].predictions.length}");
      notifyListeners();
    }
    notifyListeners();
  }

  bool isDateWiseTextLoading = false;
  bool isDateWiseTextLoader = false;
  Future<void> getDateWiseText() async {
    isDateWiseTextLoading = true;
    notifyListeners();
    dynamic body = {};
    body = {
      "clicked_date": DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    debugPrint(
        "selectedDate ====>${DateFormat('yyyy-MM-dd').format(selectedDate)}");
    debugPrint("selectedDate ====>${body}");
    try {
      Map<String, dynamic> response =
          await _services.api!.getDateWiseText(params: body);
      debugPrint("response in main response====>${response}");
      dateWiseTextList = ApiResponse.fromJson(response);
      debugPrint("dateWiseTextList ====>${dateWiseTextList.toJson()}");
    } catch (e) {
      isDateWiseTextLoading = false;
      debugPrint("Error fetching date-wise text: $e");
    } finally {
      isDateWiseTextLoading = false;
      notifyListeners();
    }
  }

  DateTime previousDateLocal = DateTime.now();

  ApiResponse dateWiseTextList = ApiResponse(
    status: 0,
    msg: Message(
      title: "",
      description: "",
      color: "",
      periodMsg: '',
      image: '',
    ),
  );

  bool isLoading = false;
  Future<void> handleSecondBloc(
    String dt,
  ) async {
    if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
      print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
      print("Period length :: ${globalUserMaster?.averagePeriodLength}");
      dateParts = dt.split(RegExp(r'[\s-]+'));
      debugPrint("dt :: ${dt.toString()}");
      year = int.parse(dateParts[0]);
      month = int.parse(dateParts[1]);
      day = int.parse(dateParts[2]);
      DateTime previousDate = DateTime(year, month, day);
      previousDateLocal = previousDate;
      DateTime newDate = previousDate
          .add(Duration(
              days: int.parse(globalUserMaster?.averageCycleLength ?? "28")))
          .subtract(Duration(days: 1));
      print("previousDate is :::::::::: $previousDate");
      print("newDate date is :::::::::: $newDate");
      print(
          " cycleLength date is :::::::::: $globalUserMaster?.averageCycleLength");

      nextCycleDates = calculateCycleDatesInYear(
          newDate.month == DateTime.now().month ||
                  previousDate.month == DateTime.now().month
              ? previousDate
              : newDate,
          int.parse(globalUserMaster?.averageCycleLength ?? "28"));
      ovulationDates = calculateOvolutionDatesInYear(
          newDate, int.parse(globalUserMaster?.averageCycleLength ?? "28"));
      firtileDates = calculateFertileDatesInYear(
          previousPeriodStartDate: newDate,
          cycleLength: int.parse(globalUserMaster?.averageCycleLength ?? "28"),
          periodLength:
              int.parse(globalUserMaster?.averagePeriodLength ?? "5"));
      print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
      generateDaysList();
      print("Next date is :::::::::: ${nextCycleDates}");

      DateTime today = DateTime.now();
      DateTime? nextCycleDate = nextCycleDates.firstWhere(
        (date) => date.isAfter(today),
        orElse: () => nextCycleDates.last,
      );

      // Pass the next cycle date to the calculateDaysToGo method
      String daysToGo = calculateDaysToGo(nextCycleDate);
      print(
          'FInal date for done :::::::::::::::::::::::::::==============> $daysToGo');

      // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
    }

    // if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
    //   int cycleLength = int.parse(globalUserMaster?.averageCycleLength ?? "28");
    //   print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
    //   print("dt :: ${dt}");
    //   print(
    //       "Period length :: ${globalUserMaster?.averagePeriodLength} previouspreriodbegin : ${globalUserMaster?.previousPeriodsBegin ?? ''}");
    //   //mViewModel.dateParts = dateString.split(RegExp(r'[\s-]+'));
    //   dateParts = dt.split(RegExp(r'[\s-]+'));
    //   year = int.parse(dateParts[0]);
    //   month = int.parse(dateParts[1]);
    //   day = int.parse(dateParts[2]);
    //   DateTime previousDate = DateTime(year, month, day);
    //   DateTime endDate = DateTime(year, month, day).add(Duration(days: int.parse(globalUserMaster?.averagePeriodLength ?? "5") - 1));
    //   print("previousDate :::::::::: $previousDate");
    //   DateTime newDate = previousDate.add(Duration(days: cycleLength));
    //   print("newDate date is :::::::::: $newDate");
    //   print(" cycleLength date is :::::::::: $cycleLength");
    //
    //   nextCycleDates = calculateCycleDatesInYear(newDate.subtract(Duration(days: 1)), cycleLength);
    //   ovulationDates = calculateOvolutionDatesInYear(previousDate, cycleLength);
    //   firtileDates = calculateFirtileDatesInYear(ovulationDates);
    //   print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
    //   generateDaysList();
    //   print("Next date is :::::::::: $nextCycleDates");
    //
    //   DateTime today = DateTime.now();
    //   DateTime? nextCycleDate = nextCycleDates.firstWhere(
    //     (date) => date.isAfter(today),
    //     orElse: () => nextCycleDates.last,
    //   );
    //
    //   // Pass the next cycle date to the calculateDaysToGo method
    //   // daysToGo = mViewModel.calculateDaysToGo(nextCycleDate);
    //
    //   // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
    // }
  }

  Future<void> fetchHealthMixCategoryList() async {
    try {
      Map<String, dynamic> params = <String, dynamic>{
        ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
      };
      HealthMixCategoryModel? response =
          await _services.api!.getHealthMixCategoryList(params: params);

      if (response != null && response.success == true) {
        healthMixCategoryList = response.data?.records ?? [];
        debugPrint(
            "HealthMixCategoryList fetched successfully: $healthMixCategoryList");
      } else if (response != null && response.success == false) {
        CommonUtils.showSnackBar(
          response.message ?? "Failed to fetch Health Mix Category List",
          color: CommonColors.mRed,
        );
      } else {
        debugPrint("HealthMixCategoryList Response is null");
      }
    } catch (e) {
      // Log the exception and show an error message
      log("Exception in fetchHealthMixCategoryList: $e");
    } finally {
      // Notify listeners to update the UI

      notifyListeners();
    }
  }
}

bool isCurrentDateAfterOvulationRange({
  required DateTime currentDate,
  required DateTime nextCycleStartDate,
  required int periodLength,
}) {
  // Step 1: Determine cycle length (Default: 28 days)
  int cycleLength =
      int.tryParse(globalUserMaster?.averageCycleLength ?? "28") ?? 28;

  // Step 2: Calculate the first day of the current cycle
  DateTime currentCycleStartDate =
      nextCycleStartDate.subtract(Duration(days: cycleLength));

  // Step 3: Calculate the ovulation day (14 days before next cycle start)
  DateTime ovulationDate = nextCycleStartDate.subtract(Duration(days: 14));

  // Step 4: Define the fertile window (5 days before ovulation + ovulation day)
  DateTime fertileStartDate = ovulationDate.subtract(Duration(days: 5));
  DateTime fertileEndDate =
      ovulationDate.add(Duration(days: 1)); // Ovulation day included

  // Step 5: Check if current date is after ovulation window
  return currentDate.isAfter(fertileEndDate);
}

DateTime? getValidCycleStartDate(
    List<DateTime> nextCycleDates, DateTime currentDate, int periodLength) {
  if (nextCycleDates.isEmpty || periodLength < 1) return null;

  nextCycleDates.sort(); // Ensure dates are sorted

  for (int i = 0; i <= nextCycleDates.length - periodLength; i++) {
    List<DateTime> window = nextCycleDates.sublist(i, i + periodLength);

    if (crossesIntoNextMonth(window)) {
      return window.first; // Return first date in the valid sequence
    }
  }

  return null; // No valid cycle found
}

bool crossesIntoNextMonth(List<DateTime> dates) {
  if (dates.length < 2) return false;

  for (int i = 0; i < dates.length - 1; i++) {
    if (dates[i].month != dates[i + 1].month) {
      return true; // Sequence extends into the next month
    }
  }
  return false;
}

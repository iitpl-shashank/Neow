import 'dart:async';
import 'dart:convert';
import 'dart:developer';

// import 'dart:developer';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/hindi_translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../database/app_preferences.dart';
import '../../../models/healthmix_category_model.dart';
import '../../../models/period_log_model.dart';
import '../../../models/period_phase_model.dart';
import '../../../models/slider_video_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_variables.dart';

class HomeViewModel with ChangeNotifier {
  bool startChatBot = false;
  bool showLogSymptomsAlert = false;
  DateTime? parsedDate;
  DateTime? parsedEndDate;
  DateTime? periodStartdateTime;
  DateTime? periodEnddateTime;
  DateTime? ovulationDateTime;
  DateTime? fertileStartDateTime;
  DateTime? fertileEndDateTime;
  DateTime? periodStartLogDateTime;
  DateTime? periodEndLogDateTime;
  DateTime today = DateTime.now();
  DateTime oldDateTime = DateTime(2020, 5, 15);

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

  bool isPeriodLog = false;

  Future<void> checkPeriodLog() async {
    log("Checking period log... ${globalUserMaster!.uuId.toString()}");
    PeriodLogModel? result = await _services.api
        ?.getIsPeriodLog(uniqueId: globalUserMaster!.uuId.toString());
    if (result != null) {
      isPeriodLog = result.data.hasLogs;
      notifyListeners();
      print("Has logs: ${result.data.hasLogs}");
      print("Success: ${result.success}");
      print("Message: ${result.message}");
    } else {
      print("Failed to fetch period log data.");
      isPeriodLog = false;
      notifyListeners();
    }
  }

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

  List<DateTime> calculateCycleDatesInYear(
      DateTime previousDate, int cycleLength) {
    List<DateTime> nextCycleDates = [];

    return nextCycleDates;
  }

  List<DateTime> calculateOvolutionDatesInYear(
      DateTime previousDate, int cycleLength) {
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
    List<DateTime> fertileDates = [];
    List<DateTime> ovulationDates = [];
    List<DateTime> loggedPeriodDates = [];
    Set<DateTime> predictedPeriodDates = {};

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
      jsonDecode(response.body);
      // debugPrint("data ====>$data");
      List<dynamic> jsonList = jsonDecode(response.body);
      // peroidCustomeList =
      //     jsonList.map((json) => PeriodObj.fromJson(json)).toList();
      peroidCustomeList
          .addAll(jsonList.map((json) => PeriodObj.fromJson(json)).toList());

      notifyListeners();

      print('Response data: $jsonList');
      // print('peroidCustomeList data: $peroidCustomeList');
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
    notifyListeners();
  }

  void showLogSymptomsNotification() {
    showLogSymptomsAlert =
        isWithinNoTime(periodStartLogDateTime, periodEndLogDateTime, today)
            ? true
            : false;
    notifyListeners();
  }

  Future<void> getPeriodInfoList() async {
    peroidCustomeList = [];

    PeriodInfoListResponse? master = await _services.api!.getPeriodInfoList();
    ;
    await Future.delayed(Duration(seconds: 1));
    if (master == null) {
      startChatBot = false;
      getDateWiseText();
      notifyListeners();
      print(
          "................................period info list data oops.............................");
    } else if (master.success == false) {
      startChatBot = false;
      getDateWiseText();
      notifyListeners();
    } else if (master.success == true) {
      log("getPeriodInfo data master ====>${master.data.toJson()}");
      peroidCustomeList.clear();
      int currentMonth = DateTime.now().month;
      log("currentMonth ====> $currentMonth");
      var data = PeriodObj.fromJson(master.data.toJson());
      // if (isPeriodLog) {
      peroidCustomeList.add(data);
      // }

      log("True check in check ====> $currentMonth");
      periodStartdateTime =
          DateTime.parse(data.predictions.first.predictedStart);
      periodEnddateTime = DateTime.parse(data.predictions.first.predictedEnd);
      ovulationDateTime = DateTime.parse(data.predictions.first.ovulationDay);
      fertileStartDateTime =
          DateTime.parse(data.predictions.first.fertileWindowStart);
      fertileEndDateTime =
          DateTime.parse(data.predictions.first.fertileWindowEnd);

      periodStartLogDateTime =
          DateTime.parse(data.periodData.first.periodStartDate);
      periodEndLogDateTime =
          DateTime.parse(data.periodData.first.periodEndDate);

      log("periodStartLogDateTime ====> $periodStartLogDateTime");
      log("periodEndLogDateTime ====> $periodEndLogDateTime");
      log("predicted start ====> $periodStartLogDateTime");
      log("predicted end ====> $periodEndLogDateTime");

      log("Check dates $periodEnddateTime and $today");
      if ((isWithin(periodStartdateTime, periodEnddateTime, today) ||
              isWithinNoTime(periodStartdateTime, periodEnddateTime, today) ||
              isWithin(fertileStartDateTime, fertileEndDateTime, today) ||
              isWithinNoTime(fertileStartDateTime, fertileEndDateTime, today) ||
              today.isAtSameMomentAs(ovulationDateTime ?? oldDateTime)) &&
          (isSameDate(periodStartdateTime, periodStartLogDateTime))) {
        startChatBot = true;
        notifyListeners();
      } else {
        startChatBot = false;
        notifyListeners();
      }

      log("True check out check ====> $currentMonth");
      if (currentMonth == int.parse(data.predictions.first.month)) {
        log("True check in check ====> $currentMonth");
        String predictedDate = data.predictions.first.predictedStart;
        log("predictedDate ====> $predictedDate");
        parsedDate = DateFormat('yyyy-MM-dd').parse(predictedDate);
        parsedEndDate =
            DateFormat('yyyy-MM-dd').parse(data.predictions.first.predictedEnd);
      }
      notifyListeners();
      getDateWiseText();

      updateSelectedDate(DateTime.now());
      print("daaa =>${peroidCustomeList[0].predictions.length}");
      notifyListeners();
    }
    notifyListeners();
  }

  bool isWithin(DateTime? start, DateTime? end, DateTime? target) {
    if (start != null && end != null && target != null)
      return (target.isAtSameMomentAs(start) ||
          target.isAtSameMomentAs(end) ||
          (target.isAfter(start) && target.isBefore(end)));

    return false;
  }

  bool isWithinNoTime(DateTime? start, DateTime? end, DateTime? target) {
    if (start != null && end != null && target != null) {
      bool isSameDate(DateTime a, DateTime b) =>
          a.year == b.year && a.month == b.month && a.day == b.day;

      return (isSameDate(target, start) ||
          isSameDate(target, end) ||
          (target.isAfter(start) && target.isBefore(end)));
    }

    return false;
  }

  bool isSameDate(DateTime? a, DateTime? b) {
    if (a != null && b != null) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    } else
      return false;
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

      try {
        if (dateWiseTextList.msg.periodMsg!.contains("दिन लेट") ||
            dateWiseTextList.msg.periodMsg!.contains("Period late by")) {
          peroidCustomeList.clear();
        }
      } catch (e) {
        print(e);
      }
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
  nextCycleStartDate.subtract(Duration(days: cycleLength));

  // Step 3: Calculate the ovulation day (14 days before next cycle start)
  DateTime ovulationDate = nextCycleStartDate.subtract(Duration(days: 14));

  // Step 4: Define the fertile window (5 days before ovulation + ovulation day)
  ovulationDate.subtract(Duration(days: 5));
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/models/login_master.dart';
import 'package:naveli_2023/models/signup_master.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/vertical_calendar/vertical_calendar.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/year_calender_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/home_view.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../services/api_para.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/local_images.dart';
import '../home/home_view_model.dart';
import '../../../services/index.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class WeightData {
  final String weight;
  final String date;
  late HomeViewModel mViewModel;

  WeightData({required this.weight, required this.date});

  // Factory constructor to convert JSON to WeightData object
  factory WeightData.fromJson(Map<String, dynamic> json) {
    return WeightData(
      weight: json['weight'],
      date: json['date'],
    );
  }
}

class MonthData {
  final String month;
  final List<WeightData> data;

  MonthData({required this.month, required this.data});

  // Factory constructor to convert JSON to MonthData object
  factory MonthData.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<WeightData> weightList =
        dataList.map((i) => WeightData.fromJson(i)).toList();

    return MonthData(
      month: json['month'],
      data: weightList,
    );
  }
}

class _CalendarViewState extends State<CalendarView> {
  final _services = Services();
  int selectedIndex = 1;
  late HomeViewModel mViewModel;
  bool _isChecked = false; // State variable to hold checkbox status
  List<DateTime> dateList = [];
  List<DateTime> dateListLatest = [];
  List<DateTime> forParentUseDateList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
debugPrint("data==> $peroidCustomeList");
    for (var dateRange in peroidCustomeList) {
      DateTime start = DateTime.parse(dateRange.periodData![0].periodStartDate);
      DateTime end = DateTime.parse(dateRange.periodData![0].periodEndDate);
      //
      // debugPrint("start: $start");
      // debugPrint("end: $end");
      DateTime now = DateTime.now(); // Get current date

      for (DateTime i = start;
          i.isBefore(end) || i.isAtSameMomentAs(end);
          i = i.add(Duration(days: 1))) {
        setState(() {
          // if(dateList.isEmpty) {
          //   debugPrint("i: $i");
          //   forParentUseDateList.add(i);
          //   dateList.add(i);
          // }
          if (forParentUseDateList.contains(i)) {
            forParentUseDateList.remove(i);
            dateList.remove(i);
          } else {
            forParentUseDateList.add(i);
            dateList.add(i);
          }
        });

        // forParentUseDateList.add(i);
        // dateList.add(i);
      }

      // debugPrint("dateList: $dateList");
      // debugPrint("forParentUseDateList: $forParentUseDateList");
    }
  }

  void _updateButtonText() {
    setState(() {
      if (_isChecked) {
        //postDataCustomeAPI().whenComplete(() {
        addPeriodInfo().whenComplete(() {
          //mViewModel.fetchData().whenComplete(() {
          mViewModel.getPeriodInfoList().whenComplete(() {
            setState(() {
              _isChecked = false;
            });
          });
        });
      } else {
        _isChecked = true;
      }
    });
  }

  void onDayPressed(DateTime NewItem) {
    // setState(() {
    if (forParentUseDateList.contains(NewItem)) {
      forParentUseDateList.remove(NewItem);
      dateList.remove(NewItem);
      dateListLatest.remove(NewItem);
    } else {
      forParentUseDateList.add(NewItem);
      dateList.add(NewItem);
      dateListLatest.add(NewItem);
    }
    //
    // debugPrint("forParentUseDateList: $forParentUseDateList");
    // debugPrint("dateList: $dateList");
    // });
  }

  int cycleLength = int.parse(globalUserMaster?.averageCycleLength ?? "28");

  // String dateString = globalUserMaster?.previousPeriodsBegin ?? '';
  String daysToGo = "";

  // Future<void> handleSecondBloc(NewdateString) async {
  //   if (gUserType == AppConstants.NEOWME || gUserType == AppConstants.BUDDY) {
  //     print("Cycle length :: ${globalUserMaster?.averageCycleLength}");
  //     print(
  //         "Period length :: ${globalUserMaster?.averagePeriodLength} previouspreriodbegin : $NewdateString");
  //     mViewModel.dateParts = NewdateString.split(RegExp(r'[\s-]+'));
  //     mViewModel.year = int.parse(mViewModel.dateParts[0]);
  //     mViewModel.month = int.parse(mViewModel.dateParts[1]);
  //     mViewModel.day = int.parse(mViewModel.dateParts[2]);
  //     DateTime previousDate =
  //         DateTime(mViewModel.year, mViewModel.month, mViewModel.day);
  //     DateTime newDate = previousDate.add(Duration(days: -cycleLength));
  //     print("previousDate is :::::::::: $previousDate");
  //     print("newDate date is :::::::::: $newDate");
  //     print(" cycleLength date is :::::::::: $cycleLength");
  //
  //     mViewModel.nextCycleDates =
  //         mViewModel.calculateCycleDatesInYear(newDate, cycleLength);
  //     mViewModel.ovulationDates =
  //         mViewModel.calculateOvolutionDatesInYear(newDate, cycleLength);
  //     mViewModel.firtileDates = mViewModel.calculateFertileDatesInYear(
  //         previousPeriodStartDate: newDate,
  //         cycleLength: int.parse(globalUserMaster?.averageCycleLength ?? "28"),
  //         periodLength:
  //             int.parse(globalUserMaster?.averagePeriodLength ?? "5"));
  //     print("CycleDates date is :::::::::: ${gCycleDates[0].periodDay}");
  //     mViewModel.generateDaysList();
  //     print("Next date is :::::::::: ${mViewModel.nextCycleDates}");
  //
  //     DateTime today = DateTime.now();
  //     DateTime? nextCycleDate = mViewModel.nextCycleDates.firstWhere(
  //       (date) => date.isAfter(today),
  //       orElse: () => mViewModel.nextCycleDates.last,
  //     );
  //
  //     // Pass the next cycle date to the calculateDaysToGo method
  //     daysToGo = mViewModel.calculateDaysToGo(nextCycleDate);
  //     print(
  //         'FInal date for done :::::::::::::::::::::::::::==============> $daysToGo');
  //
  //     // daysToGo = mViewModel.calculateDaysToGo(mViewModel.nextCycleDates);
  //   }
  // }

  // Future<void> postData(currentMonth, lenghtForPost) async {
  //   String accessToken = AppPreferences.instance.getAccessToken();
  //   DateTime startMonth = DateTime.parse(currentMonth);
  //   final url = Uri.parse(
  //       'https://neowindia.com/api/updateUserDashboard'); // Replace with your API endpoint
  //   final headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $accessToken"
  //   };
  //   final body = jsonEncode({
  //     "average_cycle_length": "${globalUserMaster?.averageCycleLength}",
  //     "average_period_length": "${lenghtForPost}",
  //     "previous_periods_begin":
  //         "${startMonth.year}-${startMonth.month}-${startMonth.day}"
  //   });
  //   CommonUtils.showProgressDialog();
  //   final response = await http.post(url, headers: headers, body: body);
  //
  //   CommonUtils.hideProgressDialog();
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     // If the server returns a successful response, parse the JSON.
  //     var data = jsonDecode(response.body);
  //     CommonUtils.showSnackBar(
  //       'Period Updated Successfully.',
  //       color: CommonColors.greenColor,
  //     );
  //     globalUserMaster?.previousPeriodsBegin =
  //         "${startMonth.year}-${startMonth.month}-${startMonth.day}";
  //     String NewdateString =
  //         "${startMonth.year}-${startMonth.month}-${startMonth.day}";
  //
  //     globalUserMaster?.averageCycleLength =
  //         "${globalUserMaster?.averageCycleLength}";
  //
  //     handleSecondBloc(NewdateString);
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => HomeView()),
  //     // ).then((value) => setState(() {}));
  //     // Navigator.pop(context, "Home Page View"); // popped from LoginScreen().
  //     mViewModel.fetchData();
  //
  //     setState(() {});
  //     print('Response data: $data');
  //   } else {
  //     // If the server did not return a 200 or 201 response, throw an exception.
  //     throw Exception('Failed to post data: ${response.statusCode}');
  //   }
  // }
  //
  // Future<void> postDataCustomeAPI() async {
  //   DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  //
  //   String accessToken = AppPreferences.instance.getAccessToken();
  //   final globalUserMaster = AppPreferences.instance.getUserDetails();
  //   print("ddatt: $forParentUseDateList");
  //   forParentUseDateList.sort();
  //   print(forParentUseDateList);
  //
  //   List<String> formattedDates = forParentUseDateList.map((dateTime) {
  //     return '${dateTime.toLocal().year}-${dateTime.toLocal().month.toString().padLeft(2, '0')}-${dateTime.toLocal().day.toString().padLeft(2, '0')}';
  //   }).toList();
  //   print(formattedDates);
  //   List<DateTime> dates = formattedDates
  //       .map((dateString) => DateTime.parse(dateString))
  //       .toList()
  //     ..sort();
  //
  //   // Find lengths of nearby dates
  //   List<int> nearbyLengths = [];
  //
  //   List<Object> finalArray = [];
  //
  //   int currentLength = 1;
  //   String currentMonth = '';
  //   int lenghtForPost = 0;
  //   for (int i = 1; i < dates.length; i++) {
  //     // Check if the current date is the next day of the previous date
  //
  //     if (dates[i].difference(dates[i - 1]).inDays == 1) {
  //       currentLength++;
  //     } else {
  //       // Store the length of the current sequence if it's more than 1
  //       if (currentLength > 1) {
  //         DateTime startMonth =
  //             DateTime.parse(dateFormat.format(dates[i - (currentLength)]));
  //         if (startMonth.month == DateTime.now().month) {
  //           currentMonth = dateFormat.format(dates[i - (currentLength)]);
  //           lenghtForPost = currentLength;
  //         }
  //         finalArray.add({
  //           "user_id": globalUserMaster?.id,
  //           "period_start_date": dateFormat.format(dates[i - (currentLength)]),
  //           // "${dates[i - (currentLength)].year}-${dates[i - (currentLength)].month}-${dates[i - (currentLength)].day}",
  //           "period_end_date": dateFormat.format(dates[i - 1]),
  //           // "${dates[i - 1].year}-${dates[i - 1].month}-${dates[i - 1].day}",
  //           "period_length": currentLength,
  //           "period_cycle_length": "${globalUserMaster?.averageCycleLength}",
  //           "period_month_update":
  //               dates[i - (currentLength - 1)].year.toString() +
  //                   dates[i - (currentLength - 1)].month.toString()
  //         });
  //         nearbyLengths.add(currentLength);
  //       }
  //
  //       currentLength = 1; // Reset for the next sequence
  //     }
  //   }
  //
  //   // Check for the last sequence
  //   if (currentLength > 1) {
  //     if (currentMonth == '' || lenghtForPost == 0) {
  //       DateTime startMonth = DateTime.parse(
  //           dateFormat.format(dates[dates.length - (currentLength)]));
  //       if (startMonth.month == DateTime.now().month) {
  //         currentMonth =
  //             dateFormat.format(dates[dates.length - (currentLength)]);
  //         lenghtForPost = currentLength;
  //       }
  //     }
  //     finalArray.add({
  //       "user_id": globalUserMaster?.id,
  //       "period_start_date":
  //           dateFormat.format(dates[dates.length - (currentLength)]),
  //       // "${dates[dates.length - (currentLength)].year}-${dates[dates.length - (currentLength)].month}-${dates[dates.length - (currentLength)].day}",
  //       "period_end_date": dateFormat.format(dates[dates.length - 1]),
  //       // "${dates[dates.length - 1].year}-${dates[dates.length - 1].month}-${dates[dates.length - 1].day}",
  //       "period_length": currentLength,
  //       "period_cycle_length": "${globalUserMaster?.averageCycleLength}",
  //       "period_month_update":
  //           dates[dates.length - (currentLength - 1)].year.toString() +
  //               dates[dates.length - (currentLength - 1)].month.toString()
  //     });
  //     nearbyLengths.add(currentLength);
  //   }
  //   // print('=========================user masetr');
  //
  //   // globalUserMaster?.id
  //
  //   final url = Uri.parse(
  //       'https://neowindia.com/customeApi/periodinfo.php'); // Replace with your API endpoint
  //   final headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $accessToken"
  //   };
  //   // final body = finalArray;
  //   print('Final Array =========================================');
  //   print(
  //     jsonEncode(finalArray),
  //   );
  //   CommonUtils.showProgressDialog();
  //   final response =
  //       await http.post(url, headers: headers, body: jsonEncode(finalArray));
  //   CommonUtils.hideProgressDialog();
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     // If the server returns a successful response, parse the JSON.
  //     var data = jsonDecode(response.body);
  //     CommonUtils.showSnackBar(
  //       'Period Updated Successfully.',
  //       color: CommonColors.greenColor,
  //     );
  //     globalUserMaster?.previousPeriodsBegin =
  //         "${forParentUseDateList[0].year}-${forParentUseDateList[0].month}-${forParentUseDateList[0].day}";
  //
  //     globalUserMaster?.averageCycleLength =
  //         "${globalUserMaster?.averageCycleLength}";
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(builder: (context) => HomeView()),
  //     // ).then((value) => setState(() {}));
  //     if (lenghtForPost == 0) {
  //       // fetchData();
  //     } else {
  //       print('========================= currentMonth');
  //       print(currentMonth);
  //       print(lenghtForPost);
  //       print('========================= lenghtForPost');
  //       mViewModel.fetchData();
  //       postData(currentMonth, lenghtForPost);
  //     }
  //     // Navigator.pop(context, "Home Page View"); // popped from LoginScreen().
  //     forParentUseDateList.clear();
  //     print('forParentUseDateList: $forParentUseDateList');
  //     print('Response data: $data');
  //   } else {
  //     CommonUtils.showSnackBar(
  //       'Period overlaps with an existing record',
  //       color: const Color.fromARGB(255, 251, 154, 154),
  //     );
  //     // If the server did not return a 200 or 201 response, throw an exception.
  //     throw Exception('Failed to post data: ${response.statusCode}');
  //   }
  // }

  List<String> getMissingMonths(List<DateTime> dateList) {
    if (dateList.isEmpty) return [];

    int currentYear = DateTime.now().year;

    // Extract existing months in YYYYM format
    Set<String> existingMonths = dateList
        .where((date) => date.year == currentYear) // Filter only current year dates
        .map((date) => "${date.year}${date.month}") // Format as YYYYM
        .toSet();

    // Generate all months for the current year in YYYYM format
    List<String> allMonths = List.generate(12, (index) => "${currentYear}${index + 1}");

    // Find missing months
    List<String> missingMonths = allMonths.where((month) => !existingMonths.contains(month)).toList();

    return missingMonths;
  }


  List<Map<String, String>> groupConsecutiveDates(List<DateTime> dates) {
    dates.sort(); // Ensure they are in order

    List<Map<String, String>> result = [];
    DateTime? startDate;
    DateTime? prevDate;

    for (var date in dates) {
      if (startDate == null) {
        startDate = date;
      } else if (prevDate != null && date.difference(prevDate).inDays > 1) {
        result.add({
          "start_date": startDate.toIso8601String().split("T")[0],
          "end_date": prevDate.toIso8601String().split("T")[0],
        });
        startDate = date;
      }
      prevDate = date;
    }

    // Add the last range
    if (startDate != null && prevDate != null) {
      result.add({
        "start_date": startDate.toIso8601String().split("T")[0],
        "end_date": prevDate.toIso8601String().split("T")[0],
      });
    }

    return result;
  }

  Future<void> addPeriodInfo() async {
    CommonUtils.showProgressDialog();
    HomeViewModel mViewHomeModel = Provider.of<HomeViewModel>(context, listen: false);
    mViewHomeModel.getPeriodInfoList();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String accessToken = AppPreferences.instance.getAccessToken();
    final globalUserMaster = AppPreferences.instance.getUserDetails();

    // Sort Dates
    forParentUseDateList.sort();
    List<String> formattedDates = forParentUseDateList.map((dateTime) {
      return '${dateTime.toLocal().year}-${dateTime.toLocal().month.toString().padLeft(2, '0')}-${dateTime.toLocal().day.toString().padLeft(2, '0')}';
    }).toList();


    debugPrint("formattedDates: $forParentUseDateList");

    List<Map<String, String>> groupedDates = groupConsecutiveDates(forParentUseDateList);
    log("$groupedDates",name: "Grouped Dates");
    List<Map<String, String>> data = mergeDateRanges(groupedDates);
    log("$data",name: "data");

var params = {
"month_array":  jsonEncode(data)
};

    PeriodInfoListResponse? master = await _services.api!.savePeriodsInfo(params: params);

      if (master == null) {
        CommonUtils.oopsMSG();
      } else {
        CommonUtils.showSnackBar(master.message ?? "--",
            color: (master.success ?? true)
                ? CommonColors.greenColor
                : CommonColors.mRed);
      }

  CommonUtils.hideProgressDialog();

  }


  List<Map<String, String>> mergeDateRanges(List<Map<String, String>> ranges) {
    if (ranges.isEmpty) return [];

    List<Map<String, String>> result = [];
    DateFormat format = DateFormat('yyyy-MM-dd');

    DateTime? prevStart;
    DateTime? prevEnd;

    for (var range in ranges) {
      DateTime start = format.parse(range['start_date']!);
      DateTime end = format.parse(range['end_date']!);

      if (prevStart == null) {
        prevStart = start;
        prevEnd = end;
        continue;
      }

      int gap = start.difference(prevEnd!).inDays - 1;
      int prevLength = prevEnd.difference(prevStart).inDays + 1;
      int currLength = end.difference(start).inDays + 1;

      if (gap <= 5 && prevLength < 10) {
        prevEnd = end; // Merge
      } else {
        result.add({'start_date': format.format(prevStart), 'end_date': format.format(prevEnd)});
        prevStart = start;
        prevEnd = end;
      }
    }

    if (prevStart != null && prevEnd != null) {
      result.add({'start_date': format.format(prevStart), 'end_date': format.format(prevEnd)});
    }

    return result;
  }




    // List<String> missingMonths = getMissingMonths(forParentUseDateList);
    //
    // debugPrint("formattedDates: $missingMonths");
    //
    // List<DateTime> dates = formattedDates
    //     .map((dateString) => DateTime.parse(dateString))
    //     .toList()
    //   ..sort();
    //
    // // **Check for Discontinuity and Validate Gaps**
    // List<List<DateTime>> periodGroups = [];
    // List<DateTime> currentGroup = [];
    //
    // for (int i = 0; i < dates.length; i++) {
    //   if (currentGroup.isEmpty) {
    //     currentGroup.add(dates[i]);
    //   } else {
    //     DateTime prevDate = currentGroup.last;
    //     DateTime currentDate = dates[i];
    //
    //     int dayGap = currentDate.difference(prevDate).inDays;
    //
    //     // If the gap is more than or equal to 5 days, start a new cycle
    //     if (dayGap >= 5) {
    //       periodGroups.add(List.from(currentGroup));
    //       currentGroup.clear();
    //     }
    //     currentGroup.add(currentDate);
    //   }
    // }
    // if (currentGroup.isNotEmpty) periodGroups.add(currentGroup);
    //
    // // **Validate Period Cycles**
    // for (int i = 1; i < periodGroups.length; i++) {
    //   DateTime prevStartDate = periodGroups[i - 1].first;
    //   DateTime nextStartDate = periodGroups[i].first;
    //
    //   int gap = nextStartDate.difference(prevStartDate).inDays;
    //   debugPrint("prevStartDate: $prevStartDate");
    //
    //   // 🚨 If the gap between two periods is less than 14 days, show error but do not return
    //   if (gap < 14) {
    //     CommonUtils.showSnackBar(
    //         "⚠️ Warning: Cycle gap is too short. Recommended minimum is 14 days.",
    //         color: CommonColors.mRed);
    //   }
    // }
    //
    // // **Validate if there are more than 2 sets of periods in the same month**
    // Map<String, int> periodCounts = {};
    // for (var group in periodGroups) {
    //   String monthKey = "${group.first.year}${group.first.month.toString()}";
    //   periodCounts[monthKey] = (periodCounts[monthKey] ?? 0) + 1;
    // }
    //
    // if (periodCounts.values.any((count) => count > 2)) {
    //   CommonUtils.showSnackBar(
    //       "🚨 Invalid input: A month cannot have more than two periods.",
    //       color: CommonColors.mRed);
    //   CommonUtils.hideProgressDialog();
    //   return;
    // }
    //
    // // **Process Each Period Separately**
    // for (int i = 0; i < periodGroups.length; i++) {
    //   var group = periodGroups[i];
    //   DateTime periodStart = group.first;
    //   DateTime periodEnd = group.last;
    //   int periodLength = periodEnd.difference(periodStart).inDays + 1;
    //
    //   // Determine correct period update month
    //   DateTime periodUpdateMonth;
    //   if (i > 0) {
    //     DateTime prevPeriodEnd = periodGroups[i - 1].last;
    //     int gap = periodStart.difference(prevPeriodEnd).inDays;
    //
    //     // 🚨 If gap ≤ 5, consider it part of the previous period
    //     if (gap <= 5) {
    //       periodUpdateMonth = periodEnd.month > periodStart.month ? periodEnd : periodStart;
    //
    //     } else {
    //       periodUpdateMonth = DateTime(prevPeriodEnd.year, prevPeriodEnd.month + 1);
    //       missingMonths.remove("${prevPeriodEnd.year}${prevPeriodEnd.month + 1}");
    //     }
    //   } else {
    //     periodUpdateMonth = periodEnd.month > periodStart.month ? periodEnd : periodStart;
    //   }
    //
    //   // Ensure valid month transition (handle December to January case)
    //   if (periodUpdateMonth.month > 12) {
    //     periodUpdateMonth = DateTime(periodUpdateMonth.year + 1, 1);
    //   }
    //
    //   // Calculate missing months dynamically
    //   // List<String> missingMonths = getMissingMonths(
    //   //   periodGroups.expand((group) => group).toList(), // Flatten period groups into a single list
    //   // );
    //
    //   Map<String, dynamic> params = {
    //     ApiParams.period_start_date: dateFormat.format(periodStart),
    //     ApiParams.period_end_date: dateFormat.format(periodEnd),
    //     ApiParams.period_length: periodLength,
    //     ApiParams.period_month_update: "${periodUpdateMonth.year}${periodUpdateMonth.month.toString()}",
    //     ApiParams.period_deleted_month: missingMonths,
    //   };
    //
    //   debugPrint("🚨 Params for ${periodUpdateMonth.year}-${periodUpdateMonth.month}: $params");
    //
    //   // **Make API Call**
    //   PeriodInfoListResponse? master = await _services.api!.savePeriodsInfo(params: params);
    //
    //   if (master == null) {
    //     CommonUtils.oopsMSG();
    //   } else {
    //     CommonUtils.showSnackBar(master.message ?? "--",
    //         color: (master.success ?? true)
    //             ? CommonColors.greenColor
    //             : CommonColors.mRed);
    //   }
    // }
    //
    //
    // CommonUtils.hideProgressDialog();



  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);

    var buttons = Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: CommonColors.mGrey.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(30.0),
          color: CommonColors.mGrey.withOpacity(0.4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: selectedIndex == 1
                        ? const Color(0xFFFFFFFF)
                        : CommonColors.mTransparent),
                child: Text(
                  S.of(context)!.month,
                  style: getAppStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: CommonColors.blackColor),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: selectedIndex == 2
                        ? const Color(0xFFFFFFFF)
                        : CommonColors.mTransparent),
                child: Text(
                  S.of(context)!.year,
                  style: getAppStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: CommonColors.blackColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );

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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(title: ''),
        body: Column(
          children: [
            buttons,
            selectedIndex == 1
                ? Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        /* Text(
                          S.of(context)!.unlockTheSecrets,
                          style: getAppStyle(
                            color: CommonColors.black87,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.w400,
                          ),
                        ), */
                        kCommonSpaceV10,
                        if (AppPreferences.instance.getLanguageCode() == "en" &&
                            selectedIndex == 1)
                          Image.asset(
                            height: kDeviceHeight / 3.5,
                            LocalImages.img_tarikh_pe_tarikh,
                            fit: BoxFit.cover,
                          ),
                        if (AppPreferences.instance.getLanguageCode() == "hi" &&
                            selectedIndex == 1)
                          Image.asset(
                            height: kDeviceHeight / 3.5,
                            LocalImages.img_tarikh_pe_tarikh_hindi,
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Year',
                          style: TextStyle(
                              color: CommonColors.blackColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w400),
                        ),
                        /* Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            S.of(context)!.rakhnaHaiKhyaal,
                            style: GoogleFonts.piedra(
                                color: CommonColors.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Image.asset(
                          LocalImages.img_ye_din_ye_mahine,
                          fit: BoxFit.cover,
                        ), */
                      ],
                    ),
                  ),
            selectedIndex == 1 ? kCommonSpaceV20 : kCommonSpaceV3,
            kCommonSpaceV20,
            Expanded(
                child: selectedIndex == 1
                    ? PagedVerticalCalendar(
                        minDate: DateTime(DateTime.now().year, 1, 1),
                        maxDate: DateTime(DateTime.now().year + 1, 12, 31),
                        initialDate:
                            DateTime.now().add(const Duration(days: 0)),
                        invisibleMonthsThreshold: 1,
                        isChecked: _isChecked,
                        dateList: dateList,
                        onDayPressed: onDayPressed
                        // startWeekWithSunday: true,
                        )
                    : selectedIndex == 2
                        // ScrollingYearsCalendar(
                        // context: context,
                        // initialDate: DateTime.now(),
                        // firstDate: DateTime.now(),
                        // lastDate: DateTime.now(),
                        // highlightedDateColor: CommonColors.primaryColor,
                        // highlightedDates: mViewModel.nextCycleDates,
                        // currentDateColor: CommonColors.secondaryColor,
                        // )
                        ? const YearCalendarView()
                        : Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLogEdit && selectedIndex == 1 && _isChecked)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isChecked = false;
                      });

                      // Add your onPressed code here!
                    },
                    child: Text('Cancel'),
                  ),
                if (isLogEdit && selectedIndex == 1 && _isChecked)
                  kCommonSpaceH15,
                if (isLogEdit && selectedIndex == 1)
                  ElevatedButton(
                    onPressed: () {
                      if (_isChecked) {
                        _updateButtonText();
                      } else {
                        // for (var dateRange in peroidCustomeList) {
                        //   DateTime start = DateTime.parse(dateRange.period_start_date);
                        //   DateTime end = DateTime.parse(dateRange.period_end_date);
                        //
                        //   DateTime now = DateTime.now(); // Get current date
                        //
                        //   for(DateTime i = start; i.isBefore(end) || i.isAtSameMomentAs(end); i = i.add(Duration(days: 1))) {
                        //     if(dateList.isEmpty) {
                        //       forParentUseDateList.add(i);
                        //       dateList.add(i);
                        //     }
                        //     if(forParentUseDateList.contains(i)) {
                        //       forParentUseDateList.remove(i);
                        //       dateList.remove(i);
                        //     } else {
                        //       forParentUseDateList.add(i);
                        //       dateList.add(i);
                        //     }
                        //     // forParentUseDateList.add(i);
                        //     // dateList.add(i);
                        //   }
                        // }

                        //
                        // setState(() {
                        //   dateList = forParentUseDateList;
                        //
                        //   debugPrint("dateList: $dateList");
                        // });
                        // List<DateTime> dates = formattedDates
                        //     .map((dateString) => DateTime.parse(dateString))
                        //     .toList()
                        //   ..sort();
                        // debugPrint("start: $forParentUseDateList");
                        // debugPrint("end: $dateList");
                        _updateButtonText();
                      }

                      // Add your onPressed code here!
                    },
                    child: _isChecked ? Text('Update') : Text('Edit'),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

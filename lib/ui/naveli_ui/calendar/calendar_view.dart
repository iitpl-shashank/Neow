import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/vertical_calendar/vertical_calendar.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/year_calender_view.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/local_images.dart';
import '../home/home_view_model.dart';
import '../../../services/index.dart';

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
    super.initState();
    debugPrint("data==> $peroidCustomeList");
    for (var dateRange in peroidCustomeList) {
      DateTime start = DateTime.parse(dateRange.periodData[0].periodStartDate);
      DateTime end = DateTime.parse(dateRange.periodData[0].periodEndDate);

      for (DateTime i = start;
          i.isBefore(end) || i.isAtSameMomentAs(end);
          i = i.add(Duration(days: 1))) {
        setState(() {
          if (forParentUseDateList.contains(i)) {
            forParentUseDateList.remove(i);
            dateList.remove(i);
          } else {
            forParentUseDateList.add(i);
            dateList.add(i);
          }
        });
      }
    }
  }

  void _updateButtonText() {
    setState(() {
      if (_isChecked) {
        addPeriodInfo().whenComplete(() {
          mViewModel.getPeriodInfoList().whenComplete(() async {
            mViewModel.showLogSymptomsNotification();
            if (gUserType != AppConstants.CYCLE_EXPLORER) {
              mViewModel.checkPeriodLog();
            }
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

  List<String> getMissingMonths(List<DateTime> dateList) {
    if (dateList.isEmpty) return [];

    int currentYear = DateTime.now().year;

    // Extract existing months in YYYYM format
    Set<String> existingMonths = dateList
        .where((date) =>
            date.year == currentYear) // Filter only current year dates
        .map((date) => "${date.year}${date.month}") // Format as YYYYM
        .toSet();

    // Generate all months for the current year in YYYYM format
    List<String> allMonths =
        List.generate(12, (index) => "${currentYear}${index + 1}");

    // Find missing months
    List<String> missingMonths =
        allMonths.where((month) => !existingMonths.contains(month)).toList();

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

    // Sort Dates
    forParentUseDateList.sort();
    debugPrint("formattedDates: $forParentUseDateList");

    List<Map<String, String>> groupedDates =
        groupConsecutiveDates(forParentUseDateList);
    log("$groupedDates", name: "Grouped Dates");
    List<Map<String, String>> data = mergeDateRanges(groupedDates);
    log("$data", name: "data");

    var params = {"month_array": jsonEncode(data)};

    PeriodInfoListResponse? master =
        await _services.api!.savePeriodsInfo(params: params);

    if (master == null) {
      // CommonUtils.oopsMSG();
    } else {
      log("Period Info Saved savePeriodsInfo: ${master.toJson()}");
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

      if (gap <= 5 && prevLength < 10) {
        prevEnd = end; // Merge
      } else {
        result.add({
          'start_date': format.format(prevStart),
          'end_date': format.format(prevEnd)
        });
        prevStart = start;
        prevEnd = end;
      }
    }

    if (prevStart != null && prevEnd != null) {
      result.add({
        'start_date': format.format(prevStart),
        'end_date': format.format(prevEnd)
      });
    }

    return result;
  }

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

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                          kCommonSpaceV10,
                          if (AppPreferences.instance.getLanguageCode() ==
                                  "en" &&
                              selectedIndex == 1)
                            Image.asset(
                              height: kDeviceHeight / 3.5,
                              LocalImages.img_tarikh_pe_tarikh,
                              fit: BoxFit.cover,
                            ),
                          if (AppPreferences.instance.getLanguageCode() ==
                                  "hi" &&
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
                            S.of(context)!.year,
                            style: TextStyle(
                                color: CommonColors.blackColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
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
                          onDayPressed: onDayPressed,
                        )
                      : selectedIndex == 2
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
                      child: Text(
                        S.of(context)!.cancel,
                      ),
                    ),
                  if (isLogEdit && selectedIndex == 1 && _isChecked)
                    kCommonSpaceH15,
                  if (isLogEdit && selectedIndex == 1)
                    ElevatedButton(
                      onPressed: () {
                        if (_isChecked) {
                          _updateButtonText();
                        } else {
                          _updateButtonText();
                        }
                      },
                      child: _isChecked
                          ? Text(
                              S.of(context)!.update,
                            )
                          : Text(
                              S.of(context)!.edit,
                            ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

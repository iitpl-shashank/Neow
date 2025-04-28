import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../database/app_preferences.dart';
import '../../../models/festival_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class SecretDiaryViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<MonthModel> monthList = [];
  List<MonthModel> currentMonthList = [];
  List<String> festivalList = [];
  DateTime currentDateTime = DateTime.now();
  List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  List<String> monthNameList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var cM = DateFormat.MMMM().format(DateTime.now());

  void attachedContext(BuildContext context) {
    this.context = context;
    monthList.clear();
    generateList();
    checkCurrentMonth();
    notifyListeners();
  }

  void checkCurrentMonth() {
    currentMonthList =
        monthList.where((month) => month.monthName == cM).toList();
    print(currentMonthList.length);
  }

  void generateList() {
    for (int i = 0; i < 12; i++) {
      // Calculate the first day of the month
      DateTime firstDayOfMonth = DateTime(currentDateTime.year, i + 1, 1);

      // Calculate the total number of days in the month
      int daysInMonth = DateTime(currentDateTime.year, i + 1 + 1, 0).day;

      // Create a list of DateTime objects for each day in the month
      List<DateTime> monthDays = List.generate(
        daysInMonth,
        (index) => DateTime(currentDateTime.year, i + 1, index + 1),
      );

      // Add null DateTime objects to the beginning to adjust the weekday offset
      int weekdayOffset = firstDayOfMonth.weekday;
      for (int j = 0; j < weekdayOffset - 1; j++) {
        monthDays.insert(0, DateTime(0000, 00, 00));
      }

      // Create a MonthModel object and add it to the monthList
      monthList.add(
        MonthModel(
          monthNameList[i],
          i + 1,
          firstDayOfMonth.day,
          monthDays,
          year: currentDateTime.year,
        ),
      );
    }
    notifyListeners();
  }

  // void generateList() {
  //   // get first and last date of year
  //   DateTime firstDateOfYear = DateTime(currentDateTime.year, 01, 01);
  //   DateTime lastDateOfYear = DateTime(currentDateTime.year, 12, 31);
  //   // get all days of the year
  //   final List<DateTime> days = [];
  //   for (int i = 0;
  //       i <= lastDateOfYear.difference(firstDateOfYear).inDays;
  //       i++) {
  //     days.add(firstDateOfYear.add(Duration(days: i)));
  //   }
  //
  //   // add all day to list month wise
  //   for (int i = 0; i < 12; i++) {
  //     List<DateTime> tempDateTime =
  //         days.where((element) => element.month == i + 1).toList();
  //     print("tempDateTime.first.weekday ${tempDateTime.first.weekday}");
  //     // skip the weekdays
  //
  //     if (tempDateTime.first.weekday < 7) {
  //       List<DateTime> nullList = [];
  //       for (int j = 0; j < tempDateTime.first.weekday; j++) {
  //         nullList.add(DateTime(0000, 00, 00));
  //       }
  //
  //       tempDateTime.insertAll(0, nullList);
  //     }
  //     monthList.add(MonthModel(
  //         monthNameList[i], i + 1, tempDateTime.first.day, tempDateTime,
  //         year: currentDateTime.year));
  //   }
  //   notifyListeners();
  // }

  Future<void> getFestivalListApi() async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    FestivalMaster? master =
        await _services.api!.getFestivalList(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................secret diary oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      festivalList = master.data ?? [];
      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

class MonthModel {
  String? monthName;
  int monthNumber;
  int? startDay;
  int year;
  List<DateTime> daysList = [];

  MonthModel(this.monthName, this.monthNumber, this.startDay, this.daysList,
      {required this.year});
}

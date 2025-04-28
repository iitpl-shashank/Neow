import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/constant.dart';

class NaveliVerticalCalender extends StatefulWidget {
  const NaveliVerticalCalender({super.key});

  @override
  State<NaveliVerticalCalender> createState() => _NaveliVerticalCalenderState();
}

class _NaveliVerticalCalenderState extends State<NaveliVerticalCalender> {
  List<MonthModel> monthList = [];
  DateTime currentDateTime = DateTime.now();
  List<String> weekDay = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
  List<String> monthNameList = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ListView.builder(
              itemCount: monthList.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        monthList[index].monthName!,
                        style: getAppStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            weekDay.length,
                                (index) => Flexible(
                                child: Text(
                                  weekDay[index],
                                  style:
                                  getAppStyle(fontWeight: FontWeight.w600),
                                ))),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GridView.count(
                        crossAxisCount: 7,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5.0,
                        children: List.generate(
                            monthList[index].daysList.length, (dayIndex) {
                          if (monthList[index].daysList[dayIndex].year == -1) {
                            return Container();
                          } else {}

                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(left: 15.0),
                              // decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     color: Colors.greenAccent,
                              //     border: Border.all(
                              //         width: 1.0,
                              //         color: CommonColors.darkPink)),
                              child: Center(
                                  child: Text(monthList[index]
                                      .daysList[dayIndex]
                                      .day
                                      .toString())),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  void generateList() {
    // get first and last date of year
    DateTime firstDateOfYear = DateTime(currentDateTime.year, 01, 01);
    DateTime lastDateOfYear = DateTime(currentDateTime.year, 12, 31);
    // get all days of the year
    final List<DateTime> days = [];
    for (int i = 0;
    i <= lastDateOfYear.difference(firstDateOfYear).inDays;
    i++) {
      days.add(firstDateOfYear.add(Duration(days: i)));
    }

    // add all day to list month wise
    for (int i = 0; i < 12; i++) {
      List<DateTime> tempDateTime =
      days.where((element) => element.month == i + 1).toList();
      print("tempDateTime.first.weekday ${tempDateTime.first.weekday}");
      // skip the weekdays

      if (tempDateTime.first.weekday < 7) {
        List<DateTime> nullList = [];
        for (int j = 0; j < tempDateTime.first.weekday; j++) {
          nullList.add(DateTime(0000, 00, 00));
        }

        tempDateTime.insertAll(0, nullList);
      }

      monthList.add(MonthModel(
          monthNameList[i], i + 1, tempDateTime.first.day, tempDateTime));
    }
  }
}

class MonthModel {
  String? monthName;
  int? monthNumber;
  int? startDay;
  List<DateTime> daysList = [];

  MonthModel(this.monthName, this.monthNumber, this.startDay, this.daysList);
}

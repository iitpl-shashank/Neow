import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/date_utils.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../home/home_view_model.dart';

class YearCalendarView extends StatefulWidget {
  const YearCalendarView({super.key});

  @override
  _YearCalendarViewState createState() => _YearCalendarViewState();
}

class _YearCalendarViewState extends State<YearCalendarView> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Year Calendar'),
      // ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 / 1.4),
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return MonthView(
            month: index + 1,
            year: DateTime.now().year,
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            selectedDate: selectedDate, // Uncommented selectedDate here
          );
        },
      ),
    );
  }
}

class MonthView extends StatefulWidget {
  final int month;
  final int year;
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate; // Uncommented selectedDate here

  const MonthView({
    super.key,
    required this.month,
    required this.year,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  late HomeViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    refreshView();
  }

  refreshView() {
    // print("daaaaaaaaaaaaaaaaa=>${peroidCustomeList[0].period_start_date}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    DateTime ovulationDate = DateTime(2020, 1, 1);

    final firstDayOfWeek = DateTime(widget.year, widget.month, 1).weekday;
    final daysInMonth = getDaysInMonth(widget.year, widget.month);
    final List<Widget> dayWidgets = List.generate(firstDayOfWeek - 1, (index) {
      // Add empty containers for days before the first day of the month
      return Container();
    });
    List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];

    // Generate day widgets for the actual days in the month
    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(widget.year, widget.month, i);
      final isSelectedDate = widget.selectedDate != null &&
          date.day == widget.selectedDate?.day &&
          date.month == widget.selectedDate?.month &&
          date.year == widget.selectedDate?.year;

      bool isHighlighted = false;
      bool isFuturePredictedHighlighted = false;
      bool isOvulation = false;
      bool isFertile = false;
      DateTime now = DateTime.now();


      List<DateTime> fertileDates = [];
      List<DateTime> ovulationDates = [];
      List<DateTime> loggedPeriodDates = [];
      List<DateTime> predictedPeriodDates = [];

      // DateTime now = DateTime.now();
      int currentYear = now.year;

      // DateTime now = DateTime.now();
      // int currentYear = now.year;
      peroidCustomeList.forEach((element) {
        element.periodData!.forEach((periodDates){
          for (DateTime start =
          DateTime.parse(periodDates.periodStartDate);
          start.isSameDayOrBefore(
              DateTime.parse(periodDates.periodEndDate));
          start = start.add(Duration(days: 1))) {
            loggedPeriodDates.add(start);

          }
        });

        element.predictions!.forEach((predictions) {
          for (DateTime start =
          DateTime.parse(predictions.predictedStart);
          start.isSameDayOrBefore(
              DateTime.parse(predictions.predictedEnd));
          start = start.add(Duration(days: 1))) {
            predictedPeriodDates.add(start);

          }
          for (DateTime start =
          DateTime.parse(predictions.fertileWindowStart);
          start.isSameDayOrBefore(
              DateTime.parse(predictions.fertileWindowEnd));
          start = start.add(Duration(days: 1))) {
            fertileDates.add(start);

          }

          ovulationDates.add(DateTime.parse(predictions.ovulationDay));

        });

      });
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
      //   ovulationDates.add(DateTime.parse(dateRange.ovulation_day ?? ""));
      //
      //   loggedPeriodDates.addAll(List.generate(
      //     end.difference(start).inDays + 1, // +1 to include 'end' date
      //         (i) => start.add(Duration(days: i)),
      //   ).where((date) =>
      //   date.isBefore(DateTime.now()) ||
      //       date.isAtSameMomentAs(DateTime.now())));
      //
      //   DateTime startPredictedPeriods =
      //   DateTime.parse(dateRange.predicated_period_start_date);
      //   DateTime endPredictedPeriods =
      //   DateTime.parse(dateRange.predicated_period_end_date);
      //   int length = int.parse(dateRange.avg_cycle_length ?? "28");
      //
      //   if (startPredictedPeriods.year == now.year) {
      //     predictedPeriodDates.addAll(List.generate(
      //       endPredictedPeriods.difference(startPredictedPeriods).inDays,
      //           (i) => startPredictedPeriods.add(Duration(days: i)),
      //     ));
      //   }
      //   debugPrint("Days between last and current date ${DateTime.now().difference(end).inDays}");
      //
      //   // ✅ Only calculate future dates if the last period ended within 40 days
      //   if (DateTime.now().difference(end).inDays <= 40) {
      //     for (int i = 0; i < 12; i++) {
      //       startPredictedPeriods =
      //           startPredictedPeriods.add(Duration(days: length));
      //       endPredictedPeriods =
      //           startPredictedPeriods.add(Duration(days: int.parse(dateRange.period_length)));
      //
      //       if (startPredictedPeriods.year > now.year) break;
      //
      //       List<DateTime> tempPeriodDates = List.generate(
      //         int.parse(dateRange.period_length),
      //             (i) => startPredictedPeriods.add(Duration(days: i)),
      //       ).where((date) => date.year == now.year).toList();
      //
      //       int actualPeriodLength = end.difference(start).inDays + 1;
      //       int averagePeriodLength =
      //       int.parse(globalUserMaster?.averagePeriodLength ?? "5");
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
      //   predictedPeriodDates.sort();
      //
      //   List<DateTime> periodStartDates = [];
      //   List<DateTime> periodEndDates = [];
      //
      //   for (int i = 0; i < predictedPeriodDates.length; i++) {
      //     if (i == 0 || predictedPeriodDates[i].difference(predictedPeriodDates[i - 1]).inDays > 1) {
      //       periodStartDates.add(predictedPeriodDates[i]);
      //
      //       if (i > 0) {
      //         periodEndDates.add(predictedPeriodDates[i - 1]);
      //       }
      //     }
      //   }
      //
      //   if (predictedPeriodDates.isNotEmpty) {
      //     periodEndDates.add(predictedPeriodDates.last);
      //   }
      //
      //   predictedPeriodDates.sort();
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
      //       ).where((date) => date.year == now.year).toList();
      //
      //       fertileDates.addAll(tempFertileDates);
      //     }
      //   }
      // }



// Checking if the given `date` falls in the calculated dates
      if (loggedPeriodDates.contains(date)) {
        isHighlighted = true;
      }

      if (predictedPeriodDates.contains(date)) {
        isFuturePredictedHighlighted = true;
      }

      if (fertileDates.contains(date)) {
        isFertile = true;
      }
      ovulationDates.removeAt(ovulationDates.length - 1);
      if (ovulationDates.contains(date)) {
        if(date.year<date.year + 1) {
          isOvulation = true;
        }
      }




      // for (var dateRange in peroidCustomeList) {
      //   DateTime start = DateTime.parse(dateRange.period_start_date);
      //   DateTime end = DateTime.parse(dateRange.period_end_date);
      //   int cycleLength = int.parse(dateRange.period_cycle_length);
      //
      //   if (date.isAfter(start) && date.isBefore(end) ||
      //       date.isAtSameMomentAs(start) ||
      //       date.isAtSameMomentAs(end)) {
      //     isHighlighted = true;
      //   }
      //
      //   DateTime previousOvulationDay = start.subtract(Duration(days: 14));
      //   DateTime previousFertileStartDate = previousOvulationDay.subtract(Duration(days: 5));
      //   DateTime previousFertileEndDate = previousOvulationDay.add(Duration(days: 2));
      //
      //   if (date.isSameDay(previousOvulationDay)) {
      //     isOvulation = true;
      //   }
      //
      //   if (date.isAfter(previousFertileStartDate) && date.isBefore(previousFertileEndDate) ||
      //       date.isAtSameMomentAs(previousFertileStartDate) ||
      //       date.isAtSameMomentAs(previousFertileEndDate)) {
      //     isFertile = true;
      //   }
      // }
      //
      // for (DateTime predictedStartDate in mViewModel.nextCycleDates) {
      //   if (predictedStartDate.difference(now).inDays > 40) {
      //     continue; // Skip predictions if they are more than 40 days away
      //   }
      //
      //   DateTime predictedOvulationDay = predictedStartDate.add(Duration(days: 14));
      //   DateTime predictedFertileStartDate = predictedOvulationDay.subtract(Duration(days: 5));
      //   DateTime predictedFertileEndDate = predictedOvulationDay.add(Duration(days: 2));
      //
      //   if (date.isSameDay(predictedStartDate)) {
      //     isHighlighted = true;
      //   }
      //
      //   if (date.isAfter(predictedFertileStartDate) && date.isBefore(predictedFertileEndDate) ||
      //       date.isAtSameMomentAs(predictedFertileStartDate) ||
      //       date.isAtSameMomentAs(predictedFertileEndDate)) {
      //     isFertile = true;
      //   }
      //
      //   if (date.isSameDay(predictedOvulationDay)) {
      //     isOvulation = true;
      //   }
      //
      //   if (date.isAfter(now) && date.month >= now.month && date.month <= now.month + 12) {
      //     bool isWithinNext12Months = date.year == now.year || (date.year == now.year + 1 && date.month <= 12);
      //     if (isWithinNext12Months) {
      //       isFuturePredictedHighlighted = mViewModel.nextCycleDates.contains(date);
      //     }
      //   }
      // }
      //
      // if (date.isSameDay(ovulationDate)) {
      //   isOvulation = true;
      // }
      //
      // if (date.isAfter(now)) {
      //   bool isInUpcomingMonths = date.year == now.year ||
      //       (date.year == now.year + 1 && date.month <= now.month);
      //
      //   if (isInUpcomingMonths && date.difference(now).inDays <= 40) {
      //     isHighlighted = mViewModel.nextCycleDates.contains(date);
      //     isOvulation = mViewModel.ovulationDates.contains(date);
      //     isFuturePredictedHighlighted = true;
      //   } else {
      //     isFuturePredictedHighlighted = false;
      //   }
      // } else {
      //   isFuturePredictedHighlighted = false;
      // }

      dayWidgets.add(
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: isHighlighted && !isFuturePredictedHighlighted
                  ? BoxDecoration(
                gradient: mViewModel.getGradient(),
                borderRadius: BorderRadius.circular(8),
              )
                  : isHighlighted && isFuturePredictedHighlighted
                  ? null
                  : isOvulation
                  ? BoxDecoration(
                gradient: mViewModel.getGradientGreen(),
                borderRadius: BorderRadius.circular(8),
              )
                  : isSelectedDate
                  ? BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              )
                  : null,
              child: DottedBorder(
                color: isFertile
                    ? CommonColors.greenColor
                    : isFuturePredictedHighlighted
                    ? CommonColors.mRed
                    : CommonColors.mTransparent,
                dashPattern: [4, 3],
                strokeWidth: isFertile ? 1 : 0,
                borderType: BorderType.Circle,
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontSize: 6,
                      color: (isSelectedDate || (isHighlighted && !isFuturePredictedHighlighted) || isOvulation)
                          ? Colors.white
                          : (isHighlighted && isFuturePredictedHighlighted)
                          ? Colors.black
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }


    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.MMMM().format(DateTime(widget.year, widget.month)),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),

          Container(
            color: Color(0xFFFFFFFF),
            padding: const EdgeInsets.only(top: 10, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                weekDay.length,
                (index) => Flexible(
                  child: Text(
                    weekDay[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Display dates
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 7,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}

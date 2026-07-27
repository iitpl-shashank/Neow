import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/utils/global_function.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../app/app_model.dart';
import '../../home/home_view_model.dart';

class YearCalendarView extends StatefulWidget {
  final List<DateTime> dateList;
  final ValueChanged<DateTime>? onDayPressed;
  final bool isChecked;

  const YearCalendarView({
    super.key,
    required this.dateList,
    this.onDayPressed,
    this.isChecked = false,
  });

  @override
  _YearCalendarViewState createState() => _YearCalendarViewState();
}

class _YearCalendarViewState extends State<YearCalendarView> {
  DateTime? selectedDate;
  int currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Year Selection Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  onPressed: () {
                    setState(() {
                      currentYear--;
                    });
                  },
                ),
                Text(
                  "$currentYear",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CommonColors.blackColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    setState(() {
                      currentYear++;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.35),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CommonColors.mGrey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: MonthView(
                    month: index + 1,
                    year: currentYear,
                    dateList: widget.dateList,
                    onDayPressed: widget.onDayPressed,
                    isChecked: widget.isChecked,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    selectedDate: selectedDate,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonthView extends StatefulWidget {
  final int month;
  final int year;
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate;
  final List<DateTime> dateList;
  final ValueChanged<DateTime>? onDayPressed;
  final bool isChecked;

  const MonthView({
    super.key,
    required this.month,
    required this.year,
    required this.onDateSelected,
    this.selectedDate,
    required this.dateList,
    this.onDayPressed,
    this.isChecked = false,
  });

  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  late HomeViewModel mViewModel;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _containsDay(Iterable<DateTime> list, DateTime d) {
    return list.any((item) => _isSameDay(item, d));
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);

    final firstDayOfWeek = DateTime(widget.year, widget.month, 1).weekday;
    final daysInMonth = getDaysInMonth(widget.year, widget.month);

    List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];

    // Collect dates for period, predicted, fertile, and ovulation
    List<DateTime> fertileDates = [];
    List<DateTime> ovulationDates = [];
    List<DateTime> loggedPeriodDates = [];
    List<DateTime> predictedPeriodDates = [];

    if (peroidCustomeList.isEmpty) {
      loggedPeriodDates.addAll(mViewModel.nextCycleDates);
      ovulationDates.addAll(mViewModel.ovulationDates);
      fertileDates.addAll(mViewModel.firtileDates);
    } else {
      for (var element in peroidCustomeList) {
        for (var periodDates in element.periodData) {
          try {
            DateTime start = DateTime.parse(periodDates.periodStartDate);
            DateTime end = DateTime.parse(periodDates.periodEndDate);
            for (DateTime s = start;
                s.isBefore(end) || _isSameDay(s, end);
                s = s.add(const Duration(days: 1))) {
              loggedPeriodDates.add(s);
            }
          } catch (_) {}
        }

        if (mViewModel.isPeriodLog) {
          for (var predictions in element.predictions) {
            try {
              DateTime startP = DateTime.parse(predictions.predictedStart);
              DateTime endP = DateTime.parse(predictions.predictedEnd);
              for (DateTime s = startP;
                  s.isBefore(endP) || _isSameDay(s, endP);
                  s = s.add(const Duration(days: 1))) {
                predictedPeriodDates.add(s);
              }

              DateTime startF = DateTime.parse(predictions.fertileWindowStart);
              DateTime endF = DateTime.parse(predictions.fertileWindowEnd);
              for (DateTime s = startF;
                  s.isBefore(endF) || _isSameDay(s, endF);
                  s = s.add(const Duration(days: 1))) {
                fertileDates.add(s);
              }

              if (predictions.ovulationDay.isNotEmpty) {
                ovulationDates.add(DateTime.parse(predictions.ovulationDay));
              }
            } catch (_) {}
          }
        }
      }
    }

    final List<Widget> dayWidgets = List.generate(firstDayOfWeek - 1, (index) {
      return Container();
    });

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(widget.year, widget.month, i);

      final isSelectedDate = widget.selectedDate != null &&
          _isSameDay(widget.selectedDate!, date);

      final bool isUserLoggedDate = _containsDay(widget.dateList, date);
      final bool isApiLoggedDate = _containsDay(loggedPeriodDates, date);
      final bool isHighlighted = isUserLoggedDate || isApiLoggedDate;

      final bool isFuturePredictedHighlighted =
          _containsDay(predictedPeriodDates, date);
      final bool isFertile = _containsDay(fertileDates, date);
      final bool isOvulation = _containsDay(ovulationDates, date);

      BoxDecoration? cellDecoration;
      Color textColor = Colors.black;
      FontWeight textFontWeight = FontWeight.normal;

      if (isHighlighted && !isFuturePredictedHighlighted) {
        // Logged period: Circular Red Gradient (matches monthly view)
        cellDecoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF9D93),
              Color(0xFFFFB5AE),
            ],
          ),
        );
        textColor = Colors.white;
        textFontWeight = FontWeight.bold;
      } else if (isOvulation) {
        // Ovulation: Circular Green Gradient (matches monthly view)
        cellDecoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: mViewModel.getGradientGreen(),
        );
        textColor = Colors.white;
        textFontWeight = FontWeight.bold;
      } else if (isSelectedDate) {
        // Selected by tap: Circular Secondary Accent color (distinct from white/blue)
        cellDecoration = BoxDecoration(
          shape: BoxShape.circle,
          color: CommonColors.secondaryColor,
        );
        textColor = Colors.white;
        textFontWeight = FontWeight.bold;
      }

      Color borderColor = CommonColors.mTransparent;
      double strokeWidth = 0;

      if (isFertile) {
        borderColor = CommonColors.greenColor;
        strokeWidth = 1.5;
      } else if (isFuturePredictedHighlighted) {
        borderColor = CommonColors.mRed;
        strokeWidth = 1.5;
      }

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            widget.onDateSelected(date);
            if (widget.onDayPressed != null) {
              widget.onDayPressed!(date);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: cellDecoration,
              child: DottedBorder(
                color: borderColor,
                dashPattern: const [4, 3],
                strokeWidth: strokeWidth,
                borderType: BorderType.Circle,
                child: Center(
                  child: Text(
                    '$i',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 9,
                      fontWeight: textFontWeight,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    var lang = Provider.of<AppModel>(context).locale;

    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Month Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              lang == 'hi'
                  ? DateFormat.MMMM('hi')
                      .format(DateTime(widget.year, widget.month))
                  : DateFormat.MMMM()
                      .format(DateTime(widget.year, widget.month)),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: CommonColors.primaryColor,
              ),
            ),
          ),

          // Week days header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              weekDay.length,
              (index) => Expanded(
                child: Center(
                  child: Text(
                    weekDay[index],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),

          // Calendar Grid
          Expanded(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 7,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: dayWidgets,
            ),
          ),
        ],
      ),
    );
  }
}

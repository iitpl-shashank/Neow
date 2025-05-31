import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/date_utils.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../models/date_model.dart';
import '../../home/home_view_model.dart';

enum PaginationDirection {
  up,
  down,
}

class PagedVerticalCalendar extends StatefulWidget {
  PagedVerticalCalendar({
    super.key,
    this.minDate,
    this.maxDate,
    DateTime? initialDate,
    this.monthBuilder,
    this.dayBuilder,
    this.addAutomaticKeepAlives = false,
    this.onDayPressed,
    this.onMonthLoaded,
    this.onPaginationCompleted,
    this.invisibleMonthsThreshold = 1,
    this.physics,
    this.scrollController,
    this.listPadding = EdgeInsets.zero,
    this.startWeekWithSunday = false,
    this.weekdaysToHide = const [],
    this.isChecked,
    required this.dateList,
  }) : initialDate = initialDate ?? DateTime.now().removeTime();
  final DateTime? minDate;

  final DateTime? maxDate;

  final DateTime initialDate;

  final MonthBuilder? monthBuilder;

  final DayBuilder? dayBuilder;

  final bool addAutomaticKeepAlives;

  final ValueChanged<DateTime>? onDayPressed;

  final OnMonthLoaded? onMonthLoaded;

  final ValueChanged<PaginationDirection>? onPaginationCompleted;

  final int invisibleMonthsThreshold;

  final EdgeInsets listPadding;

  final ScrollPhysics? physics;

  final ScrollController? scrollController;

  final bool startWeekWithSunday;

  final List<int> weekdaysToHide;

  final dynamic isChecked;

  final List<DateTime> dateList;

  @override
  _PagedVerticalCalendarState createState() => _PagedVerticalCalendarState();
}

class _PagedVerticalCalendarState extends State<PagedVerticalCalendar> {
  late PagingController<int, Month> _pagingReplyUpController;
  late PagingController<int, Month> _pagingReplyDownController;

  final Key downListKey = UniqueKey();
  late bool hideUp;

  @override
  void initState() {
    super.initState();

    if (widget.minDate != null &&
        widget.initialDate.isBefore(widget.minDate!)) {
      throw ArgumentError("initialDate cannot be before minDate");
    }

    if (widget.maxDate != null && widget.initialDate.isAfter(widget.maxDate!)) {
      throw ArgumentError("initialDate cannot be after maxDate");
    }

    hideUp = !(widget.minDate == null ||
        !widget.minDate!.isSameMonth(widget.initialDate));

    _pagingReplyUpController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyUpController.addPageRequestListener(_fetchUpPage);
    _pagingReplyUpController.addStatusListener(paginationStatusUp);

    _pagingReplyDownController = PagingController<int, Month>(
      firstPageKey: 0,
      invisibleItemsThreshold: widget.invisibleMonthsThreshold,
    );
    _pagingReplyDownController.addPageRequestListener(_fetchDownPage);
    _pagingReplyDownController.addStatusListener(paginationStatusDown);
  }

  @override
  void didUpdateWidget(covariant PagedVerticalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.minDate != oldWidget.minDate) {
      _pagingReplyUpController.refresh();

      hideUp = !(widget.minDate == null ||
          !widget.minDate!.isSameMonth(widget.initialDate));
    }
  }

  void paginationStatusUp(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.up);
    }
  }

  void paginationStatusDown(PagingStatus state) {
    if (state == PagingStatus.completed) {
      return widget.onPaginationCompleted?.call(PaginationDirection.down);
    }
  }

  /// fetch a new [Month] object based on the [pageKey] which is the Nth month
  /// from the start date
  void _fetchUpPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month - 1, 1),
        widget.minDate,
        pageKey,
        true,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.minDate != null &&
          widget.minDate!.isSameDayOrAfter(month.weeks.first.firstDay);

      if (isLastPage) {
        return _pagingReplyUpController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyUpController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyUpController.error;
    }
  }

  void _fetchDownPage(int pageKey) async {
    try {
      final month = DateUtils.getMonth(
        DateTime(widget.initialDate.year, widget.initialDate.month, 1),
        widget.maxDate,
        pageKey,
        false,
        startWeekWithSunday: widget.startWeekWithSunday,
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onMonthLoaded?.call(month.year, month.month),
      );

      final newItems = [month];
      final isLastPage = widget.maxDate != null &&
          widget.maxDate!.isSameDayOrBefore(month.weeks.last.lastDay);

      if (isLastPage) {
        return _pagingReplyDownController.appendLastPage(newItems);
      }

      final nextPageKey = pageKey + newItems.length;
      _pagingReplyDownController.appendPage(newItems, nextPageKey);
    } catch (_) {
      _pagingReplyDownController.error;
    }
  }

  EdgeInsets _getDownListPadding() {
    final double paddingTop = hideUp ? widget.listPadding.top : 0;
    return EdgeInsets.fromLTRB(widget.listPadding.left, paddingTop,
        widget.listPadding.right, widget.listPadding.bottom);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: widget.scrollController,
      physics: widget.physics,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Viewport(
          offset: position,
          center: downListKey,
          slivers: [
            if (!hideUp)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(widget.listPadding.left,
                    widget.listPadding.top, widget.listPadding.right, 0),
                sliver: PagedSliverList(
                  pagingController: _pagingReplyUpController,
                  builderDelegate: PagedChildBuilderDelegate<Month>(
                    itemBuilder:
                        (BuildContext context, Month month, int index) {
                      return _MonthView(
                          month: month,
                          monthBuilder: widget.monthBuilder,
                          dayBuilder: widget.dayBuilder,
                          onDayPressed: widget.onDayPressed,
                          startWeekWithSunday: widget.startWeekWithSunday,
                          weekDaysToHide: widget.weekdaysToHide,
                          isChecked: widget.isChecked,
                          dateList: widget.dateList);
                    },
                  ),
                ),
              ),
            SliverPadding(
              key: downListKey,
              padding: _getDownListPadding(),
              sliver: PagedSliverList(
                pagingController: _pagingReplyDownController,
                builderDelegate: PagedChildBuilderDelegate<Month>(
                  itemBuilder: (BuildContext context, Month month, int index) {
                    return _MonthView(
                        month: month,
                        monthBuilder: widget.monthBuilder,
                        dayBuilder: widget.dayBuilder,
                        onDayPressed: widget.onDayPressed,
                        startWeekWithSunday: widget.startWeekWithSunday,
                        weekDaysToHide: widget.weekdaysToHide,
                        isChecked: widget.isChecked,
                        dateList: widget.dateList);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}

class _MonthView extends StatefulWidget {
  const _MonthView({
    required this.month,
    this.monthBuilder,
    this.dayBuilder,
    this.onDayPressed,
    required this.weekDaysToHide,
    required this.startWeekWithSunday,
    required this.isChecked,
    required this.dateList,
  });

  final Month month;
  final MonthBuilder? monthBuilder;
  final DayBuilder? dayBuilder;
  final ValueChanged<DateTime>? onDayPressed;
  final bool startWeekWithSunday;
  final List<int> weekDaysToHide;

  final dynamic isChecked;
  final dynamic dateList;

  @override
  State<_MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<_MonthView> {
  List<int> selectedIndices = [];
  late HomeViewModel mViewModel;
  List<String> weekDay = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
// State variable to hold checkbox status
  int ItemIndex = -1; // State variable to hold checkbox status
  DateTime ovulationDate = DateTime(2020, 1, 1);

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    final validDates =
        DateUtils.listOfValidDatesInMonth(widget.month, widget.weekDaysToHide);
    final blankSpaces = DateUtils.getNoOfSpaceRequiredBeforeFirstValidDate(
      widget.weekDaysToHide,
      validDates.isNotEmpty ? validDates.first.weekday : 0,
      widget.startWeekWithSunday,
    );

    return Column(
      children: <Widget>[
        widget.monthBuilder
                ?.call(context, widget.month.month, widget.month.year) ??
            _DefaultMonthView(
              month: widget.month.month,
              year: widget.month.year,
            ),
        Container(
          color: Color(0xFFFCF7FF),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              weekDay.length,
              (index) => Flexible(
                child: Text(
                  weekDay[index],
                  style: const TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        GridView.builder(
          addRepaintBoundaries: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: DateTime.daysPerWeek - widget.weekDaysToHide.length,
          ),
          itemCount: validDates.length + blankSpaces,
          itemBuilder: (BuildContext context, int index) {
            if (index < blankSpaces) return const SizedBox();

            final date = validDates[index - blankSpaces];

            bool isSelected = false;
            bool isPredictedDate = false;
            // mViewModel.nextCycleDates.contains(date);
            bool isOvulation =
                false; //mViewModel.ovulationDates.contains(date);
            bool isFirtile = false; //mViewModel.firtileDates.contains(date);
            DateTime now = DateTime.now();
            // DateTime isStartDate = DateTime.now();
            // peroidCustomeList
            if (peroidCustomeList.isEmpty) {
              isSelected = mViewModel.nextCycleDates.contains(date);
              isOvulation = mViewModel.ovulationDates.contains(date);
              isFirtile = mViewModel.firtileDates.contains(date);
            } else {
              List<DateTime> fertileDates = [];
              List<DateTime> ovulationDates = [];
              List<DateTime> loggedPeriodDates = [];
              List<DateTime> predictedPeriodDates = [];

              peroidCustomeList.forEach((element) {
                element.periodData.forEach((periodDates) {
                  for (DateTime start =
                          DateTime.parse(periodDates.periodStartDate);
                      start.isSameDayOrBefore(
                          DateTime.parse(periodDates.periodEndDate));
                      start = start.add(Duration(days: 1))) {
                    loggedPeriodDates.add(start);
                  }
                });

                element.predictions.forEach((predictions) {
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

// Checking if the given `date` falls in the calculated dates
              if (loggedPeriodDates.contains(date)) {
                isSelected = true;
              }

              if (predictedPeriodDates.contains(date)) {
                isPredictedDate = true;
              }

              if (fertileDates.contains(date)) {
                isFirtile = true;
              }
              ovulationDates.removeAt(ovulationDates.length - 1);
              if (ovulationDates.contains(date)) {
                if (date.year < date.year + 1) {
                  isOvulation = true;
                }
              }
            }

            List<int> months = [];
            for (int i = 1; i <= 3; i++) {
              DateTime monthDate = DateTime(now.year, now.month - i);

              // Adjust for the year if the month is less than 1
              if (monthDate.month < 1) {
                monthDate = DateTime(monthDate.year - 1, 12);
              }

              months.add(monthDate.month);
            }
            if (!months.contains(now.month)) {
              months.add(now.month);
            }
            bool currentDateCheck = false;

            // debugPrint('dateList: ${widget.dateList}');
            // debugPrint('dateList Date: $date');

            if (widget.dateList?.contains(date)) {
              currentDateCheck = true;
            }

            return AspectRatio(
              aspectRatio: 1.0,
              child: InkWell(
                child: widget.dayBuilder?.call(context, date) ??
                    Center(
                      child: widget.isChecked &&
                              months.contains(date.month) &&
                              (date.isBefore(now) || date.isAtSameMomentAs(now))
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.dateList.contains(date)) {
                                    widget.dateList.remove(date);
                                  } else {
                                    widget.dateList.add(date);
                                  }
                                  widget.onDayPressed!(date);
                                });
                              },
                              child: Container(
                                height: 70,
                                width: 70.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the content vertically
                                  children: [
                                    Text(
                                      date.day.toString(),
                                      style: getAppStyle(
                                        fontSize: 15,
                                        color: CommonColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25, // Width of the circle
                                      height: 25, // Height of the circle
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentDateCheck =
                                                !currentDateCheck; // Toggle the checkbox state
                                            if (currentDateCheck) {
                                              if (!widget.dateList
                                                  .contains(date)) {
                                                widget.dateList.add(
                                                    date); // Add date when checked
                                              }
                                            } else {
                                              widget.dateList.remove(
                                                  date); // Remove date when unchecked
                                            }
                                            widget.onDayPressed!(
                                                date); // Callback when the day is pressed
                                          });
                                        },
                                        child: DottedBorder(
                                          color: isPredictedDate
                                              ? Colors.red
                                              : Colors.transparent,
                                          dashPattern: [4, 3],
                                          strokeWidth:
                                              (isFirtile || isPredictedDate)
                                                  ? 2
                                                  : 0,
                                          borderType: BorderType.Circle,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // Makes the container circular
                                              color: currentDateCheck
                                                  ? CommonColors
                                                      .secondaryColor // Background color when checked
                                                  : Colors.transparent,
                                              // Transparent when unchecked
                                              border: Border.all(
                                                color: currentDateCheck
                                                    ? CommonColors
                                                        .secondaryColor // Border color when checked
                                                    : Colors.grey,
                                                // Border color when unchecked
                                                width: 2, // Border width
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: currentDateCheck
                                                ? Icon(
                                                    Icons.check,
                                                    // Display checkmark icon when checked
                                                    color: Colors
                                                        .white, // Color of the checkmark
                                                    size: 20, // Icon size
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 40,
                              width: 40.0,
                              // padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? null
                                    : isOvulation
                                        ? null
                                        : isFirtile
                                            ? null
                                            : Colors.transparent,
                                gradient: isSelected
                                    ? LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFFF9D93),
                                          Color(0xFFFFB5AE),
                                        ],
                                      )
                                    : isOvulation
                                        ? mViewModel.getGradientGreen()
                                        : isPredictedDate
                                            ? LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFFFFFFFF),
                                                  Color(0xFFFFFFFF),
                                                ],
                                              )
                                            : null,
                                // color: isSelected ? CommonColors.primaryColor : CommonColors.mTransparent,
                                shape: BoxShape.circle,
                              ),
                              child: DottedBorder(
                                color: isFirtile
                                    ? CommonColors.greenColor
                                    : isPredictedDate
                                        ? CommonColors.mRed
                                        : CommonColors.mTransparent,
                                dashPattern: [4, 3],
                                strokeWidth:
                                    (isFirtile || isPredictedDate) ? 2 : 0,
                                borderType: BorderType.Circle,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      print(date);
                                    },
                                    child: Text(
                                      date.day.toString(),
                                      style: getAppStyle(
                                        fontSize: 15,
                                        color: isSelected
                                            ? CommonColors.mWhite
                                            : isOvulation
                                                ? CommonColors.mWhite
                                                : CommonColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
              ),
            );
          },
        ),
        const SizedBox(height: 10.0),
        // ElevatedButton(
        //   onPressed: () {
        //     _updateButtonText();

        //     // Add your onPressed code here!
        //   },
        //   child: widget.isChecked ? Text('Update') : Text('Edit'),
        // ),
        Divider(
          color: CommonColors.mGrey.withOpacity(.3),
          thickness: 2,
        ),
      ],
    );
  }
}

class _DefaultMonthView extends StatelessWidget {
  final int month;
  final int year;

  _DefaultMonthView({required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        '${S.of(context)?.months[month - 1]} $year',
        style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

typedef MonthBuilder = Widget Function(
    BuildContext context, int month, int year);
typedef DayBuilder = Widget Function(BuildContext context, DateTime date);

typedef OnMonthLoaded = void Function(int year, int month);

List<Map<String, String>> groupedDates = [];

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

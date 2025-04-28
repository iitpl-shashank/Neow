// import 'package:flutter/material.dart';
// import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/screen_sizes.dart';
// import 'package:naveli_2023/utils/constant.dart';
// import 'package:provider/provider.dart';
// import '../../../../utils/common_colors.dart';
// import '../../../../utils/common_utils.dart';
// import '../../home/home_view_model.dart';
// import 'day_number.dart';
//
// class YearView extends StatelessWidget {
//   const YearView({
//     required this.context,
//     required this.year,
//     required this.currentDateColor,
//     this.highlightedDates,
//     this.highlightedDateColor,
//     this.monthNames,
//     this.onMonthTap,
//     this.monthTitleStyle,
//   });
//
//   final BuildContext context;
//   final int year;
//   final Color currentDateColor;
//   final List<DateTime>? highlightedDates;
//   final Color? highlightedDateColor;
//   final List<String>? monthNames;
//   final Function? onMonthTap;
//   final TextStyle? monthTitleStyle;
//
//   double get horizontalMargin => 16.0;
//
//   double get monthViewPadding => 8.0;
//
//   Widget buildYearMonths(BuildContext context) {
//     final List<Row> monthRows = <Row>[];
//     final List<MonthView> monthRowChildren = <MonthView>[];
//
//     for (int month = 1; month <= DateTime.monthsPerYear; month++) {
//       monthRowChildren.add(
//         MonthView(
//           context: context,
//           year: year,
//           month: month,
//           padding: monthViewPadding,
//           currentDateColor: currentDateColor,
//           highlightedDates: highlightedDates,
//           highlightedDateColor: highlightedDateColor,
//           monthNames: monthNames,
//           onTap: onMonthTap,
//           titleStyle: monthTitleStyle,
//         ),
//       );
//
//       if (month % 3 == 0) {
//         monthRows.add(
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List<MonthView>.from(monthRowChildren),
//           ),
//         );
//         monthRowChildren.clear();
//       }
//     }
//
//     return Column(
//       children: List<Row>.from(monthRows),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: kDeviceHeight,
//       padding: const EdgeInsets.only(top: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: horizontalMargin,
//               vertical: 0.0,
//             ),
//             child: Text(
//               year.toString(),
//               style: getAppStyle(
//                 fontSize: screenSize(context) == ScreenSizes.small ? 22.0 : 26.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(
//               left: horizontalMargin,
//               right: horizontalMargin,
//               top: 8.0,
//             ),
//             child: Divider(
//               color: Colors.black26,
//             ),
//           ),
//           Container(
//             // color: CommonColors.greenColor,
//             // margin: EdgeInsets.symmetric(
//             //   horizontal: horizontalMargin - monthViewPadding,
//             //   vertical: 0.0,
//             // ),
//             child: buildYearMonths(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MonthView extends StatelessWidget {
//    MonthView({
//     required this.context,
//     required this.year,
//     required this.month,
//     required this.padding,
//     required this.currentDateColor,
//     this.highlightedDates,
//     this.highlightedDateColor,
//     this.monthNames,
//     this.onTap,
//     this.titleStyle,
//   });
//
//   final BuildContext context;
//   final int year;
//   final int month;
//   final double padding;
//   final Color currentDateColor;
//   final List<DateTime>? highlightedDates;
//   final Color? highlightedDateColor;
//   final List<String>? monthNames;
//   final Function? onTap;
//   final TextStyle? titleStyle;
//
//   Color getDayNumberColor(DateTime date) {
//     Color color;
//     if (isCurrentDate(date)) {
//       color = CommonColors.greenColor;
//     } else if (highlightedDates != null &&
//         isHighlightedDate(date, highlightedDates!)) {
//       color = highlightedDateColor!;
//     }
//     return CommonColors.primaryColor;
//   }
//   late HomeViewModel mViewModel;
//
//
//   Widget buildMonthDays(BuildContext context) {
//     mViewModel = Provider.of<HomeViewModel>(context);
//     final List<Row> dayRows = <Row>[];
//     final List<DayNumber> dayRowChildren = <DayNumber>[];
//
//     final int daysInMonth = getDaysInMonth(year, month);
//     final int firstWeekdayOfMonth = DateTime(year, month, 1).weekday;
//
//     for (int day = 2 - firstWeekdayOfMonth; day <= daysInMonth; day++) {
//       Color color;
//       if (day > 0) {
//         color = getDayNumberColor(DateTime(year, month, day));
//       }
//
//       dayRowChildren.add(
//         DayNumber(
//           day: day,
//         ),
//       );
//
//
//       if ((day - 1 + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 ||
//           day == daysInMonth) {
//         dayRows.add(
//           Row(
//             children: List<DayNumber>.from(dayRowChildren),
//           ),
//         );
//         dayRowChildren.clear();
//       }
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: dayRows,
//     );
//   }
//
//   Widget buildMonthView(BuildContext context) {
//     return Container(
//       width: 7 * getDayNumberSize(context),
//       margin: EdgeInsets.all(padding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             getMonthName(month),
//             style: getAppStyle(
//               color: CommonColors.primaryColor
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.fade,
//             softWrap: false,
//           ),
//           Container(
//             // color: CommonColors.mRed,
//             margin: const EdgeInsets.only(top: 8.0),
//             child: buildMonthDays(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return onTap == null
//         ? Container(
//             child: buildMonthView(context),
//           )
//         : ElevatedButton(
//             onPressed: () => onTap!(year, month),
//             child: buildMonthView(context),
//           );
//   }
// }

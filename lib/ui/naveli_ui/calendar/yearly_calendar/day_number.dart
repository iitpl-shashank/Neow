// import 'package:flutter/material.dart';
// import 'package:naveli_2023/ui/naveli_ui/calendar/yearly_calendar/screen_sizes.dart';
// import 'package:naveli_2023/utils/common_colors.dart';
// import 'package:naveli_2023/utils/constant.dart';
//
// class DayNumber extends StatefulWidget {
//   const DayNumber({
//     super.key,
//     required this.day,
//   });
//
//   final int day;
//
//   @override
//   State<DayNumber> createState() => _DayNumberState();
// }
//
// class _DayNumberState extends State<DayNumber> {
//   List<int> selectedInt = [];
//
//   @override
//   Widget build(BuildContext context) {
//     final double size = getDayNumberSize(context);
//
//     return InkWell(
//       onTap: () {
//         // setState(() {
//         //   if (widget.day >= 1) {
//         //     if (selectedInt.contains(widget.day)) {
//         //       selectedInt.remove(widget.day);
//         //     } else {
//         //       selectedInt.add(widget.day);
//         //     }
//         //   }
//         // });
//       },
//       child: Container(
//         width: size,
//         height: size,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(size / 2),
//             color: selectedInt.contains(widget.day)
//                 ? CommonColors.A43786
//                 : CommonColors.mTransparent),
//         child: Text(
//           widget.day < 1 ? '' : widget.day.toString(),
//           textAlign: TextAlign.center,
//           style: getAppStyle(
//             color: selectedInt.contains(widget.day)
//                 ? CommonColors.mWhite
//                 : CommonColors.black54,
//             fontSize: screenSize(context) == ScreenSizes.small ? 8.0 : 9.0,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
// }

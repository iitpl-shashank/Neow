// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:naveli_2023/utils/common_colors.dart';
// import 'package:naveli_2023/utils/local_images.dart';
// import 'package:naveli_2023/widgets/scaffold_bg.dart';
//
// import '../../../../../generated/i18n.dart';
// import '../../../../../utils/constant.dart';
// import '../../../../../widgets/common_appbar.dart';
// import '../../../../../widgets/common_text.dart';
//
// class CalculateBmi extends StatefulWidget {
//   final String score;
//   final String category;
//   final String gender;
//   final String age;
//   final String weight;
//   final String height;
//   final String dropdownValueHeight;
//   final String dropdownValueWeight;
//
//   const CalculateBmi(
//       {super.key,
//       required this.score,
//       required this.category,
//       required this.gender,
//       required this.age,
//       required this.weight,
//       required this.height,
//       required this.dropdownValueHeight,
//       required this.dropdownValueWeight});
//
//   @override
//   State<CalculateBmi> createState() => _CalculateBmiState();
// }
//
// class _CalculateBmiState extends State<CalculateBmi> {
//   Color getColorForCategory(String category) {
//     switch (category) {
//       case "Severely Underweight":
//       case "Underweight":
//         return CommonColors.mRed.withOpacity(0.5);
//       case "Normal Weight":
//         return CommonColors.darkGreenColor;
//       case "Overweight":
//         return CommonColors.darkYellow;
//       case "Obese":
//         return CommonColors.mRed;
//       default:
//         return CommonColors.mGrey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color categoryColor = getColorForCategory(widget.category);
//     return ScaffoldBG(
//       child: Scaffold(
//         backgroundColor: CommonColors.mTransparent,
//         appBar: CommonAppBar(
//           title: S.of(context)!.bmiScore,
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Text(
//                 //   S.of(context)!.bmiScore,
//                 //   style: getAppStyle(
//                 //     color: CommonColors.mGrey,
//                 //     fontSize: 25,
//                 //     fontWeight: FontWeight.w500,
//                 //   ),
//                 // ),
//                 // kCommonSpaceV20,
//                 Container(
//                     width: 100,
//                     height: 100,
//                     decoration: ShapeDecoration(
//                       color: CommonColors.mWhite,
//                       shape: OvalBorder(
//                         side: BorderSide(width: 1, color: categoryColor),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         widget.score,
//                         style: getAppStyle(
//                           color: categoryColor,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     )),
//                 kCommonSpaceV15,
//                 Text(
//                   widget.category,
//                   style: getAppStyle(
//                     color: categoryColor,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w500,
//                     height: 0.04,
//                   ),
//                 ),
//                 kCommonSpaceV30,
//                 Stack(
//                   children: [
//                     Container(
//                       width: 390,
//                       height: 155,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFFEAE0EB).withOpacity(0.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         // shadows: [
//                         //   BoxShadow(
//                         //     color: Color(0x3F000000),
//                         //     blurRadius: 4,
//                         //     offset: Offset(0, 4),
//                         //     spreadRadius: 0,
//                         //   )
//                         // ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomTextWidget(
//                                 title: S.of(context)!.gender,
//                                 value: widget.gender),
//                             CustomTextWidget(
//                                 title: S.of(context)!.age,
//                                 value: '${widget.age} Year'),
//                             CustomTextWidget(
//                                 title: S.of(context)!.weight,
//                                 value:
//                                     '${widget.weight + ' ${widget.dropdownValueWeight}'}'),
//                             CustomTextWidget(
//                                 title: S.of(context)!.height,
//                                 value:
//                                     '${widget.height + ' ${widget.dropdownValueHeight}'}'),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Positioned(
//                     //   top: 10,
//                     //   right: 10,
//                     //   child: SvgPicture.asset(LocalImages.icon_edit)
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_text.dart';

class CalculateBmi extends StatelessWidget {
  final double bmiScore;

  final int age;

  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  final String gender;
  final String weight;
  final String height;
  final String dropdownValueHeight;
  final String dropdownValueWeight;

  CalculateBmi(
      {super.key,
      required this.bmiScore,
      required this.age,
      required this.gender,
      required this.weight,
      required this.height,
      required this.dropdownValueHeight,
      required this.dropdownValueWeight});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.bmiScore,
        ),
        body: Center(
          child: Padding(
            padding: kCommonScreenPadding,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: kDeviceWidth / 1.2,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: CommonColors.mGrey300),
                  // shadows: [
                  //   BoxShadow(
                  //     color: Color(0x3F000000),
                  //     blurRadius: 4,
                  //     offset: Offset(0, 4),
                  //     spreadRadius: 0,
                  //   )
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrettyGauge(
                      gaugeSize: 250,
                      minValue: 0,
                      maxValue: 40,
                      segments: [
                        GaugeSegment('UnderWeight', 18.5, Colors.red),
                        GaugeSegment('Normal', 6.4, Colors.green),
                        GaugeSegment('OverWeight', 5, Colors.orange),
                        GaugeSegment('Obese', 10.1, Colors.pink),
                      ],
                      valueWidget: Text(
                        bmiScore.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 40),
                      ),
                      currentValue: bmiScore.toDouble(),
                      needleColor: Colors.blue,
                    ),
                    kCommonSpaceV10,
                    Container(
                      width: kDeviceWidth / 1.6,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF8F7FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          kCommonSpaceV20,
                          Text(
                            bmiStatus!,
                            style: TextStyle(
                                fontSize: 22,
                                color: CommonColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          kCommonSpaceV10,
                          Text(
                            bmiInterpretation!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: CommonColors.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          kCommonSpaceV20,
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          kCommonSpaceV20,
                          CustomTextWidget(
                              title: S.of(context)!.gender, value: gender),
                          CustomTextWidget(
                              title: S.of(context)!.age, value: '$age Year'),
                          CustomTextWidget(
                              title: S.of(context)!.weight,
                              value: '$weight $dropdownValueWeight'),
                          CustomTextWidget(
                              title: S.of(context)!.height,
                              value: '$height $dropdownValueHeight'),
                          kCommonSpaceV20,
                        ],
                      ),
                    ),

                    /* Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                        ],
                      ),
                    ), */
                  ],
                ),
              ),

              kCommonSpaceV30,
              Container(
                width: kDeviceWidth / 1.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: CommonColors.mGrey300),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextWidget(title: 'Underweight', value: '< 18.5'),
                      CustomTextWidget(title: 'Healthy', value: '18.5 - 24.9'),
                      CustomTextWidget(title: 'Overweight', value: '25 - 29.9'),
                      CustomTextWidget(title: 'Obese', value: '30 - 34.9'),
                      CustomTextWidget(
                          title: 'Highly Obese', value: '35 - 39.9'),
                      CustomTextWidget(title: 'Extremely Obese', value: '>40'),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: const Text("Re-calculate"))
            ]),
          ),
        ),
      ),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Healthy";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}

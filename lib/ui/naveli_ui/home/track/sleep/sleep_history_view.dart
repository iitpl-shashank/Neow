import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/calendar_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view_model.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/primary_button.dart';

class SleeptHistoryView extends StatefulWidget {
  const SleeptHistoryView({super.key});

  @override
  State<SleeptHistoryView> createState() => _SleeptHistoryViewState();
}

class _SleeptHistoryViewState extends State<SleeptHistoryView> {
  // int kg = 20;
  // int gm = 0;
  // late WeightViewModel mViewModel;
  late SleepViewModel mViewModel; //fetchSleepData;

  List<String> msr = ['Kg', 'lb'];
  String selectedWeight = '';
  String selectedWeight1 = '';
  String selectedMeasure = '';
  bool isAddWight = false;

  // void updateWeightText() {
  //   setState(() {
  //     if (kg == 20 && gm == 0) {
  //       weightText = 'Select your weight';
  //     } else if (kg >= 20 && gm == 0) {
  //       weightText = '$kg kg';
  //     } else if (kg == 20 && gm > 0) {
  //       weightText = '$gm gm';
  //     } else {
  //       weightText = '$kg . $gm Kg';
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // CommonUtils.showProgressDialog();
      mViewModel.fetchSleepData();

      setState(() {
        mViewModel.fetchSleepData() as List;
        CommonUtils.hideProgressDialog();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SleepViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.sleep,
          actions: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  isAddWight = !isAddWight;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 15,
                    color: CommonColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /* Text(
                S.of(context)!.trackYourWeight,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: getAppStyle(
                  color: CommonColors.black87,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ), 
              kCommonSpaceV10,*/

              for (int index = 0;
                  index < mViewModel.sleeptHistory.length;
                  index++)
                _weight_bmi(context, mViewModel.sleeptHistory[index])

              // !isAddWight
              //     ? _weight_bmi(
              //         context,
              //         'Number of weight entries: ${sleeptHistory.length.toString()}',
              //         'Thyroid prescription.jpg',
              //         LocalImages.view,
              //         LocalImages.download,
              //         '',
              //         '')

              /* Text(
                mViewModel.selectedWeightValue + mViewModel.selectedWeightType,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: getAppStyle(
                  color: CommonColors.black87,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ), */
              /* Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: CommonColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedIndex = 1;
                          mViewModel.selectedWeightType = "Kg";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.selectedIndex == 1
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            S.of(context)!.kg,
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.selectedIndex == 1
                                    ? CommonColors.mWhite
                                    : CommonColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mViewModel.selectedIndex = 2;
                          mViewModel.selectedWeightType = "Lbs";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.selectedIndex == 2
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            S.of(context)!.lbs,
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.selectedIndex == 2
                                    ? CommonColors.mWhite
                                    : CommonColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kCommonSpaceV20, 
              Text(
                S.of(context)!.selectYourWeight,
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),*/
              // TextButton(
              //   // onPressed: () {
              //   //   showModalBottomSheet(
              //   //     backgroundColor: CommonColors.primaryLite,
              //   //     context: context,
              //   //     builder: (context) {
              //   //       return StatefulBuilder(builder:
              //   //           (BuildContext context, StateSetter setState) {
              //   //         return SizedBox(
              //   //           height: 245,
              //   //           width: double.infinity,
              //   //           child: Column(
              //   //             children: <Widget>[
              //   //               // Row(
              //   //               //   mainAxisAlignment: MainAxisAlignment.center,
              //   //               //   // Center the children horizontally
              //   //               //   children: [
              //   //               //     Padding(
              //   //               //       padding: const EdgeInsets.all(12.0),
              //   //               //       child: SizedBox(
              //   //               //         height: 25,
              //   //               //         width: 25,
              //   //               //         child: IconButton(
              //   //               //           style: IconButton.styleFrom(
              //   //               //               backgroundColor:
              //   //               //                   CommonColors.mRed,
              //   //               //               foregroundColor:
              //   //               //                   CommonColors.mWhite),
              //   //               //           padding: EdgeInsets.zero,
              //   //               //           icon: Icon(
              //   //               //             Icons.clear,
              //   //               //             size: 20,
              //   //               //           ),
              //   //               //           onPressed: () {
              //   //               //             Navigator.pop(context);
              //   //               //           },
              //   //               //         ),
              //   //               //       ),
              //   //               //     ),
              //   //               //     Spacer(),
              //   //               //     Text(
              //   //               //       S.of(context)!.logYourWeight,
              //   //               //       style: getAppStyle(
              //   //               //         color: CommonColors.blackColor,
              //   //               //         fontSize: 20,
              //   //               //         fontWeight: FontWeight.w500,
              //   //               //       ),
              //   //               //     ),
              //   //               //     Spacer(),
              //   //               //   ],
              //   //               // ),
              //   //               Align(
              //   //                 alignment: Alignment.topLeft,
              //   //                 child: Padding(
              //   //                   padding: const EdgeInsets.all(8.0),
              //   //                   child: SizedBox(
              //   //                     height: 25,
              //   //                     width: 25,
              //   //                     child: IconButton(
              //   //                       style: IconButton.styleFrom(
              //   //                           backgroundColor:
              //   //                               CommonColors.mRed,
              //   //                           foregroundColor:
              //   //                               CommonColors.mWhite),
              //   //                       padding: EdgeInsets.zero,
              //   //                       icon: Icon(
              //   //                         Icons.clear,
              //   //                         size: 20,
              //   //                       ),
              //   //                       onPressed: () {
              //   //                         setState(() {
              //   //                           kg = 20;
              //   //                           gm = 0;
              //   //                         });
              //   //                         Navigator.pop(context);
              //   //                       },
              //   //                     ),
              //   //                   ),
              //   //                 ),
              //   //               ),
              //   //               kCommonSpaceV20,
              //   //               Row(
              //   //                 mainAxisAlignment:
              //   //                     MainAxisAlignment.center,
              //   //                 children: [
              //   //                   NumberPicker(
              //   //                     minValue: 20,
              //   //                     maxValue: 130,
              //   //                     value: kg,
              //   //                     zeroPad: false,
              //   //                     infiniteLoop: true,
              //   //                     itemWidth: 50,
              //   //                     itemHeight: 40,
              //   //                     onChanged: (value) {
              //   //                       setState(() {
              //   //                         kg = value;
              //   //                         updateWeightText();
              //   //                       });
              //   //                     },
              //   //                     textStyle: getAppStyle(
              //   //                         color: CommonColors.mWhite,
              //   //                         fontSize: 20),
              //   //                     selectedTextStyle: getAppStyle(
              //   //                         color: CommonColors.primaryColor,
              //   //                         fontSize: 25),
              //   //                     decoration: const BoxDecoration(
              //   //                       border: Border(
              //   //                           top: BorderSide(
              //   //                             width: 2,
              //   //                             color:
              //   //                                 CommonColors.primaryColor,
              //   //                           ),
              //   //                           bottom: BorderSide(
              //   //                               width: 2,
              //   //                               color: CommonColors
              //   //                                   .primaryColor)),
              //   //                     ),
              //   //                   ),
              //   //                   kCommonSpaceH15,
              //   //                   Text(
              //   //                     '.',
              //   //                     style: getAppStyle(
              //   //                         fontSize: 30,
              //   //                         color: CommonColors.blackColor),
              //   //                   ),
              //   //                   kCommonSpaceH15,
              //   //                   NumberPicker(
              //   //                     minValue: 0,
              //   //                     maxValue: 10,
              //   //                     value: gm,
              //   //                     zeroPad: false,
              //   //                     infiniteLoop: true,
              //   //                     itemWidth: 50,
              //   //                     itemHeight: 40,
              //   //                     onChanged: (value) {
              //   //                       setState(() {
              //   //                         gm = value;
              //   //                         updateWeightText();
              //   //                       });
              //   //                     },
              //   //                     textStyle: getAppStyle(
              //   //                         color: CommonColors.mWhite,
              //   //                         fontSize: 20),
              //   //                     selectedTextStyle: getAppStyle(
              //   //                         color: CommonColors.primaryColor,
              //   //                         fontSize: 25),
              //   //                     decoration: const BoxDecoration(
              //   //                       border: Border(
              //   //                           top: BorderSide(
              //   //                             width: 2,
              //   //                             color:
              //   //                                 CommonColors.primaryColor,
              //   //                           ),
              //   //                           bottom: BorderSide(
              //   //                               width: 2,
              //   //                               color: CommonColors
              //   //                                   .primaryColor)),
              //   //                     ),
              //   //                   ),
              //   //                   kCommonSpaceH15,
              //   //                   Text(
              //   //                     S.of(context)!.kg,
              //   //                     style: getAppStyle(
              //   //                       color: CommonColors.primaryColor,
              //   //                       fontSize: 20,
              //   //                       fontWeight: FontWeight.w500,
              //   //                     ),
              //   //                   )
              //   //                 ],
              //   //               ),
              //   //               Align(
              //   //                 alignment: Alignment.bottomRight,
              //   //                 child: Padding(
              //   //                   padding: const EdgeInsets.all(8.0),
              //   //                   child: SizedBox(
              //   //                     height: 30,
              //   //                     child: ElevatedButton(
              //   //                       onPressed: () {
              //   //                         Navigator.pop(context);
              //   //                       },
              //   //                       child: Text(
              //   //                         'OK',
              //   //                         style: getAppStyle(
              //   //                             color:
              //   //                                 CommonColors.blackColor),
              //   //                       ),
              //   //                       style: ElevatedButton.styleFrom(
              //   //                         // shape: StadiumBorder(),
              //   //                         backgroundColor:
              //   //                             CommonColors.mWhite,
              //   //                         side: const BorderSide(
              //   //                           width: 1.0,
              //   //                           color: CommonColors.blackColor,
              //   //                         ),
              //   //                       ),
              //   //                     ),
              //   //                   ),
              //   //                 ),
              //   //               ),
              //   //             ],
              //   //           ),
              //   //         );
              //   //       });
              //   //     },
              //   //   );
              //   // },
              //   child: Text(
              //     weightText,
              //     style: getAppStyle(
              //       color: CommonColors.mGrey,
              //       fontSize: 25,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // kCommonSpaceV20,

              /* AnimatedWeightPicker(
                min: 20,
                max: 150,
                selectedValueColor: CommonColors.primaryColor,
                majorIntervalTextColor: CommonColors.primaryColor,
                dialColor: CommonColors.primaryColor,
                subIntervalColor: CommonColors.primaryColor,
                majorIntervalColor: CommonColors.primaryColor,
                showSuffix: false,
                onChange: (newValue) {
                  setState(() {
                    mViewModel.selectedWeightValue = newValue;
                  });
                },
              ), */
              // kCommonSpaceV20,
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    return true;
  }
}

Widget _weight_bmi(context, item) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            // height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: CommonColors.mWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)), // Border radius for all edges
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                SizedBox(width: 5), // Space between the dot and text
                Expanded(
                    child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Center the content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        item['month'],
                        textAlign: TextAlign.left,
                        style: getAppStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Evenly space between items
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [],
                      ),
                    ),
                    for (int inx = 0; inx < item['data'].length; inx++)
                      _bmiValue(
                          context,
                          item['data'][inx],
                          '${item['data'][inx]['total_sleep_time'] ?? "Empty"}',
                          item['data'][inx]['date'],
                          '18'),
                  ],
                )),
              ],
            ),
          ),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Widget _bmiValue(context, item, String text, String info, String value) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 10, top: 0, bottom: 0),
          child: Container(
              clipBehavior: Clip.antiAlias,
              height: 60,
              // width: MediaQuery.of(context).size.width - 5,
              decoration: ShapeDecoration(
                color: CommonColors.mWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)), // Border radius for all edges
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Center the content
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center vertically
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 111, 64, 133),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          info,
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 102, 100, 100),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        spleepTime(text),
                      ],
                    ), // Space between the dot and text
                  ],
                ),
              )),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Image spleepTime(input) {
  // Regular expression to match hours
  RegExp hourRegExp = RegExp(r'(\d+)Hr');

  // Match the hours
  Match? hourMatch = hourRegExp.firstMatch(input);

  if (hourMatch != null) {
    // Extract and print the hours
    String hourStr = hourMatch.group(1)!;

    int hours = int.parse(hourStr);
    if (hours >= 8) {
      return Image.asset(
        LocalImages.vector,
        fit: BoxFit.contain,
        height: 25,
      );
    } else {
      return Image.asset(
        LocalImages.triangle,
        fit: BoxFit.contain,
        height: 25,
      );
    }
  } else {
    return Image.asset(
      LocalImages.triangle,
      fit: BoxFit.contain,
      height: 30,
    );
  }
}

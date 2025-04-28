import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_history_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/primary_button.dart';

class WeightView extends StatefulWidget {
  const WeightView({super.key});

  @override
  State<WeightView> createState() => _WeightViewState();
}

class _WeightViewState extends State<WeightView> {
  // int kg = 20;
  // int gm = 0;
  late WeightViewModel mViewModel;
  List<String> msr = ['Kg', 'lb'];
  String selectedWeight = '';
  String selectedWeight1 = '';
  String selectedMeasure = '';

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
      mViewModel.getWeightDetailApi();
      mViewModel.fetchWeightData();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WeightViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.weight,
          actions: <Widget>[
            InkWell(
              onTap: () {
                // push(CalendarView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TextButton(
                  onPressed: () {
                    push(const WeightHistoryView());
                  },
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontSize: 15,
                      color: CommonColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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
              Image.asset(
                LocalImages.img_weight,
                fit: BoxFit.contain,
                height: kDeviceHeight / 3,
              ),
              kCommonSpaceV20,
              Container(
                width: kDeviceWidth / 1.2,
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
                      "${mViewModel.selectedWeightValue} ${mViewModel.selectedWeightType}",
                      style: TextStyle(
                          fontSize: 18,
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    kCommonSpaceV20,
                  ],
                ),
              ),
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
              SizedBox(
                height: kDeviceHeight / 2.7,
                child: Row(
                  children: [
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        diameterRatio: .8,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.004,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedWeight = (value + 1).toString();
                            mViewModel.selectedWeightValue =
                                '$selectedWeight.$selectedWeight1 ';
                            mViewModel.selectedWeightType = selectedMeasure;
                          });
                        },
                        children: List.generate(
                          150,
                          (index) => Container(
                            height: 40,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: CommonColors.mWhite,
                              // shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${index + 1}",
                              style: getAppStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.blackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        diameterRatio: .8,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.004,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedWeight1 = (value).toString();
                            mViewModel.selectedWeightValue =
                                '$selectedWeight.$selectedWeight1 ';
                            mViewModel.selectedWeightType = selectedMeasure;
                          });
                        },
                        children: List.generate(
                          11,
                          (index) => Container(
                            height: 40,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: CommonColors.mWhite,
                              // shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${index}",
                              style: getAppStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.blackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 40,
                        diameterRatio: .8,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.004,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedMeasure =
                                msr[value]; //(value + 1).toString();
                            mViewModel.selectedWeightValue =
                                '$selectedWeight.$selectedWeight1 ';
                            mViewModel.selectedWeightType = selectedMeasure;
                          });
                        },
                        children: List.generate(
                          msr.length,
                          (index) => Container(
                            height: 40,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: CommonColors.mWhite,
                              // shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              msr[index],
                              style: getAppStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.blackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  label: S.of(context)!.apply,
                  buttonColor: CommonColors.primaryColor,
                  onPress: () {
                    if (isValid()) {
                      // String cleanedWeightText = selectedWeightValue.replaceAll(RegExp(r'[^\d.]'), '').trim();
                      setState(() {
                        mViewModel.storeWeightHistory(
                            weight: mViewModel.selectedWeightValue,
                            weightType: mViewModel.selectedWeightType);
                        mViewModel.storeUserWeightApi(
                            weight: mViewModel.selectedWeightValue,
                            weightType: mViewModel.selectedWeightType);
                      });
                    } else {
                      print(
                          "else   =====================================================");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (mViewModel.selectedWeightValue == "") {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectWeight,
        color: CommonColors.mRed,
      );
      return false;
    } else if (mViewModel.selectedWeightType == 0) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectWeightType,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

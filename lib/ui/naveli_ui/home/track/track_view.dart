import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/water_reminder/water_reminder_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/global_variables.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import 'ailments/ailments_view.dart';
import 'bmi_calculator/bmi_calculator_view.dart';
import 'medication/medication_view.dart';

class TrackView extends StatefulWidget {
  const TrackView({super.key});

  @override
  State<TrackView> createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  final List<Map<String, dynamic>> dataList = [
    {
      'image': LocalImages.img_medication,
      'text': S.of(mainNavKey.currentContext!)!.medication,
      'hint': 'Manage and track your \nhealth conditions.',
    },
    {
      'image': LocalImages.img_weight,
      'text': S.of(mainNavKey.currentContext!)!.weight,
      'hint': 'Record and track your \nweight over time.',
    },
    {
      'image': LocalImages.img_bmi_calculator,
      'text': S.of(mainNavKey.currentContext!)!.bmiCalculator,
      'hint': 'Understand your weight \nand track changes',
    },
    {
      'image': LocalImages.img_sleep,
      'text': S.of(mainNavKey.currentContext!)!.sleep,
      'hint': 'Monitor your sleep patterns \nand quality.',
    },
    {
      'image': LocalImages.img_water_old,
      'text': S.of(mainNavKey.currentContext!)!.waterReminder,
      'hint': 'Stay hydrated with \npersonlized reminders.',
    },
  ];

  final pages = [
    const AilmentsView(),
    const WeightView(),
    const BmiCalculatorView(),
    const SleepView(),
    const WaterReminder(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.track,
        ),
        body: Container(
          // Set the container height to full screen
          height: double.infinity,
          child: Column(
            children: [
              kCommonSpaceV30, // Top padding
              Expanded(
                child: ListView.builder(
                    itemCount: dataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 12, left: 12, top: 3, bottom: 8),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: CommonColors.mWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                push(pages[index]);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Handle the tap
                                    },
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              dataList[index]['image']),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  kCommonSpaceH10,
                                  SizedBox(
                                    width: kDeviceWidth / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dataList[index]['text'],
                                          style: getAppStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        kCommonSpaceV10,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              dataList[index]['hint'],
                                              maxLines: 2,
                                              style: getAppStyle(
                                                color: CommonColors.blackColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            kCommonSpaceH10,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  kCommonSpaceH10,
                                  Text(
                                    '>',
                                    style: getAppStyle(
                                      color: CommonColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              kCommonSpaceV30, // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

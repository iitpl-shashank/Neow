// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:naveli_2023/widgets/scaffold_bg.dart';
// import 'package:numberpicker/numberpicker.dart';
//
// import '../../../../../generated/i18n.dart';
// import '../../../../../utils/common_colors.dart';
// import '../../../../../utils/constant.dart';
// import '../../../../../utils/local_images.dart';
// import '../../../../../widgets/common_appbar.dart';
// import '../../../../../widgets/primary_button.dart';
//
//
// class SleepView extends StatefulWidget {
//   const SleepView({super.key});
//
//   @override
//   State<SleepView> createState() => _SleepViewState();
// }
//
// class _SleepViewState extends State<SleepView> {
//   int hr = 0;
//   int min = 0;
//   String sleepText = 'Enter your sleep hour';
//
//   void updateSleepText() {
//     setState(() {
//       if (hr == 0 && min == 0) {
//         sleepText = 'Enter your sleep hour';
//       } else if (hr > 0 && min == 0) {
//         sleepText = '$hr Hr';
//       } else if (hr == 0 && min > 0) {
//         sleepText = '$min Min';
//       } else {
//         sleepText = '$hr . $min Min';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldBG(
//       child: Scaffold(
//         backgroundColor: CommonColors.mTransparent,
//         appBar:  CommonAppBar(
//           title:  S.of(context)!.sleep,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Text(
//               //   S.of(context)!.sleep,
//               //   style: getAppStyle(
//               //     color: CommonColors.blackColor,
//               //     fontSize: 20,
//               //     fontWeight: FontWeight.w500,
//               //   ),
//               // ),
//               Center(
//                 child: Column(
//                   children: [
//                     Image.asset(
//                         LocalImages.img_sleep,
//                     ),
//                     kCommonSpaceV20,
//                     TextButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) {
//                             return StatefulBuilder(builder:
//                                 (BuildContext context, StateSetter setState) {
//                               return SizedBox(
//                                 height: 245,
//                                 width: double.infinity,
//                                 child: Column(
//                                   children: <Widget>[
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       // Center the children horizontally
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: SizedBox(
//                                             height: 25,
//                                             width: 25,
//                                             child: IconButton(
//                                               style: IconButton.styleFrom(
//                                                   backgroundColor:
//                                                   CommonColors.mRed,
//                                                   foregroundColor:
//                                                   CommonColors.mWhite),
//                                               padding: EdgeInsets.zero,
//                                               icon: Icon(
//                                                 Icons.clear,
//                                                 size: 20,
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         Text(
//                                          S.of(context)!.logYourSleepHour,
//                                           style: getAppStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Spacer(),
//                                       ],
//                                     ),
//                                     kCommonSpaceV20,
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         NumberPicker(
//                                           minValue: 0,
//                                           maxValue: 24,
//                                           value: hr,
//                                           zeroPad: false,
//                                           infiniteLoop: true,
//                                           itemWidth: 50,
//                                           itemHeight: 40,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               hr = value;
//                                               updateSleepText();
//                                             });
//                                           },
//                                           textStyle: getAppStyle(
//                                               color: Colors.grey, fontSize: 20),
//                                           selectedTextStyle: getAppStyle(
//                                               color: Colors.black, fontSize: 25),
//                                           decoration: const BoxDecoration(
//                                             border: Border(
//                                                 top: BorderSide(
//                                                   width: 2,
//                                                   color:
//                                                   CommonColors.secondaryColor,
//                                                 ),
//                                                 bottom: BorderSide(
//                                                     width: 2,
//                                                     color: CommonColors
//                                                         .secondaryColor)),
//                                           ),
//                                         ),
//                                         kCommonSpaceH15,
//                                         Text(
//                                           '.',
//                                           style: getAppStyle(
//                                               fontSize: 50, color: Colors.black),
//                                         ),
//                                         kCommonSpaceH15,
//                                         NumberPicker(
//                                           minValue: 0,
//                                           maxValue: 59,
//                                           value: min,
//                                           zeroPad: false,
//                                           infiniteLoop: true,
//                                           itemWidth: 50,
//                                           itemHeight: 40,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               min = value;
//                                               updateSleepText();
//                                             });
//                                           },
//                                           textStyle: getAppStyle(
//                                               color: Colors.grey, fontSize: 20),
//                                           selectedTextStyle: getAppStyle(
//                                               color: Colors.black, fontSize: 25),
//                                           decoration: const BoxDecoration(
//                                             border: Border(
//                                                 top: BorderSide(
//                                                   width: 2,
//                                                   color:
//                                                   CommonColors.secondaryColor,
//                                                 ),
//                                                 bottom: BorderSide(
//                                                     width: 2,
//                                                     color: CommonColors
//                                                         .secondaryColor)),
//                                           ),
//                                         ),
//                                         kCommonSpaceH15,
//                                         Text(
//                                           S.of(context)!.min,
//                                           style: getAppStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     Align(
//                                         alignment: Alignment.bottomRight,
//                                         child: TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text(
//                                               S.of(context)!.done,
//                                               style: getAppStyle(
//                                                   fontSize: 22,
//                                                   color: CommonColors.greenColor),
//                                             )))
//                                   ],
//                                 ),
//                               );
//                             });
//                           },
//                         );
//                       },
//                       child: Text(
//                         sleepText,
//                         style: getAppStyle(
//                           color: CommonColors.mGrey,
//                           fontSize: 25,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     kCommonSpaceV20,
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: PrimaryButton(
//                   width: kDeviceWidth / 2,
//                   label: S.of(context)!.sleep,
//                   buttonColor: CommonColors.primaryColor,
//                   onPress: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_history_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/primary_button.dart';

class SleepView extends StatefulWidget {
  const SleepView({super.key});

  @override
  _SleepViewState createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  late SleepViewModel mViewModel;
  int currentIndex = 0;
  final ClockTimeFormat _clockTimeFormat = ClockTimeFormat.twentyFourHours;
  final ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.fiveMin;
  PickedTime _inBedTime = PickedTime(h: 0, m: 0);
  PickedTime _outBedTime = PickedTime(h: 0, m: 0);
  PickedTime _intervalBedTime = PickedTime(h: 0, m: 0);
  bool? validRange = true;

  TimeOfDay _sleepTimeOfDay = const TimeOfDay(hour: 00, minute: 00);
  TimeOfDay _wakeUpTimeOfDay = const TimeOfDay(hour: 00, minute: 00);

  Future<void> _showSleepTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _sleepTimeOfDay,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _sleepTimeOfDay) {
      setState(() {
        _sleepTimeOfDay = picked;
        _inBedTime = PickedTime(h: picked.hour, m: picked.minute);
      });
    }
  }

  Future<void> _showWakeUpTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _wakeUpTimeOfDay,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _wakeUpTimeOfDay) {
      setState(() {
        _wakeUpTimeOfDay = picked;
        _outBedTime = PickedTime(h: picked.hour, m: picked.minute);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.getSleepDetailApi().whenComplete(() {
        mViewModel.fetchSleepData();

        if (mViewModel.sleepData?.badTimeHours != null &&
            mViewModel.sleepData?.wakeupTimeHours != null &&
            mViewModel.sleepData?.totalSleepTime != null) {
          _sleepTimeOfDay = TimeOfDay(
              hour: mViewModel.sleepData?.badTimeHours ?? 00,
              minute: mViewModel.sleepData?.badTimeMinutes ?? 00);
          _wakeUpTimeOfDay = TimeOfDay(
              hour: mViewModel.sleepData?.wakeupTimeHours ?? 00,
              minute: mViewModel.sleepData?.wakeupTimeMinutes ?? 00);
          _inBedTime = PickedTime(
              h: mViewModel.sleepData?.badTimeHours ?? 00,
              m: mViewModel.sleepData?.badTimeMinutes ?? 00);
          _outBedTime = PickedTime(
              h: mViewModel.sleepData?.wakeupTimeHours ?? 00,
              m: mViewModel.sleepData?.wakeupTimeMinutes ?? 00);
          _updateLabels(_inBedTime, _outBedTime, validRange);
          pageController.animateToPage(2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }
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
                    push(const SleeptHistoryView());
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
        body: PageView(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          // physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            /* Padding(
              padding: kCommonScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    LocalImages.img_sleep,
                  ),
                  Text(
                    S.of(context)!.whatTimeDoGoBed,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        color: CommonColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: _showSleepTimePicker,
                    child: CommonTimeSelectionWidget(
                      title: S.of(context)!.bedTime,
                      time: _sleepTimeOfDay,
                      icon: Icons.power_settings_new_outlined,
                      selectedTime: _sleepTimeOfDay.format(context).toString(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: kDeviceWidth / 2,
                      label: S.of(context)!.next,
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        if (_wakeUpTimeOfDay !=
                            const TimeOfDay(hour: 00, minute: 00)) {
                          pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        } else if (isValid()) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: kCommonScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    LocalImages.img_sleep_daily_diary,
                    height: kDeviceHeight / 3,
                  ),
                  Text(
                    S.of(context)!.whatTimeWakeUp,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        color: CommonColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: _showWakeUpTimePicker,
                    child: CommonTimeSelectionWidget(
                      title: S.of(context)!.wakeUpTime,
                      time: _wakeUpTimeOfDay,
                      icon: Icons.notifications_active_outlined,
                      selectedTime: _wakeUpTimeOfDay.format(context).toString(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: kDeviceWidth / 2,
                      label: S.of(context)!.next,
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        if (isValid()) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          _updateLabels(_inBedTime, _outBedTime, validRange);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
             */

            Padding(
              padding: kCommonScreenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: CommonColors.primaryLite,
                  //     borderRadius: BorderRadius.circular(25.0),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(16.0),
                  //         child: Text(
                  //           '${"Todays Sleep Time "} : ${intl.NumberFormat('00').format(_intervalBedTime.h)}${S.of(context)!.hr} ${intl.NumberFormat('00').format(_intervalBedTime.m)}${S.of(context)!.min}',
                  //           // _isSleepGoal
                  //           //     ? "Above Sleep Goal (>=8) 😇"
                  //           //     : 'Below Sleep Goal (<=8) 😴',
                  //           style: getAppStyle(
                  //             color: Colors.black54,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20),
                  //       kCommonSpaceV20,
                  //       // Add some spacing between the container and button
                  //       TextButton(
                  //         onPressed: () => {}, // Call _addAction when pressed
                  //         child: Text(
                  //           'Add',
                  //           textAlign: TextAlign.right,
                  //           style: TextStyle(
                  //             color: CommonColors
                  //                 .primaryColor, // You can change the color of the button text here
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  TimePicker(
                    initTime: _inBedTime,
                    endTime: _outBedTime,
                    height: 260.0,
                    width: 260.0,
                    onSelectionChange: _updateLabels,
                    onSelectionEnd: (start, end, isDisableRange) => print(
                        'onSelectionEnd => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}, isDisableRange: $isDisableRange'),
                    primarySectors: _clockTimeFormat.value,
                    secondarySectors: _clockTimeFormat.value * 2,
                    decoration: TimePickerDecoration(
                      baseColor: CommonColors.primaryLite.withOpacity(0.8),
                      // pickerBaseCirclePadding: 15.0,
                      sweepDecoration: TimePickerSweepDecoration(
                        pickerStrokeWidth: 20.0,
                        connectorStrokeWidth: 22,
                        pickerColor: CommonColors.mWhite,
                        connectorColor: CommonColors.primaryColor,
                        showConnector: true,
                      ),
                      initHandlerDecoration: TimePickerHandlerDecoration(
                        color: CommonColors.mWhite,
                        shape: BoxShape.circle,
                        radius: 12.0,
                        icon: const Icon(
                          Icons.bed_outlined,
                          size: 20.0,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                      endHandlerDecoration: TimePickerHandlerDecoration(
                        color: CommonColors.mWhite,
                        shape: BoxShape.circle,
                        radius: 12.0,
                        icon: const Icon(
                          Icons.alarm,
                          size: 20.0,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                      primarySectorsDecoration: TimePickerSectorDecoration(
                        color: CommonColors.primaryColor,
                        width: 1.0,
                        size: 4.0,
                        radiusPadding: 25.0,
                      ),
                      secondarySectorsDecoration: TimePickerSectorDecoration(
                        color: CommonColors.primaryColor,
                        width: 1.0,
                        size: 2.0,
                        radiusPadding: 25.0,
                      ),
                      clockNumberDecoration: TimePickerClockNumberDecoration(
                        defaultTextColor: CommonColors.primaryColor,
                        defaultFontSize: 12.0,
                        scaleFactor: 2.0,
                        showNumberIndicators: true,
                        clockTimeFormat: _clockTimeFormat,
                        clockIncrementTimeFormat: _clockIncrementTimeFormat,
                      ),
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.all(62.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         '${intl.NumberFormat('00').format(_intervalBedTime.h)}Hr ${intl.NumberFormat('00').format(_intervalBedTime.m)}Min',
                    //         style: TextStyle(
                    //           fontSize: 14.0,
                    //           color: _isSleepGoal ? CommonColors.primaryColor :CommonColors.primaryColor,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                  // Text(
                  //   'Sleep time : ${intl.NumberFormat('00').format(_intervalBedTime.h)}Hr ${intl.NumberFormat('00').format(_intervalBedTime.m)}Min',
                  //   style: TextStyle(
                  //     fontSize: 14.0,
                  //     color: _isSleepGoal
                  //         ? CommonColors.primaryColor
                  //         : CommonColors.primaryColor,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  Container(
                    width: kDeviceWidth / 1.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CommonColors.primaryLite,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${S.of(context)!.sleepTime} : ${intl.NumberFormat('00').format(_intervalBedTime.h)}${S.of(context)!.hr} ${intl.NumberFormat('00').format(_intervalBedTime.m)}${S.of(context)!.min}',
                        // _isSleepGoal
                        //     ? "Above Sleep Goal (>=8) 😇"
                        //     : 'Below Sleep Goal (<=8) 😴',
                        style: getAppStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          /* pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ); */
                          _showSleepTimePicker();
                        },
                        child: CommonTimeSelectionWidget(
                          title: S.of(context)!.bedTime,
                          isEditIcon: false,
                          time: _sleepTimeOfDay,
                          icon: Icons.power_settings_new_outlined,
                          selectedTime:
                              _sleepTimeOfDay.format(context).toString(),
                        ),
                      ),
                      kCommonSpaceH15,
                      GestureDetector(
                        onTap: () {
                          /* pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ); */
                          _showWakeUpTimePicker();
                        },
                        child: CommonTimeSelectionWidget(
                          title: S.of(context)!.wakeUpTime,
                          time: _wakeUpTimeOfDay,
                          isEditIcon: false,
                          icon: Icons.notifications_active_outlined,
                          selectedTime:
                              _wakeUpTimeOfDay.format(context).toString(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: kDeviceWidth / 1.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CommonColors.primaryLite,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${S.of(context)!.avgSleepTime} : ${mViewModel.sleepData?.averageTotalSleepTime}',
                        style: getAppStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: kDeviceWidth / 2,
                      label: S.of(context)!.submit,
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        String sleepHr =
                            intl.NumberFormat('00').format(_intervalBedTime.h);
                        String sleepMin =
                            intl.NumberFormat('00').format(_intervalBedTime.m);
                        final MaterialLocalizations localizations =
                            MaterialLocalizations.of(context);
                        // print("Bed time :: ${localizations.formatTimeOfDay(_sleepTimeOfDay)}");
                        // print("Wake up time :: ${localizations.formatTimeOfDay(_wakeUpTimeOfDay)}");
                        // print('Sleep time :: ${sleepHr}Hr ${sleepMin}Min');
                        mViewModel.storeSleepDetailApi(
                            bedTime:
                                localizations.formatTimeOfDay(_sleepTimeOfDay),
                            wakeUpTime:
                                localizations.formatTimeOfDay(_wakeUpTimeOfDay),
                            sleepTime: '${sleepHr}Hr ${sleepMin}Min');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValid() {
    if (currentIndex == 0 &&
        _sleepTimeOfDay == const TimeOfDay(hour: 00, minute: 00)) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectSleepTime,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 1 &&
        _wakeUpTimeOfDay == const TimeOfDay(hour: 00, minute: 00)) {
      CommonUtils.showSnackBar(S.of(context)!.plWakeUpSleepTime,
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }

  void _updateLabels(PickedTime init, PickedTime end, bool? isDisableRange) {
    _inBedTime = init;
    _outBedTime = end;
    _intervalBedTime = formatIntervalTime(
      init: _inBedTime,
      end: _outBedTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );
    setState(() {
      validRange = isDisableRange;
    });
  }
}

class CommonTimeSelectionWidget extends StatelessWidget {
  final String title;
  final String selectedTime;
  final TimeOfDay time;
  final bool isEditIcon;
  final IconData icon;

  const CommonTimeSelectionWidget(
      {super.key,
      required this.title,
      required this.time,
      required this.icon,
      required this.selectedTime,
      this.isEditIcon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDeviceWidth / 1,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: CommonColors.primaryLite.withOpacity(0.6),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 25.0,
                  color: CommonColors.primaryColor,
                ),
              ),
              kCommonSpaceH15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditIcon
                      ? const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: CommonColors.primaryColor,
                              size: 18,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: CommonColors.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kCommonSpaceV5,
                  Text(
                    selectedTime,
                    style: const TextStyle(
                      color: CommonColors.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  kCommonSpaceV5,
                ],
              ),
            ],
          )),
    );
  }
}

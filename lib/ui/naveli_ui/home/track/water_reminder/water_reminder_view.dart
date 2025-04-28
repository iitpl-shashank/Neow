import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/water_reminder/water_reminder_history.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/water_reminder/water_reminder_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/primary_button.dart';

class WaterReminder extends StatefulWidget {
  const WaterReminder({super.key});

  @override
  State<WaterReminder> createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> {
  late WaterReminderViewModel mViewModel;
  int currentValue = 4;
  String inType = 'glass';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.fetchWaterHistory();
      mViewModel.setProgress(currentValue, (currentValue * 250));
      mViewModel.getWaterDetailApi().whenComplete(() {
        mViewModel.showStoredGlass();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WaterReminderViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.waterReminder,
          actions: <Widget>[
            InkWell(
              onTap: () {
                // push(CalendarView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TextButton(
                  onPressed: () {
                    push(const WaterReminderHistory());
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
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    mViewModel.images[mViewModel.currentImageIndex],
                    // width: kDeviceWidth / 2,
                    height: kDeviceHeight / 2.5,
                    fit: BoxFit.contain,
                  ),
                  kCommonSpaceV10,
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Minimum advisable water intake - 2 ltr",
                              style: getAppStyle(
                                color: CommonColors.mGrey,
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kCommonSpaceV5,
                      kCommonSpaceV5,
                      Text(
                        'Keep yourself hydrated!',
                        style: getAppStyle(
                          color: CommonColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kCommonSpaceV20,
              kCommonSpaceV10,
              WheelSlider.number(
                totalCount: 10,
                horizontal: true,
                perspective: 0.007,
                initValue: 4,
                unSelectedNumberStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                selectedNumberStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onValueChanged: (val) {
                  setState(() {
                    if (inType == "glass") {
                      mViewModel.setProgress(val, (val * 250));
                    } else {
                      mViewModel.setProgress(val, (val * 1000));
                    }
                    currentValue = val;
                  });
                },
                currentIndex: currentValue,
                hapticFeedbackType: HapticFeedbackType.heavyImpact,
              ),
              Icon(
                CupertinoIcons.arrowtriangle_up_fill,
                size: 20,
                color: CommonColors.primaryColor,
              ),
              kCommonSpaceV20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log Water Intake',
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1 glass = 250 ml',
                        style: TextStyle(
                          color: CommonColors.mGrey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kCommonSpaceV30,
              /* DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    color: CommonColors.primaryLite,
                    // Set your desired background color here
                    borderRadius: BorderRadius.circular(
                        8.0), // Optionally, you can add border radius
                  ),
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    isExpanded: true,
                    value: mViewModel.dropdownValue,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: CommonColors.primaryColor,
                    ),
                    style: const TextStyle(
                      color: CommonColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        mViewModel.dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      '30 min',
                      '45 min',
                      '1 hour',
                      '90 min',
                      '2 hour'
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              kCommonSpaceV50, */
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 1.3,
                  label: 'Save',
                  buttonColor: CommonColors.primaryColor,
                  onPress: () async {
                    // NotificationService.showNotification(title: "Notification", body: "this is testing notification");
                    // await NotificationService.showNotification(
                    //   title: "Water reminder",
                    //   body: "It's time to drink water...",
                    //   scheduled: true,
                    //   interval: 62,
                    // );

                    // await NotificationService.showNotification(
                    //   title: "Water Reminder",
                    //   body: "It's time to drink water...",
                    //   notificationLayout: NotificationLayout.BigPicture,
                    //   bigPicture:
                    //       "https://c.ndtvimg.com/2022-11/089qdk1g_benefits-of-drinking-water-before-brushing_625x300_24_November_22.jpg",
                    // );

                    print("Water Ml :: ${mViewModel.waterMl}");
                    mViewModel.storeWaterDetailApi(waterMl: mViewModel.waterMl);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

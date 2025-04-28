import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/calendar_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/water_reminder/water_reminder_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/dashboard/bar_data.dart';
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

class WaterReminderHistory extends StatefulWidget {
  const WaterReminderHistory({super.key});

  @override
  State<WaterReminderHistory> createState() =>
      _WaterRemindertHistoryViewState();
}

class _WaterRemindertHistoryViewState extends State<WaterReminderHistory> {
  // int kg = 20;
  // int gm = 0;
  // late WeightViewModel mViewModel;
  late WaterReminderViewModel mViewModel; //fetchSleepData;

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
      setBarData();

      mViewModel.fetchWaterHistory();

      setState(() {
        CommonUtils.hideProgressDialog();
      });
    });
  }

  List<BarData> WaterInteke = [];
  Future<void> setBarData() async {
    var data = await mViewModel.fetchWaterHistory();
    await Future.delayed(Duration(seconds: 2));
    print(data);
    print("================  data");

    if (data != null && data.isNotEmpty) {
      // Check if data is valid
      List<BarData> waterDataList = [];

      for (var value in data) {
        try {
          // Safely parse water_ml to an integer
          int intValue = int.tryParse(value['water_ml'].toString()) ??
              0; // Default to 0 if parsing fails

          // Check if water_ml was valid
          if (intValue <= 0) {
            print('Invalid water_ml value: ${value['water_ml']}');
            continue; // Skip invalid values
          }

          String dateString = value['created_at']; // "2024-12-04 11:18:15"

          // Parse the date string safely
          DateTime createdAt;
          try {
            createdAt = DateTime.parse(
                dateString); // Parse the date string into a DateTime object
          } catch (e) {
            print('Error parsing date: $dateString');
            continue; // Skip if the date is invalid
          }

          // Use millisecondsSinceEpoch for xdata (numeric representation of the date)
          int dateKey = createdAt.millisecondsSinceEpoch;

          double mainValue = (intValue / 250);

          print('Date: $dateKey, Water Intake: $mainValue ml');
          print(mainValue.toInt());
          int valueFinal = mainValue.toInt();

          setState(() {
            waterDataList.add(BarData(
              ydata: valueFinal.toString(), // Water intake in ml (integer)
              xdata: valueFinal, // Numeric representation of the date (int)
            ));
          });
        } catch (e) {
          print('Error processing data: $e');
        }
      }

      setState(() {
        WaterInteke = waterDataList; // Update the bar data list
      });

      await processAfterBarDataUpdate();
    }
  }

  Future<void> processAfterBarDataUpdate() async {
    // Function that processes after SleepBarData has been updated
    print('Processing data after SleepBarData update...');
    // Add your logic here for further actions
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WaterInteke.isNotEmpty
                  ? SizedBox(
                      height: 250, // Adjust the height as needed
                      child: Center(
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(
                              border: const Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              ),
                            ),
                            groupsSpace: 10,
                            barGroups: [
                              for (var bdata in WaterInteke)
                                BarChartGroupData(
                                  x: bdata
                                      .xdata, // Use a numeric index for X-axis
                                  barRods: [
                                    BarChartRodData(
                                      fromY: 0,
                                      toY: int.parse(bdata.ydata)
                                          .toDouble(), // Water intake value
                                      width: 15,
                                      color: const Color.fromARGB(
                                          255, 111, 64, 133),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 20), // Adjust space if no data is available
            ],
          ),
        ),
      ),
    );
  }

// Function to convert the formatted date to an index (for the X-axis)
  int _getXValue(String date) {
    // You can either convert date strings to numbers or use index directly
    // Here, we'll use a simple index for illustration:
    return DateTime.parse(date).day; // Use the day as an X-axis value
  }

  bool isValid() {
    return true;
  }
}

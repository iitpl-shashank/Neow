import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/calendar/calendar_view.dart';
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

class WeightHistoryView extends StatefulWidget {
  const WeightHistoryView({super.key});

  @override
  State<WeightHistoryView> createState() => _WeightHistoryViewState();
}

class _WeightHistoryViewState extends State<WeightHistoryView> {
  // int kg = 20;
  // int gm = 0;
  late WeightViewModel mViewModel;
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
      mViewModel.getWeightDetailApi();
      setState(() {
        mViewModel.fetchWeightData();
      });
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
              for (int index = 0;
                  index < mViewModel.weightHistory.length;
                  index++)
                mViewModel.weightHistory.isNotEmpty
                    ? _weight_bmi(context, mViewModel.weightHistory[index])
                    : kCommonSpaceV20,
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
    } else if (mViewModel.selectedIndex == 0) {
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
                          '${item['data'][inx]['weight'] ?? "Empty"}',
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
  String unit = 'feet';
  var hi = globalUserMaster!.height;
  double height = double.parse(hi!);
  //globalUserMaster?.height as double;
  double meters = convertToMeters(height, unit);

  double weight = double.parse(item['weight']);
  print(weight);

  print('===========================================================');

  double bmi = weight / (meters * meters);

  // Determine the BMI category
  String category;
  if (bmi < 18.5) {
    category = 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    category = 'Normal weight';
  } else if (bmi >= 25 && bmi < 29.9) {
    category = 'Overweight';
  } else {
    category = 'Obese';
  }

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
                          text + ' Kgs',
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 111, 64, 133),
                            fontSize: 14,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${bmi.toStringAsFixed(2)}',
                          textAlign: TextAlign.right,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 111, 64, 133),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          category,
                          textAlign: TextAlign.right,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 102, 100, 100),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ), // Space between the dot and text
                    // Expanded(
                    //   child: Text(
                    //     value,
                    //     textAlign: TextAlign.right,
                    //     style: getAppStyle(
                    //       color: const Color.fromARGB(255, 102, 100, 100),
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

void main() {
  double value = 8.5;
  String unit = 'feet';
  double meters = convertToMeters(value, unit);
  print('$value $unit is equal to $meters meters');
}

double convertToMeters(double value, String fromUnit) {
  switch (fromUnit) {
    case 'feet':
      return value * 0.3048;
    case 'inches':
      return value * 0.0254;
    case 'kilometers':
      return value * 1000;
    default:
      throw Exception('Unsupported unit: $fromUnit');
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:naveli_2023/utils/constant.dart';
// import 'package:naveli_2023/widgets/scaffold_bg.dart';
//
// import '../../../../../generated/i18n.dart';
// import '../../../../../utils/common_colors.dart';
// import '../../../../../utils/common_utils.dart';
// import '../../../../../utils/local_images.dart';
// import '../../../../../widgets/common_appbar.dart';
// import '../../../../../widgets/common_textfield_container_bmi.dart';
// import '../../../../../widgets/primary_button.dart';
// import 'calculate_bmi.dart';
//
// class BmiCalculatorView extends StatefulWidget {
//   const BmiCalculatorView({super.key});
//
//   @override
//   State<BmiCalculatorView> createState() => _BmiCalculatorViewState();
// }
//
// class _BmiCalculatorViewState extends State<BmiCalculatorView> {
//   String selectedGender = 'lady';
//   String dropdownValueHeight = 'Cm';
//   String dropdownValueWeight = 'Kg';
//   TextEditingController ageController = TextEditingController();
//   TextEditingController heightController = TextEditingController();
//   TextEditingController weightController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldBG(
//       child: Scaffold(
//         backgroundColor: CommonColors.mTransparent,
//         appBar: CommonAppBar(
//           title: S.of(context)!.bmi,
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 S.of(context)!.bmiCalculator,
//                 style: getAppStyle(
//                   color: CommonColors.blackColor,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Image.asset(
//                       LocalImages.img_lady,
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             S.of(context)!.weight,
//                             style: getAppStyle(
//                               color: CommonColors.blackColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           kCommonSpaceV5,
//                           Row(
//                             children: [
//                               buildGenderOption('man', Icons.man_rounded),
//                               buildGenderOption('lady', Icons.woman_2_rounded),
//                               buildGenderOption('other', Icons.transgender),
//                             ],
//                           ),
//                           kCommonSpaceV10,
//                           Text(
//                             S.of(context)!.age,
//                             style: getAppStyle(
//                               color: CommonColors.blackColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           kCommonSpaceV5,
//                           CustomTextFieldContainer(
//                             controller: ageController,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context)!.height,
//                                 style: getAppStyle(
//                                   color: CommonColors.blackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               kCommonSpaceH15,
//                               DropdownButtonHideUnderline(
//                                 child: DropdownButton<String>(
//                                   value: dropdownValueHeight,
//                                   icon: Icon(Icons.arrow_drop_down,
//                                       color: CommonColors.primaryColor),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: getAppStyle(
//                                       color: CommonColors.primaryColor,
//                                       fontSize: 15),
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       dropdownValueHeight = newValue!;
//                                     });
//                                   },
//                                   items: <String>[
//                                     'Cm',
//                                     'Ft'
//                                   ].map<DropdownMenuItem<String>>((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           CustomTextFieldContainer(
//                             controller: heightController,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context)!.weight,
//                                 style: getAppStyle(
//                                   color: CommonColors.blackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               DropdownButtonHideUnderline(
//                                 child: DropdownButton<String>(
//                                   value: dropdownValueWeight,
//                                   icon: Icon(Icons.arrow_drop_down,
//                                       color: CommonColors.primaryColor),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: getAppStyle(
//                                       color: CommonColors.primaryColor,
//                                       fontSize: 15),
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       dropdownValueWeight = newValue!;
//                                     });
//                                   },
//                                   items: <String>[
//                                     'Kg',
//                                     'Lbs'
//                                   ].map<DropdownMenuItem<String>>((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           CustomTextFieldContainer(
//                             controller: weightController,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: PrimaryButton(
//                   width: kDeviceWidth / 2,
//                   label: S.of(context)!.calculateBmi,
//                   buttonColor: CommonColors.primaryColor,
//                   onPress: () {
//                     push(CalculateBmi());
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildGenderOption(String gender, IconData iconData) {
//     final isSelected = selectedGender == gender;
//     final double? size;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedGender = gender;
//         });
//       },
//       child: Container(
//         width: 35, // Width of the square
//         height: 35,
//         color: isSelected ? CommonColors.primaryColor : CommonColors.mWhite,
//         child: Icon(
//           iconData,
//           color: isSelected ? CommonColors.mWhite : CommonColors.blackColor,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_history_view.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view_model.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';
import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../utils/global_variables.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_textfield_container_bmi.dart';
import '../../../../../widgets/primary_button.dart';
import 'bmi_calculator_view_model.dart';
import 'calculate_bmi.dart';

class BmiCalculatorView extends StatefulWidget {
  const BmiCalculatorView({super.key});

  @override
  State<BmiCalculatorView> createState() => _BmiCalculatorViewState();
}

class _BmiCalculatorViewState extends State<BmiCalculatorView> {
  late BmiCalculatorViewModel mViewModel;
  late WeightViewModel mViewModelWeight;

  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String height = '';
  int weight = 30;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = BmiCalculatorViewModel();
      mViewModel.getBmiDetailApi().whenComplete(() {
        ageController.text = globalUserMaster!.age.toString();
        if (mViewModel.userData.height != null) {
          heightController.text = mViewModel.userData.height.toString();
        }
        if (mViewModel.userData.weight != null) {
          weightController.text = mViewModel.userData.weight.toString();
          setState(() {
            weight = int.parse(mViewModel.userData.weight.toString());
          });
          print(mViewModel.userData.weight.toString());
        }
        setState(() {
          mViewModel.dropdownValueHeight = "Ft";
        });

        // heightController.text = 'Ft';
      });
      mViewModelWeight.fetchWeightData();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<BmiCalculatorViewModel>(context);
    mViewModelWeight = Provider.of<WeightViewModel>(context);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.bmiCalculator,
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
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              kCommonSpaceV30,
              Text(
                'Gender',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kCommonSpaceV10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildGenderOption('Male', Icons.male),
                  buildGenderOption('Female', Icons.female),
                  buildGenderOption('Other', Icons.transgender),
                ],
              ),
              kCommonSpaceV30,
              Text(
                'Height',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kCommonSpaceV20,
              Container(
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
                          // mViewModel.selectedIndex = 1;
                          mViewModel.dropdownValueHeight = "Ft";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.dropdownValueHeight == 'Ft'
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            'Ft',
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.dropdownValueHeight == 'Ft'
                                    ? CommonColors.mWhite
                                    : CommonColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mViewModel.dropdownValueHeight = "CM";
                          /* mViewModel.selectedIndex = 2;
                          mViewModel.selectedWeightType = "Lbs"; */
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.dropdownValueHeight == "CM"
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            'CM',
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.dropdownValueHeight == "CM"
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
              AnimatedWeightPicker(
                min: 4, // Start at 1.1
                max: 10, // Max value is 10.2
                division:
                    0.1, // Set division to 0.1 to get increments like 1.1, 1.2, etc.
                squeeze: 2.5,
                selectedValueColor: CommonColors.primaryColor,
                majorIntervalTextColor: CommonColors.primaryColor,
                dialColor: CommonColors.primaryColor,
                subIntervalColor: CommonColors.primaryColor,
                majorIntervalColor: CommonColors.primaryColor,
                showSuffix: false,
                dialHeight: 50,
                dialThickness: 1.5,

                majorIntervalAt: 10,
                majorIntervalHeight: 18,
                majorIntervalThickness: 1,

                showMajorIntervalText: true,
                majorIntervalTextSize: 15,

                minorIntervalHeight: 10,
                minorIntervalThickness: 1,
                minorIntervalColor: CommonColors.primaryColor,
                showMinorIntervalText: false,
                minorIntervalTextSize: 15,
                minorIntervalTextColor: CommonColors.primaryColor,
                subIntervalAt: 5,
                subIntervalHeight: 15,
                subIntervalThickness: 1,

                showSubIntervalText: false,
                subIntervalTextSize: 5,
                subIntervalTextColor: CommonColors.primaryColor,
                showSelectedValue: true,

                selectedValueStyle: TextStyle(
                    fontSize: 18), // Customize the value display style

                suffixText: 'Ft',
                suffixTextColor: CommonColors.primaryColor,
                onChange: (newValue) {
                  setState(() {
                    // Round the value to 1 decimal place
                    double roundedValue =
                        (double.parse(newValue) * 10).round() / 10;
                    height = roundedValue
                        .toStringAsFixed(1); // Ensure one decimal place
                    heightController.text = height; // Update text controller
                  });
                },
              ),
              kCommonSpaceV30,
              Text(
                'Weight',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CommonColors.blackColor,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kCommonSpaceV20,
              Container(
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
                          // mViewModel.selectedIndex = 1;
                          mViewModel.dropdownValueWeight = "Kg";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.dropdownValueWeight == 'Kg'
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            S.of(context)!.kg,
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.dropdownValueWeight == 'Kg'
                                    ? CommonColors.mWhite
                                    : CommonColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mViewModel.dropdownValueWeight = "Lbs";
                          /* mViewModel.selectedIndex = 2;
                          mViewModel.selectedWeightType = "Lbs"; */
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 2, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mViewModel.dropdownValueWeight == "Lbs"
                                  ? CommonColors.primaryColor
                                  : CommonColors.mTransparent),
                          child: Text(
                            'Lbs',
                            style: getAppStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: mViewModel.dropdownValueWeight == "Lbs"
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
                    height = newValue;
                    weightController.text = newValue;
                  });
                },
              ), */
              kCommonSpaceV20,
              WheelSlider.number(
                totalCount: 150,
                horizontal: true,
                perspective: 0.007,
                initValue: 4,
                unSelectedNumberStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
                selectedNumberStyle: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onValueChanged: (val) {
                  /* setState(() {
                    if (inType == "glass") {
                      mViewModel.setProgress(val, (val * 250));
                    } else {
                      mViewModel.setProgress(val, (val * 1000));
                    }
                    currentValue = val;
                  }); */
                  setState(() {
                    weight = val;
                    weightController.text = val.toString();
                  });
                },
                currentIndex: weight,
                hapticFeedbackType: HapticFeedbackType.heavyImpact,
              ),
              Icon(
                CupertinoIcons.arrowtriangle_up_fill,
                size: 20,
                color: CommonColors.primaryColor,
              ),
              /* Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      LocalImages.img_bmi_calculator,
                      height: kDeviceHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context)!.gender,
                            style: getAppStyle(
                              color: CommonColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          kCommonSpaceV5,
                          /* Row(
                            children: [
                              buildGenderOption('Male', Icons.man_rounded),
                              buildGenderOption(
                                  'Female', Icons.woman_2_rounded),
                              buildGenderOption('Other', Icons.transgender),
                            ],
                          ),
                           */
                          kCommonSpaceV10,
                          Text(
                            S.of(context)!.age,
                            style: getAppStyle(
                              color: CommonColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          kCommonSpaceV5,
                          /* CustomTextFieldContainer(
                              isReadOnly: true,
                              isLabelText: false,
                              controller: ageController,
                              textColor: CommonColors.blackColor,
                              keyboardType: TextInputType.number),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context)!.height,
                                style: getAppStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kCommonSpaceH15,
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: mViewModel.dropdownValueHeight,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: CommonColors.primaryColor),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontSize: 15),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      mViewModel.dropdownValueHeight =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['Cm', 'Ft']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                           */
                          CustomTextFieldContainer(
                              controller: heightController,
                              textColor: CommonColors.blackColor,
                              isLabelText: false,
                              keyboardType: TextInputType.number),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context)!.weight,
                                style: getAppStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: mViewModel.dropdownValueWeight,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: CommonColors.primaryColor),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontSize: 15),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      mViewModel.dropdownValueWeight =
                                          newValue!;
                                    });
                                  },
                                  items: <String>['Kg', 'Lbs']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          CustomTextFieldContainer(
                            isLabelText: false,
                            textColor: CommonColors.blackColor,
                            keyboardType: TextInputType.number,
                            controller: weightController,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ), */
              kCommonSpaceV30,
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  label: S.of(context)!.calculateBmi,
                  buttonColor: CommonColors.primaryColor,
                  onPress: () {
                    if (1 == 1) {
                      double weight =
                          double.tryParse(weightController.text) ?? 0.0;
                      double height =
                          double.tryParse(heightController.text) ?? 0.0;
                      int age = int.tryParse(ageController.text) ?? 0;
                      double bmi = mViewModel.calculateBMI(weight, height);
                      String bmiInterpretation =
                          mViewModel.interpretBMI(bmi, age);
                      print("BMI is :: ${bmi.toStringAsFixed(1)}");
                      print("BMI Category is :: $bmiInterpretation");
                      // push(CalculateBmi(
                      //   score: bmi.toStringAsFixed(1),
                      //   category: bmiInterpretation,
                      //   gender: mViewModel.selectedGender,
                      //   age: ageController.text,
                      //   weight: weightController.text,
                      //   height: heightController.text,
                      //   dropdownValueHeight: mViewModel.dropdownValueHeight,
                      //   dropdownValueWeight: mViewModel.dropdownValueWeight,
                      // ));
                      push(CalculateBmi(
                        age: int.parse(ageController.text),
                        bmiScore: double.parse(bmi.toStringAsFixed(1)),
                        gender: mViewModel.selectedGender,
                        weight: weightController.text,
                        height: heightController.text,
                        dropdownValueHeight: mViewModel.dropdownValueHeight,
                        dropdownValueWeight: mViewModel.dropdownValueWeight,
                      ));
                      mViewModel.storeUserBmiApi(
                          age: int.parse(ageController.text),
                          height: double.parse(heightController.text),
                          weight: double.parse(weightController.text),
                          bmiScore: double.parse(bmi.toStringAsFixed(1)),
                          bmiType: bmiInterpretation);
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

  Widget buildGenderOption(String gender, IconData iconData) {
    final isSelected = mViewModel.selectedGender == gender;
    final double? size;
    return GestureDetector(
        onTap: () {
          setState(() {
            mViewModel.selectedGender = gender;
          });
        },
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  color: isSelected
                      ? CommonColors.primaryLite
                      : CommonColors.mWhite,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: CommonColors.primaryColor, width: 1)),
              child: Icon(
                iconData,
                size: 28,
                color: isSelected
                    ? CommonColors.primaryColor
                    : CommonColors.primaryColor,
              ),
            ),
            Text(
              gender,
              style: getAppStyle(
                color: CommonColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ));
  }

  bool isValid() {
    if (ageController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterAge,
          color: CommonColors.mRed);
      return false;
    } else if (heightController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plEnterHeight,
          color: CommonColors.mRed);
      return false;
    } else if (weightController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(S.of(context)!.plSelectWeight,
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/reports/reports_view_model.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_textfield_container_bmi.dart';
import '../../../../widgets/primary_button.dart';
import '../../../common_ui/splash/splash_view_model.dart';
import '../../home/log_your_symptoms/log_your_symptoms_view_model.dart';
import '../../home/quiz/quiz_question/quiz_question_view_model.dart';
import '../../home/track/ailments/ailments_view_model.dart';
import '../../home/track/medication/medication_view_model.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  Color primaryColorWithOpacity = CommonColors.primaryColor.withOpacity(0.3);
  late LogYourSymptomsModel mViewModel;
  late ReportsViewModel mReportViewModel;
  late MedicationViewModel mMedicationViewModel;
  late AilmentsViewModel mAilmentsViewModel;
  late QuizQuestionViewModel mQuizViewModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();

  // TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController ailmentsController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController lastPeriodController = TextEditingController();
  TextEditingController cycleLengthController = TextEditingController();
  TextEditingController periodLengthController = TextEditingController();
  TextEditingController stainingController = TextEditingController();
  TextEditingController clotSizeController = TextEditingController();
  TextEditingController workingAbilityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController periodCrampsController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController stressController = TextEditingController();
  TextEditingController pmsController = TextEditingController();
  TextEditingController pcoController = TextEditingController();
  TextEditingController anemiaController = TextEditingController();
  TextEditingController sleepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mQuizViewModel.getQuestionAnswerApi().whenComplete(() {
        pcoController.text = mQuizViewModel.storedPcoMessage ?? '';
        pmsController.text = mQuizViewModel.storedPmsMessage ?? '';
        anemiaController.text = mQuizViewModel.storedAnemiaMessage ?? '';
      });
      mViewModel.getUserSymptomsLogApi(
          date: globalUserMaster?.previousPeriodsBegin ?? '');
      mMedicationViewModel.userPreviousMedication.clear();
      mMedicationViewModel.storedOtherMedicineList.clear();
      mAilmentsViewModel.userPreviousAilments.clear();
      mAilmentsViewModel.storedOtherAilmentsList.clear();
      medicationController.clear();
      ailmentsController.clear();
      /* mMedicationViewModel.getStoredMedicineListApi(false).whenComplete(() {
        var medication = mMedicationViewModel.userPreviousMedication.toString();
        medication = medication.substring(1, medication.length - 1);
        var otherMedication =
            mMedicationViewModel.storedOtherMedicineList.toString();
        otherMedication =
            otherMedication.substring(1, otherMedication.length - 1);
        medicationController.text = "$medication  $otherMedication";
      }); */
      mAilmentsViewModel.getStoredAilmentsListApi(false).whenComplete(() {
        var ailments = mAilmentsViewModel.userPreviousAilments.toString();
        ailments = ailments.substring(1, ailments.length - 1);
        var otherAilments =
            mAilmentsViewModel.storedOtherAilmentsList.toString();
        otherAilments = otherAilments.substring(1, otherAilments.length - 1);
        ailmentsController.text = "$ailments  $otherAilments";
      });
      SplashViewModel().getUserDetails().whenComplete(() {
        // assignGender();
        assignAgeGroup();
        nameController.text = globalUserMaster?.name ?? '';
        mobileController.text = globalUserMaster?.mobile ?? '';
        emailController.text = globalUserMaster?.email ?? '';
        uniqueIdController.text = globalUserMaster?.uuId ?? '';

        dobController.text = globalUserMaster?.birthdate ?? '';
        ageController.text = "${globalUserMaster?.age} Year";
        if (globalUserMaster?.weight != null) {
          weightController.text = "${globalUserMaster?.weight} Kg";
        }
        if (globalUserMaster?.bmiScore != null &&
            globalUserMaster?.bmiType != null) {
          bmiController.text =
              "${globalUserMaster?.bmiScore} - ${globalUserMaster?.bmiType}";
        }
        cycleLengthController.text = globalUserMaster?.averageCycleLength ?? '';
        lastPeriodController.text =
            "${globalUserMaster?.previousPeriodsBegin ?? ''} ${globalUserMaster?.previousPeriodsMonth ?? ''}";
        periodLengthController.text =
            globalUserMaster?.averagePeriodLength ?? '';
        sleepController.text = globalUserMaster?.totalSleepTime ?? '';
        assignSymptoms();
      });
    });
  }

  void assignSymptoms() {
    if (mViewModel.selectedStaining != null) {
      if (mViewModel.selectedStaining == 1) {
        stainingController.text = "Low";
      } else if (mViewModel.selectedStaining == 2) {
        stainingController.text = "Medium";
      } else if (mViewModel.selectedStaining == 3) {
        stainingController.text = "High";
      }
    }

    if (mViewModel.selectedClotSize != null) {
      if (mViewModel.selectedClotSize == 1) {
        clotSizeController.text = "Small";
      } else if (mViewModel.selectedClotSize == 2) {
        clotSizeController.text = "Medium";
      } else if (mViewModel.selectedClotSize == 3) {
        clotSizeController.text = "Large";
      }
    }

    if (mViewModel.selectedWorkingAbility != null) {
      if (mViewModel.selectedWorkingAbility == 1) {
        workingAbilityController.text = "Always";
      } else if (mViewModel.selectedWorkingAbility == 2) {
        workingAbilityController.text = "Almost Always";
      } else if (mViewModel.selectedWorkingAbility == 3) {
        workingAbilityController.text = "Almost Never";
      } else if (mViewModel.selectedWorkingAbility == 4) {
        workingAbilityController.text = "None";
      }
    }

    if (mViewModel.selectedLocation != null) {
      if (mViewModel.selectedLocation == 1) {
        locationController.text = "None";
      } else if (mViewModel.selectedLocation == 2) {
        locationController.text = "1";
      } else if (mViewModel.selectedLocation == 3) {
        locationController.text = "2-3";
      } else if (mViewModel.selectedLocation == 4) {
        locationController.text = "4";
      }
    }

    if (mViewModel.selectedCramps != null) {
      if (mViewModel.selectedCramps == 1) {
        periodCrampsController.text = "No Hurts";
      } else if (mViewModel.selectedCramps == 2) {
        periodCrampsController.text = "Hurts little bit";
      } else if (mViewModel.selectedCramps == 3) {
        periodCrampsController.text = "Hurts more";
      } else if (mViewModel.selectedCramps == 4) {
        periodCrampsController.text = "Hurts worst";
      }
    }

    if (mViewModel.selectedDays != null) {
      if (mViewModel.selectedDays == 1) {
        daysController.text = "0";
      } else if (mViewModel.selectedDays == 2) {
        daysController.text = "1-2";
      } else if (mViewModel.selectedDays == 3) {
        daysController.text = "3-4";
      } else if (mViewModel.selectedDays == 4) {
        daysController.text = "5 or 5+";
      }
    }

    if (mViewModel.selectedStress != null) {
      if (mViewModel.selectedStress == 1) {
        stressController.text = "Low";
      } else if (mViewModel.selectedStress == 2) {
        stressController.text = "Moderate";
      } else if (mViewModel.selectedStress == 3) {
        stressController.text = "High";
      }
    }
  }

  // void assignGender() {
  //   if (int.parse(globalUserMaster?.gender ?? '') == 1) {
  //     genderController.text = "Male";
  //   } else if (int.parse(globalUserMaster?.gender ?? '') == 2) {
  //     genderController.text = "Female";
  //   } else if (int.parse(globalUserMaster?.gender ?? '') == 3) {
  //     genderController.text = "Transgender";
  //   } else if (int.parse(globalUserMaster?.gender ?? '') == 4) {
  //     genderController.text = globalUserMaster?.genderType ?? '';
  //   }
  //   setState(() {});
  // }

  void assignAgeGroup() {
    if (globalUserMaster?.age != null) {
      if (globalUserMaster!.age! >= 9 && globalUserMaster!.age! <= 15) {
        ageGroupController.text = "9-15 Year";
      } else if (globalUserMaster!.age! >= 16 && globalUserMaster!.age! <= 25) {
        ageGroupController.text = "16-25 Year";
      } else if (globalUserMaster!.age! >= 26 && globalUserMaster!.age! <= 45) {
        ageGroupController.text = "26-45 Year";
      } else if (globalUserMaster!.age! >= 46 && globalUserMaster!.age! <= 60) {
        ageGroupController.text = "46-60 Year";
      } else if (globalUserMaster!.age! > 60) {
        ageGroupController.text = "60+ Year";
      }
      // print("Age group is...${ageGroupController.text}");
      setState(() {});
    }
  }

  // Future<void> _generateAndDownloadPdf() async {
  //   final pdf = pw.Document();
  //
  //   // Function to add text field with label and value to PDF
  //   pw.Widget addTextField(String label, String value) {
  //     return pw.Row(
  //       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //       children: [
  //         pw.Expanded(
  //           flex: 1,
  //           child: pw.Text(label + ':', style: pw.TextStyle(fontSize: 20)),
  //         ),
  //         pw.Expanded(
  //           flex: 2,
  //           child: pw.Text(value, style: pw.TextStyle(fontSize: 16)),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   // Add all controller values to the PDF
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text("Monthly Report",
  //                 style: pw.TextStyle(
  //                     color: PdfColors.blue,
  //                     fontSize: 30,
  //                     fontWeight: pw.FontWeight.bold)),
  //             pw.SizedBox(height: 30),
  //             addTextField('Name', nameController.text),
  //             addTextField('Mobile', mobileController.text),
  //             addTextField('Email', emailController.text),
  //             addTextField('Unique ID', uniqueIdController.text),
  //             // addTextField('Gender', genderController.text),
  //             addTextField('Date of Birth', dobController.text),
  //             addTextField('Age', ageController.text),
  //             addTextField('Age Group', ageGroupController.text),
  //             addTextField('Ailments', ailmentsController.text),
  //             addTextField('Medication', medicationController.text),
  //             addTextField('Weight', weightController.text),
  //             addTextField('BMI', bmiController.text),
  //             addTextField('Last Period', lastPeriodController.text),
  //             addTextField('Cycle Length', cycleLengthController.text),
  //             addTextField('Period Length', periodLengthController.text),
  //             addTextField('Staining', stainingController.text),
  //             addTextField('Clot Size', clotSizeController.text),
  //             addTextField('Working Ability', workingAbilityController.text),
  //             addTextField('Location', locationController.text),
  //             addTextField('Period Cramps', periodCrampsController.text),
  //             addTextField('Days', daysController.text),
  //             addTextField('Stress', stressController.text),
  //             addTextField('PMS', pmsController.text),
  //             addTextField('PCO', pcoController.text),
  //             addTextField('Anemia', anemiaController.text),
  //             addTextField('Sleep', sleepController.text),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   // Get external storage directory
  //   final directory = await getExternalStorageDirectory();
  //   final downloadDirectory = '${directory?.path}/Download';
  //
  //   // Check if download directory exists, if not create it
  //   final directoryExists = await Directory(downloadDirectory).exists();
  //   if (!directoryExists) {
  //     await Directory(downloadDirectory).create(recursive: true);
  //   }
  //   // Generate PDF file path
  //   final filePath = '$downloadDirectory/example.pdf';
  //
  //   // Write PDF to file
  //   final File file = File(filePath);
  //   await file.writeAsBytes(await pdf.save());
  //
  //   CommonUtils.showGreenToastMessage("Pdf Download Successfully");
  //   print('PDF file generated and downloaded to: $filePath');
  // }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<LogYourSymptomsModel>(context);
    mMedicationViewModel = Provider.of<MedicationViewModel>(context);
    mAilmentsViewModel = Provider.of<AilmentsViewModel>(context);
    mQuizViewModel = Provider.of<QuizQuestionViewModel>(context);
    mReportViewModel = Provider.of<ReportsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.reports,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Age group",
                controller: ageGroupController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Unique Id",
                controller: uniqueIdController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Name",
                controller: nameController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Mobile",
                controller: mobileController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Email",
                controller: emailController,
              ),
              kCommonSpaceV5,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Age",
                      controller: ageController,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "D.O.B.",
                      controller: dobController,
                    ),
                  ),
                ],
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Average cycle length (days)",
                controller: cycleLengthController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Average period length (days)",
                controller: periodLengthController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Date of last period",
                controller: lastPeriodController,
              ),
              kCommonSpaceV5,
              Text(
                "Flow :",
                style: getAppStyle(
                  color: CommonColors.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kCommonSpaceV5,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Staining",
                      controller: stainingController,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Clot size",
                      controller: clotSizeController,
                    ),
                  ),
                ],
              ),
              kCommonSpaceV5,
              Text(
                "Pain :",
                style: getAppStyle(
                  color: CommonColors.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kCommonSpaceV5,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Working ability",
                      controller: workingAbilityController,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Location",
                      controller: locationController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Period cramps",
                      controller: periodCrampsController,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Days",
                      controller: daysController,
                    ),
                  ),
                ],
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Stress :",
                lblFontSize: 20,
                controller: stressController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "PMS",
                controller: pmsController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "PCO",
                controller: pcoController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Anemia",
                controller: anemiaController,
              ),
              kCommonSpaceV5,
              Text(
                "Track :",
                style: getAppStyle(
                  color: CommonColors.blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Medication",
                controller: medicationController,
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "Ailments",
                controller: ailmentsController,
              ),
              kCommonSpaceV5,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Weight",
                      controller: weightController,
                    ),
                  ),
                  kCommonSpaceH10,
                  Expanded(
                    child: CustomTextFieldContainer(
                      isReadOnly: true,
                      color: primaryColorWithOpacity,
                      labelText: "Sleep",
                      controller: sleepController,
                    ),
                  ),
                ],
              ),
              kCommonSpaceV5,
              CustomTextFieldContainer(
                isReadOnly: true,
                color: primaryColorWithOpacity,
                labelText: "BMI",
                controller: bmiController,
              ),
              kCommonSpaceV20,
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  onPress: () {
                    mReportViewModel.downloadReportPdfApi(
                        name: nameController.text.trim(),
                        mobile: mobileController.text.trim(),
                        email: emailController.text.trim(),
                        uniqueId: uniqueIdController.text.trim(),
                        birthday: dobController.text.trim(),
                        age: ageController.text.trim(),
                        ageGroup: ageGroupController.text.trim(),
                        medication: medicationController.text.trim(),
                        ailments: ailmentsController.text.trim(),
                        weight: weightController.text.trim(),
                        sleep: sleepController.text.trim(),
                        bmi: bmiController.text.trim(),
                        staining: stainingController.text.trim(),
                        clotSize: clotSizeController.text.trim(),
                        workingAbility: workingAbilityController.text.trim(),
                        location: locationController.text.trim(),
                        periodCramps: periodCrampsController.text.trim(),
                        days: daysController.text.trim(),
                        stress: stressController.text.trim(),
                        pms: pmsController.text.trim(),
                        pco: pcoController.text.trim(),
                        anemia: anemiaController.text.trim(),
                        periodLength: periodLengthController.text.trim(),
                        cycleLength: cycleLengthController.text.trim(),
                        lastPeriodDate: lastPeriodController.text.trim());
                  },
                  label: S.of(context)!.download,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

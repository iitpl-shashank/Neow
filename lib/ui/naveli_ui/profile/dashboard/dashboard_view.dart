import 'dart:ffi';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/common_ui/splash/splash_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/sleep/sleep_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/water_reminder/water_reminder_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/profile/dashboard/peroid_table_view.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/global_variables.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../database/app_preferences.dart';
import '../../../../generated/i18n.dart';
import '../../../../models/about_your_cycle_master.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_textfield_container_bmi.dart';
import '../../../../widgets/cycle_info_card.dart';
import '../../../../widgets/number_dropdown.dart';
import '../../../../widgets/pregnancy_dialog.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/stress_log_card.dart';
import '../../../../widgets/symptoms_card.dart';
import '../../home/track/ailments/ailments_view_model.dart';
import '../../home/track/medication/medication_view_model.dart';
import 'dashboard_view_model.dart';
import 'bar_data.dart';
import 'package:naveli_2023/ui/naveli_ui/home/track/weight/weight_view_model.dart';

// import 'package:charts_flutter/flutter.dart' as charts;

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashBoardViewModel mViewModel;
  late MedicationViewModel mMedicationViewModel;
  late AilmentsViewModel mAilmentsViewModel;
  late WeightViewModel mViewModelWeight;
  late SleepViewModel mViewModelSleep; //fetchSleepData;
  late WaterReminderViewModel mViewModelWaterInteke; //fetchSleepData;

  // late MedicationViewModel mViewModelMedication;

  File? selectedImage;
  bool isPersonal = false;
  bool isCycle = false;
  bool symp = false;
  bool track = false;
  bool bodyq = false;
  bool oth = false;
  String imagePath = "";
  int? selectedRelation;
  int? selectedCycleLength = 0;
  int? selectedPeriodsLength = 0;
  Color primaryColorWithOpacity = CommonColors.mWhite;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ageGroupController = TextEditingController();
  TextEditingController relationshipStatusController = TextEditingController();
  TextEditingController medicalConditionController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  TextEditingController lastPeriodController = TextEditingController();
  TextEditingController cycleLengthController = TextEditingController();
  TextEditingController periodLengthController = TextEditingController();
  TextEditingController forumInterestController = TextEditingController();
  List<String> forumInterestList = [];

  final _formKey = GlobalKey<FormState>();
  bool hotFlushes = false;
  bool tiredness = false;
  bool moodSwings = false;
  bool vaginalDryness = false;
  bool decreasedLibido = false;
  bool jointPain = false;
  String kidsCount = '';
  bool tryingToGetPregnant = false;
  bool papSmear = false;
  bool periodsLastYear = false;
  bool postMenopausalBleeding = false;
  int? selectedItem;

  final List<int> items = [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];

  List<BarData> barData = [
    BarData(
      ydata: '28',
      xdata: 1,
      // barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarData(
      ydata: '28',
      xdata: 2,
      // barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];

  List<BarData> SleepBarData = [];
  List<BarData> WaterInteke = [];

  // Helper function to convert sleep time string into minutes

// Function to find the difference between two times
  int getTimeDifference(String badTime, String wakeUpTime) {
    // Define time format
    DateFormat timeFormat = DateFormat("h:mm a");

    // Parse the time strings into DateTime objects
    DateTime badTimeParsed = timeFormat.parse(badTime);
    DateTime wakeUpTimeParsed = timeFormat.parse(wakeUpTime);

    // Adjust for AM/PM difference
    if (wakeUpTimeParsed.isBefore(badTimeParsed)) {
      // Add one day to wakeUpTime if it's before badTime (indicating it's on the next day)
      wakeUpTimeParsed = wakeUpTimeParsed.add(Duration(days: 1));
    }

    // Calculate the difference
    Duration difference = wakeUpTimeParsed.difference(badTimeParsed);
    print(difference);
    print("difference===================");

    return difference.inHours;
  }

  List<Map<String, dynamic>> calculateMonthlyAverages(
      List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> result = [];

    for (var monthData in data) {
      String month = monthData['month'];
      int sleepDuration = 0;
      int totalSleepMinutes = 0;
      int count = 0;
      // Loop through each sleep entry in the month's data
      for (var entry in monthData['data']) {
        RegExp hourRegExp = RegExp(r'(\d+)Hr');
        // Match the hours
        Match? hourMatch = hourRegExp.firstMatch(entry['total_sleep_time']);
        if (hourMatch != null) {
          // Extract and print the hours
          String hourStr = hourMatch.group(1)!;
          sleepDuration = int.parse(hourStr);
          totalSleepMinutes += sleepDuration;
          count++;
        }
      }

      // Calculate the average in minutes
      // if (count > 0) {
      int averageMinutes = totalSleepMinutes ~/
          count; // Total minutes divided by count, floor division
      print(averageMinutes.toInt());
      print("==================================averageHours");
      result.add({
        'month': '30',
        'average_sleep': averageMinutes.toInt() // Now showing hours only
      });
    }

    return result;
  }

  Future<void> setBarData() async {
    print("============================  setBarData");

    // Fetch sleep data
    await mViewModelSleep.fetchSleepData();
    await Future.delayed(Duration(seconds: 2));

    print(mViewModelSleep.sleeptHistory);
    print("============================  v mViewModelSleep.sleeptHistory");
    // Ensure the sleepData is not null and has been fetched correctly
    if (mViewModelSleep.sleeptHistory != null) {
      // Calculate the averages after fetching data
      List<Map<String, dynamic>> averages = calculateMonthlyAverages(
          List<Map<String, dynamic>>.from(mViewModelSleep.sleeptHistory));

      // Now add data to SleepBarData
      for (var avg in averages) {
        int averageSleepInHours = avg['average_sleep'];
        // average hours
        print(averageSleepInHours);
        print("================averageSleepInHours");
        // Add the data to SleepBarData
        setState(() {
          SleepBarData.add(
              BarData(ydata: avg['month'], xdata: averageSleepInHours.toInt()));
        });
      }

      // Optionally, you could call another function here that depends on the updated SleepBarData
      // If you want to do something after updating SleepBarData, just call it below.
      await processAfterBarDataUpdate();
    }

    var data = await mViewModelWaterInteke.fetchWaterHistory();
    await Future.delayed(Duration(seconds: 2));
    print(data);
    print("================  data");

    if (data.length != null) {
      // Calculate the averages after fetching data
      // Now add data to SleepBarData
      for (var value in data) {
        int intValue = int.parse(value['water_ml']);
        // average hours

        double mainValue = (intValue / 250);

        print(mainValue.toInt());
        int valueFinal = mainValue.toInt();

        setState(() {
          WaterInteke.add(BarData(
            ydata: valueFinal.toString(), // Water intake in ml (integer)
            xdata: valueFinal, // Numeric representation of the date (int)
          ));
        });
      }

      // Optionally, you could call another function here that depends on the updated SleepBarData
      // If you want to do something after updating SleepBarData, just call it below.
      await processAfterBarDataUpdate();
    }
  }

  Future<void> processAfterBarDataUpdate() async {
    // Function that processes after SleepBarData has been updated
    print('Processing data after SleepBarData update...');
    // Add your logic here for further actions
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mViewModel.initializeRelationshipStatusList(context);

      mViewModel.attachedContext(context);
      mViewModel.getUserInfo();
      mViewModel.getAboutYourCycle();
      mMedicationViewModel.attachedContext(context);
      mAilmentsViewModel.attachedContext(context);
      mViewModelWeight.attachedContext(context);
      mViewModelSleep.attachedContext(context);
      mViewModelSleep.fetchSleepData();

      //User report data
      mViewModel.getUserSymptoms();
      mViewModel.getUserVaccinationInfo();
      mViewModel.getUserPersonalInformation();

      // setBarData();
      mViewModelWeight.fetchWeightData();
      mAilmentsViewModel.getStoredAilmentsListApi(false);
      if (gUserType == AppConstants.NEOWME ||
          gUserType == AppConstants.CYCLE_EXPLORER) {
        CommonUtils.showProgressDialog();
        SplashViewModel().getUserDetails().whenComplete(() {
          CommonUtils.hideProgressDialog();
          assignGender();
          assignMaritalStatus();
          assignAgeGroup();
          print("==================================================== City");
          print(globalUserMaster?.city);
          print(globalUserMaster?.state);

          print("====================================================State");

          loadForumInterestList().whenComplete(() {
            var selectedOptions = forumInterestList.toString();
            selectedOptions =
                selectedOptions.substring(1, selectedOptions.length - 1);
            forumInterestController.text = selectedOptions;
          });
          nameController.text = globalUserMaster?.name ?? '';
          mobileController.text = globalUserMaster?.mobile ?? '';
          emailController.text = globalUserMaster?.email ?? '';
          uniqueIdController.text = globalUserMaster?.uuId ?? '';
          dobController.text = globalUserMaster?.birthdate ?? '';
          ageController.text = "${globalUserMaster?.age} Year";
          stateController.text = mViewModel.userInfo.state;
          districtController.text = mViewModel.userInfo.city;

          if (globalUserMaster?.relationshipStatus == '1') {
            relationshipStatusController.text = "Solo";
          } else if (globalUserMaster?.relationshipStatus == '2') {
            relationshipStatusController.text = "Tied";
          } else if (globalUserMaster?.relationshipStatus == '3') {
            relationshipStatusController.text = "Open for surprise";
          }
          mMedicationViewModel.userPreviousMedication.clear();
          mMedicationViewModel.storedOtherMedicineList.clear();
          mAilmentsViewModel.userPreviousAilments.clear();
          mAilmentsViewModel.storedOtherAilmentsList.clear();
          medicationController.clear();
          medicalConditionController.clear();

          mAilmentsViewModel.getStoredAilmentsListApi(false).whenComplete(() {
            var ailments = mAilmentsViewModel.userPreviousAilments.toString();
            ailments = ailments.substring(1, ailments.length - 1);
            var otherAilments =
                mAilmentsViewModel.storedOtherAilmentsList.toString();
            otherAilments =
                otherAilments.substring(1, otherAilments.length - 1);
            medicalConditionController.text = "$ailments  $otherAilments";
          });
          if (globalUserMaster?.weight != null) {
            weightController.text = "${globalUserMaster?.weight} Kg";
          }
          if (globalUserMaster?.bmiScore != null &&
              globalUserMaster?.bmiType != null) {
            bmiController.text =
                "${globalUserMaster?.bmiScore} - ${globalUserMaster?.bmiType}";
          }
          cycleLengthController.text =
              globalUserMaster?.averageCycleLength ?? '28';
          lastPeriodController.text =
              "${globalUserMaster?.previousPeriodsBegin ?? ''} ${globalUserMaster?.previousPeriodsMonth ?? ''}";
          periodLengthController.text =
              globalUserMaster?.averagePeriodLength ?? '';
        });
      }
    });
    // Future.delayed(Duration.zero, () {});
    super.initState();
  }

  void assignGender() {
    if (int.parse(globalUserMaster?.gender ?? '') == 1) {
      genderController.text = "Male";
    } else if (int.parse(globalUserMaster?.gender ?? '') == 2) {
      genderController.text = "Female";
    } else if (int.parse(globalUserMaster?.gender ?? '') == 3) {
      genderController.text = "Transgender";
    } else if (int.parse(globalUserMaster?.gender ?? '') == 4) {
      genderController.text = globalUserMaster?.genderType ?? '';
    }
    setState(() {});
  }

  void assignMaritalStatus() {
    if (int.parse(globalUserMaster?.relationshipStatus ?? '') == 1) {
      maritalStatusController.text = "Solo";
    } else if (int.parse(globalUserMaster?.relationshipStatus ?? '') == 2) {
      maritalStatusController.text = "Tied";
    } else if (int.parse(globalUserMaster?.relationshipStatus ?? '') == 3) {
      maritalStatusController.text = "Open for surprise";
    }
    setState(() {});
  }

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

  Future<void> loadForumInterestList() async {
    forumInterestList =
        await AppPreferences.instance.getInterestFavourite() ?? [];
    // forumInterestList = List.from(forumInterestList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<DashBoardViewModel>(context);
    mMedicationViewModel = Provider.of<MedicationViewModel>(context);
    mAilmentsViewModel = Provider.of<AilmentsViewModel>(context);
    mViewModelWeight = Provider.of<WeightViewModel>(context);
    mViewModelSleep = Provider.of<SleepViewModel>(context);
    mViewModelWaterInteke = Provider.of<WaterReminderViewModel>(context);

    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.myHealthReports,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () {
                    // push(CalendarView());
                  }),
            ],
          ),
          body: SingleChildScrollView(
            padding: kCommonScreenPadding,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CommonColors.blueShade,
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: CommonColors.blackColor))),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isPersonal = !isPersonal;
                          isCycle = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(LocalImages.imgPersonalInformation,
                                  height: 25),
                              kCommonSpaceH10,
                              Text(
                                S.of(context)!.personalInformation,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CommonColors.blackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                if (isPersonal)
                  Consumer<DashBoardViewModel>(
                      builder: (context, vModel, child) {
                    return Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 20,
                      ),
                      color: Color(0xFFF5F5F5),
                      child: Column(
                        children: [
                          CustomTextFieldContainer(
                            textColor: CommonColors.blackColor,
                            color: Color(0xFFF5F5F5),
                            labelText: S.of(context)!.name,
                            controller: vModel.userNameController,
                            border: true,
                          ),
                          kCommonSpaceV5,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldContainer(
                                  color: Color(0xFFF5F5F5),
                                  labelText: S.of(context)!.gender,
                                  controller: TextEditingController(
                                      text: vModel.getUsergender()),
                                  isReadOnly: true,
                                  border: false,
                                ),
                              ),
                              kCommonSpaceH10,
                              Expanded(
                                child: CustomTextFieldContainer(
                                  color: Color(0xFFF5F5F5),
                                  labelText: S.of(context)!.age,
                                  controller: TextEditingController(
                                      text:
                                          "${vModel.userAgeController.text} ${S.of(context)!.years}"),
                                  isReadOnly: true,
                                  border: false,
                                ),
                              ),
                            ],
                          ),
                          kCommonSpaceV5,
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFieldContainer(
                                  color: Color(0xFFF5F5F5),
                                  labelText: S.of(context)!.state,
                                  controller: vModel.userStateController,
                                  isReadOnly: true,
                                  border: true,
                                  isDropDown: true,
                                  dropDownItems: vModel.allStateList
                                      .map((e) => e.name ?? "")
                                      .toList(),
                                  onItemSelected: (selectedState) {
                                    vModel.userStateController.text =
                                        selectedState;
                                    vModel.updateUserState(selectedState);
                                    vModel.getCityList(
                                      stateId: vModel.getStateId(selectedState),
                                    );
                                    vModel.userCityController.text = "";
                                  },
                                ),
                              ),
                              kCommonSpaceH10,
                              Expanded(
                                child: CustomTextFieldContainer(
                                  color: Color(0xFFF5F5F5),
                                  labelText: S.of(context)!.district,
                                  controller: vModel.userCityController,
                                  isReadOnly: true,
                                  border: true,
                                  isDropDown: true,
                                  dropDownItems: vModel.allCityList
                                      .map((e) => e.name ?? "")
                                      .toList(),
                                  onItemSelected: (selectedState) {
                                    vModel.userCityController.text =
                                        selectedState;
                                    vModel.updateUserCity(selectedState);
                                  },
                                ),
                              ),
                            ],
                          ),
                          kCommonSpaceV5,
                          CustomTextFieldContainer(
                            color: Color(0xFFF5F5F5),
                            labelText: S.of(context)!.phoneNumber,
                            controller: vModel.userMobileController,
                            // TODO : phone number changable ?
                            isReadOnly: true,
                            textColor: CommonColors.blackColor,
                            border: false,
                          ),
                          kCommonSpaceV5,
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: CommonColors.mGrey201,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextFieldContainer(
                                    color: Color(0xFFF5F5F5),
                                    labelText: S.of(context)!.email,
                                    controller: vModel.userEmailController,
                                    border: false,
                                    textColor: CommonColors.blackColor,
                                    isReadOnly: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceV10,
                          CustomTextFieldContainer(
                            color: Color(0xFFF5F5F5),
                            labelText: S.of(context)!.dateOfBirth,
                            controller: vModel.userBirthDateController,
                            isReadOnly: true,
                            border: false,
                            onTap: () async {
                              DateTime initialDate;
                              try {
                                initialDate = vModel
                                        .userBirthDateController.text.isNotEmpty
                                    ? DateFormat('yyyy-MM-dd').parse(
                                        vModel.userBirthDateController.text)
                                    : DateTime.now();
                              } catch (e) {
                                initialDate = DateTime.now();
                              }
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
                                vModel.userBirthDateController.text =
                                    formattedDate;
                                vModel.updateUserBirthDate(formattedDate);
                                vModel.calculateAge(dateOfBirth: formattedDate);
                                vModel.getUserAgeGroup(
                                  age: int.parse(
                                    vModel.userAgeController.text,
                                  ),
                                );
                              }
                            },
                          ),
                          kCommonSpaceV5,
                          CustomTextFieldContainer(
                            color: Color(0xFFF5F5F5),
                            labelText: S.of(context)!.ageGroup,
                            controller: vModel.userAgeGroupController,
                            isReadOnly: true,
                            border: false,
                          ),
                          kCommonSpaceV5,
                          CustomTextFieldContainer(
                            color: Color(0xFFF5F5F5),
                            labelText: S.of(context)!.relationshipStatus,
                            controller: vModel.userRelationController,
                            isReadOnly: true,
                            border: true,
                            isDropDown: true,
                            dropDownItems:
                                vModel.relationshipStatusList.toList(),
                            onItemSelected: (selectedState) {
                              vModel.userRelationController.text =
                                  selectedState;
                              vModel.updateRelationshipStatus(selectedState);
                            },
                          ),
                          if (gUserType == AppConstants.CYCLE_EXPLORER)
                            kCommonSpaceV5,
                          if (gUserType == AppConstants.CYCLE_EXPLORER)
                            CustomTextFieldContainer(
                              textColor: CommonColors.blackColor,
                              color: Color(0xFFF5F5F5),
                              labelText: S.of(context)!.profession,
                              controller: vModel.userProfessionController,
                              border: true,
                            ),
                          kCommonSpaceV5,
                          kCommonSpaceV20,
                          PrimaryButton(
                            width: kDeviceWidth / 2,
                            onPress: () {
                              mViewModel.updateUserPersonalInformation();
                            },
                            label: S.of(context)!.update,
                          ),
                        ],
                      ),
                    );
                  }),
                kCommonSpaceV20,
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFFFF1F1),
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: CommonColors.blackColor))),
                    child: InkWell(
                      onTap: () {
                        // CommonUtils.showProgressDialog();
                        setState(() {
                          isPersonal = false;
                          isCycle = !isCycle;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(LocalImages.imgAboutYourCycle,
                                  height: 25),
                              kCommonSpaceH10,
                              Text(
                                S.of(context)!.aboutYouCycle,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CommonColors.blackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                if (isCycle && mViewModel.dataList.isNotEmpty)
                  IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                        right: 10,
                        bottom: 20,
                      ),
                      color: CommonColors.mGrey200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wrap the Table in a vertical SingleChildScrollView
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 600,
                                child: Table(
                                  border: TableBorder.all(
                                    width: 0.5,
                                    color: const Color.fromARGB(255, 128, 127,
                                        127), // Border color for the entire table
                                  ),
                                  children: [
                                    // Header Row with Background Color
                                    TableRow(
                                      decoration: BoxDecoration(
                                          // Background color for header row
                                          ),
                                      children: [
                                        _tableCell(
                                            'No.',
                                            CommonColors.primaryColor
                                                .withOpacity(0.5)),
                                        _tableCell(
                                            'Period Date (start-end)',
                                            CommonColors.primaryColor
                                                .withOpacity(0.2)),
                                        _tableCell(
                                            'Cycle Length (days)',
                                            CommonColors.primaryColor
                                                .withOpacity(0.5)),
                                        _tableCell(
                                            'Deviation (days)',
                                            CommonColors.primaryColor
                                                .withOpacity(0.5)),
                                        _tableCell(
                                            'Interpretation',
                                            CommonColors.primaryColor
                                                .withOpacity(0.2)),
                                        _tableCell(
                                            'Period Length (days)',
                                            CommonColors.primaryColor
                                                .withOpacity(0.2)),
                                        _tableCell(
                                            'Deviation (days)',
                                            CommonColors.primaryColor
                                                .withOpacity(0.5)),
                                        _tableCell(
                                            'Interpretation',
                                            CommonColors.primaryColor
                                                .withOpacity(0.2)),
                                      ],
                                    ),
                                    // Data Rows
                                    for (int index = 0;
                                        index < mViewModel.dataList.length;
                                        index++)
                                      TableRow(
                                        children: [
                                          _tableCell((index + 1).toString(),
                                              CommonColors.mWhite),
                                          _tableCell(
                                              mViewModel.dataList[index]
                                                      .periodDate ??
                                                  '',
                                              CommonColors.mWhite),
                                          _tableCell(
                                              mViewModel.dataList[index]
                                                      .periodCycleLength ??
                                                  '',
                                              CommonColors.mWhite),
                                          _tableCell(
                                              (mViewModel.dataList[index]
                                                          .cycleLengthDeviation ??
                                                      0)
                                                  .toString(),
                                              CommonColors.mWhite),
                                          TableCell(
                                            child: Container(
                                              color: CommonColors.mWhite,
                                              height: 70,
                                              width: 120,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: !(mViewModel
                                                          .dataList[index]
                                                          .cycleLengthInterpretation ??
                                                      true)
                                                  ? Icon(Icons.warning_rounded,
                                                      color: Colors.red,
                                                      size: 25)
                                                  : Icon(Icons.thumb_up,
                                                      color: Colors.green,
                                                      size: 25),
                                            ),
                                          ),
                                          _tableCell(
                                              mViewModel.dataList[index]
                                                      .periodLength ??
                                                  '',
                                              CommonColors.mWhite),
                                          _tableCell(
                                              (mViewModel.dataList[index]
                                                          .periodLengthDeviation ??
                                                      0)
                                                  .toString(),
                                              CommonColors.mWhite),
                                          TableCell(
                                            child: Container(
                                              color: CommonColors.mWhite,
                                              height: 70,
                                              width: 120,
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: !(mViewModel
                                                          .dataList[index]
                                                          .periodLengthInterpretation ??
                                                      true)
                                                  ? Icon(Icons.warning_rounded,
                                                      color: Colors.red,
                                                      size: 25)
                                                  : Icon(Icons.thumb_up,
                                                      color: Colors.green,
                                                      size: 25),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          kCommonSpaceV20,
                          CycleInfoCard(),
                          kCommonSpaceV20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Last 3 Peroids",
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Duration",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 139, 134, 134),
                                  fontSize: 12,
                                ),
                              ),
                              kCommonSpaceV10,
                              Container(
                                height: 400,
                                color: Colors.white,
                                padding: EdgeInsets.all(25),
                                child: LineChart(
                                  LineChartData(
                                    lineTouchData: LineTouchData(
                                      handleBuiltInTouches:
                                          true, // Enables tap/touch
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipRoundedRadius: 8,
                                        fitInsideHorizontally: true,
                                        fitInsideVertically: true,
                                        getTooltipItems: (touchedSpots) {
                                          return touchedSpots
                                              .map((touchedSpot) {
                                            const monthNames = [
                                              '', // index 0 is unused to align 1-based month numbers
                                              'Jan', 'Feb', 'Mar', 'Apr', 'May',
                                              'Jun',
                                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov',
                                              'Dec'
                                            ];

                                            String monthLabel = '';
                                            if (touchedSpot.x >= 1 &&
                                                touchedSpot.x <= 12) {
                                              monthLabel = monthNames[
                                                  touchedSpot.x.toInt()];
                                            }
                                            return LineTooltipItem(
                                              'Month: ${monthLabel}\nCycle Length: ${touchedSpot.y.toStringAsFixed(0)}',
                                              const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                    gridData: FlGridData(show: false),
                                    // Hide grid lines
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles:
                                              true, // Hide left titles (labels)
                                          reservedSize: 15,
                                          interval: 5,
                                          getTitlesWidget: (value, meta) {
                                            return Text(
                                              value.toStringAsFixed(0),
                                              // Format Y-axis values
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          getTitlesWidget: (data, meta) {
                                            const monthNames = [
                                              '', // index 0 is unused to align 1-based month numbers
                                              'Jan', 'Feb', 'Mar', 'Apr', 'May',
                                              'Jun',
                                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov',
                                              'Dec'
                                            ];

                                            String monthLabel = '';
                                            if (data >= 1 && data <= 12) {
                                              monthLabel =
                                                  monthNames[data.toInt()];
                                            }

                                            return Text(
                                              monthLabel,
                                              // Format X-axis values
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            );
                                          },
                                          reservedSize: 26,
                                          showTitles:
                                              true, // Hide bottom titles (labels)
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                        // Hide top titles if any
                                        sideTitles: SideTitles(
                                          showTitles:
                                              false, // Hide top titles (labels)
                                        ),
                                      ),
                                      rightTitles: AxisTitles(
                                        // Hide right titles if any
                                        sideTitles: SideTitles(
                                          showTitles:
                                              false, // Hide right titles (labels)
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 204, 207, 209),
                                        width: 0.5,
                                      ),
                                    ),
                                    minX: 0,
                                    maxX: 5,
                                    minY: 0,
                                    maxY: 45,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: mViewModel.scaledSpots,
                                        isCurved: true,
                                        color: CommonColors.primaryColor
                                            .withOpacity(0.2),
                                        dotData: FlDotData(
                                            show: true,
                                            getDotPainter:
                                                (value, data, bardata, index) {
                                              return FlDotCirclePainter(
                                                radius: 4,
                                                color: CommonColors.primaryColor
                                                    .withOpacity(0.2),
                                                strokeWidth: 2,
                                                strokeColor: CommonColors
                                                    .primaryColor
                                                    .withOpacity(0.2),
                                              );
                                            }),
                                        belowBarData: BarAreaData(
                                          show: false,
                                          color: CommonColors.primaryColor
                                              .withOpacity(
                                                  0.2), // Color below the line
                                        ),
                                        aboveBarData: BarAreaData(
                                          show: false,
                                          color: Colors.blue.withOpacity(
                                              0.8), // Color above the line
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              kCommonSpaceV10,
                            ],
                          ),
                          // Add more widgets if needed (e.g. LineChart or additional content)
                        ],
                      ),
                    ),
                  ),
                kCommonSpaceV20,
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFEAF6FF),
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: CommonColors.blackColor))),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          symp = !symp;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              /*Icon(
                                Icons.featured_play_list_outlined,
                                color: CommonColors.blackColor,
                                size: 25,
                              ),*/
                              Image.asset(LocalImages.imgSymptons, height: 25),
                              kCommonSpaceH10,
                              Text(
                                S.of(context)!.symptoms,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CommonColors.blackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                if (symp)
                  Container(
                    color: CommonColors.mGrey200,
                    child: Consumer<DashBoardViewModel>(
                        builder: (context, vModel, child) {
                      if (vModel.userReportList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No data available. Please log your symptoms.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                color: CommonColors.mGrey200,
                                child: Consumer<DashBoardViewModel>(
                                  builder: (context, vModel, child) {
                                    List userReports =
                                        vModel.userReportList.reversed.toList();

                                    List latestReports =
                                        userReports.take(5).toList();

                                    return SymptomsCard(
                                      title: S.of(context)!.flow,
                                      symptoms: latestReports.reversed
                                          .toList()
                                          .map((report) =>
                                              "${report.flow} (${report.month})")
                                          .toList(),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                color: CommonColors.mGrey200,
                                child: Consumer<DashBoardViewModel>(
                                  builder: (context, vModel, child) {
                                    List userReports =
                                        vModel.userReportList.reversed.toList();

                                    List latestReports =
                                        userReports.take(5).toList();

                                    return SymptomsCard(
                                      title: S.of(context)!.pain,
                                      symptoms: latestReports.reversed
                                          .toList()
                                          .map((report) =>
                                              "${report.pain} (${report.month})")
                                          .toList(),
                                    );
                                  },
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                child: Consumer<DashBoardViewModel>(
                                  builder: (context, vModel, child) {
                                    List<StressLog> stressLogs = [];
                                    for (var monthlyScore
                                        in vModel.userReportList) {
                                      for (var log in monthlyScore.logs ?? []) {
                                        for (var logDate
                                            in log.logDates ?? []) {
                                          stressLogs.add(StressLog(
                                            level: logDate.stress ?? 'No Data',
                                            date: logDate.date ?? '',
                                          ));
                                        }
                                      }
                                    }
                                    stressLogs.sort(
                                        (a, b) => b.date.compareTo(a.date));
                                    if (stressLogs.length > 5) {
                                      stressLogs = stressLogs.take(5).toList();
                                    }
                                    return StressLogCard(
                                      title: S.of(context)!.stress,
                                      logs: stressLogs,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                color: CommonColors.mGrey200,
                                child: Consumer<DashBoardViewModel>(
                                  builder: (context, vModel, child) {
                                    List userReports =
                                        vModel.userReportList.reversed.toList();

                                    List latestReports =
                                        userReports.take(5).toList();

                                    return SymptomsCard(
                                      title: S.of(context)!.acne,
                                      symptoms: latestReports.reversed
                                          .toList()
                                          .map((report) =>
                                              "${report.acne} (${report.month})")
                                          .toList(),
                                    );
                                  },
                                ),
                              ),
                              // TODO : Ovulation not coming in api response
                              // Container(
                              //   padding: const EdgeInsets.only(
                              //     left: 10,
                              //     right: 10,
                              //     bottom: 20,
                              //   ),
                              //   color: CommonColors.mGrey200,
                              //   child: SymptomsCard(
                              //     // TODO : Ovulation not coming in api response
                              //     title: 'Ovulation',
                              //     symptoms: [
                              //       "${report.stress} (${report.month})"
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                kCommonSpaceV20,
                // TODO  Track is hidden now in profile
                // Container(
                //     padding: const EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //         color: Color(0xFFFFFBED),
                //         border: Border(
                //             bottom: BorderSide(
                //                 width: 1, color: CommonColors.blackColor))),
                //     child: InkWell(
                //       onTap: () {
                //         setState(() {
                //           track = !track;
                //         });
                //       },
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Image.asset(LocalImages.imgTrack, height: 25),
                //               kCommonSpaceH10,
                //               Text(
                //                 S.of(context)!.track,
                //                 style: TextStyle(
                //                   color: CommonColors.blackColor,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Icon(
                //             Icons.keyboard_arrow_down,
                //             color: CommonColors.blackColor,
                //             size: 25,
                //           ),
                //         ],
                //       ),
                //     )),
                // if (track)
                //   Container(
                //     padding: const EdgeInsets.only(
                //       top: 20,
                //       left: 10,
                //       right: 10,
                //       bottom: 20,
                //     ),
                //     color: CommonColors.mGrey200,
                //     child: Column(
                //       children: [
                //         //  mViewModelMedication.storedOtherMedicineList

                //         for (int index = 0;
                //             index <
                //                 mAilmentsViewModel
                //                     .storedOtherAilmentsList.length;
                //             index++)
                //           _track(
                //               context,
                //               'Medication',
                //               mAilmentsViewModel.storedOtherAilmentsList[index]
                //                   .toString(),
                //               '',
                //               '',
                //               LocalImages.img_pill,
                //               '0.50mg, once a day, 5 month course'),
                //         _track(
                //             context,
                //             'Prescription',
                //             'Thyroid prescription.jpg',
                //             LocalImages.view,
                //             LocalImages.download,
                //             '',
                //             ''),
                //         _weight_bmi(context, 'Weight & BMI',
                //             mViewModelWeight.weightHistory),
                //         kCommonSpaceV20,
                //         Text(
                //           'Sleep Cycle Overview',
                //           style: getAppStyle(
                //             color: const Color.fromARGB(255, 0, 0, 0),
                //             fontSize: 14,
                //           ),
                //         ),
                //         kCommonSpaceV20,
                //         SleepBarData.length != 0
                //             ? SizedBox(
                //                 height: 160,
                //                 child: BarChart(
                //                   BarChartData(
                //                     borderData: FlBorderData(
                //                       border: const Border(
                //                         top: BorderSide.none,
                //                         right: BorderSide.none,
                //                         left: BorderSide(width: 1),
                //                         bottom: BorderSide(width: 1),
                //                       ),
                //                     ),
                //                     groupsSpace: 10,
                //                     barGroups: [
                //                       for (var bdata in SleepBarData)
                //                         BarChartGroupData(
                //                           x: bdata.xdata,
                //                           barRods: [
                //                             BarChartRodData(
                //                               fromY: 0,
                //                               toY: double.parse(bdata.ydata),
                //                               width: 15,
                //                               color: const Color.fromARGB(
                //                                   255, 111, 64, 133),
                //                               borderRadius: BorderRadius
                //                                   .zero, // Remove radius by setting to zero
                //                             ),
                //                           ],
                //                         ),
                //                     ],
                //                   ),
                //                 ),
                //               )
                //             : kCommonSpaceV20,
                //         kCommonSpaceV20,
                //         kCommonSpaceV20,
                //         Text(
                //           'Water Intake',
                //           style: getAppStyle(
                //             color: const Color.fromARGB(255, 0, 0, 0),
                //             fontSize: 14,
                //           ),
                //         ),
                //         kCommonSpaceV20,
                //         WaterInteke.length != 0
                //             ? SizedBox(
                //                 height: 160,
                //                 child: BarChart(
                //                   BarChartData(
                //                     borderData: FlBorderData(
                //                         border: const Border(
                //                       top: BorderSide.none,
                //                       right: BorderSide.none,
                //                       left: BorderSide(width: 1),
                //                       bottom: BorderSide(width: 1),
                //                     )),
                //                     groupsSpace: 10,
                //                     barGroups: [
                //                       for (var bdata in WaterInteke)
                //                         BarChartGroupData(
                //                           x: bdata
                //                               .xdata, // Use a numeric index for X-axis
                //                           barRods: [
                //                             BarChartRodData(
                //                               fromY: 0,
                //                               toY: int.parse(bdata.ydata)
                //                                   .toDouble(),
                //                               // Water intake value
                //                               width: 15,
                //                               color: const Color.fromARGB(
                //                                   255, 111, 64, 133),
                //                               borderRadius: BorderRadius.zero,
                //                             ),
                //                           ],
                //                         ),
                //                     ],
                //                   ),
                //                 ),
                //               )
                //             : kCommonSpaceV20,
                //         kCommonSpaceV20,
                //       ],
                //     ),
                //   ),
                // kCommonSpaceV20,
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFF8FFF0),
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: CommonColors.blackColor))),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bodyq = !bodyq;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              /*Icon(
                                Icons.sensor_occupied,
                                color: CommonColors.blackColor,
                                size: 25,
                              ),*/
                              Image.asset(LocalImages.imgBodyQuiz, height: 25),
                              kCommonSpaceH10,
                              Text(
                                S.of(context)!.quickQuestion,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CommonColors.blackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                if (bodyq)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    color: CommonColors.mGrey200,
                    child: Column(
                      children: [
                        _quizCell(
                            context, 'PMC', 'Minimal or no PMS symptoms.'),
                        _quizCell(context, 'PCO', 'Moderate PCO symptoms.'),
                        _quizCell(context, 'Anaemia', 'Severe symptoms.'),
                        _quizCell(context, 'Mental Health',
                            'Heavy Menstrual Bleeding'),
                      ],
                    ),
                  ),
                kCommonSpaceV20,
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFF0EBFF),
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: CommonColors.blackColor))),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          oth = !oth;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              /*Icon(
                                Icons.vaccines,
                                color: CommonColors.blackColor,
                                size: 25,
                              ),*/
                              Image.asset(LocalImages.imgVaccination,
                                  height: 25),
                              kCommonSpaceH10,
                              Text(
                                S.of(context)!.vaccination,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: CommonColors.blackColor,
                            size: 25,
                          ),
                        ],
                      ),
                    )),
                if (oth)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    color: CommonColors.mGrey200,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _text(S.of(context)!.atWhatAgeFirstPeriod, 14),
                          kCommonSpaceV10,
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Background color of the dropdown box
                                borderRadius: BorderRadius.circular(8),
                                // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.0), // Shadow color
                                    blurRadius: 6, // How blurred the shadow is
                                    offset: Offset(0,
                                        2), // Shadow position (downward offset)
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Consumer<DashBoardViewModel>(
                                  builder: (context, vModel, child) {
                                    return DropdownButton<int>(
                                      value: vModel.userAge,
                                      hint: Text(
                                        S.of(context)!.ageYrs,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color.fromARGB(
                                              255, 5, 5, 5),
                                        ),
                                      ),
                                      isExpanded: true,
                                      onChanged: (int? newValue) {
                                        vModel.updateUserAge(newValue ?? 0);
                                      },
                                      items: items.map<DropdownMenuItem<int>>(
                                          (int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          kCommonSpaceV20,
                          _text(S.of(context)!.cervicalCancerVaccine, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Wrap(
                              children: [
                                _radioBtn(
                                  S.of(context)!.dose1,
                                  1,
                                  vModel.isUserVaccinated,
                                  (value) {
                                    vModel.updateVaccinationStatus(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.dose2,
                                  2,
                                  vModel.isUserVaccinated,
                                  (value) {
                                    vModel.updateVaccinationStatus(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.none,
                                  0,
                                  vModel.isUserVaccinated,
                                  (value) {
                                    vModel.updateVaccinationStatus(
                                        value!); // Update to None
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.hpvVaccine, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Wrap(
                              children: [
                                _radioBtn(
                                  S.of(context)!.dose1,
                                  1,
                                  vModel.isUserHpvVaccinated,
                                  (value) {
                                    vModel.updateHpvVaccinationStatus(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.dose2,
                                  2,
                                  vModel.isUserHpvVaccinated,
                                  (value) {
                                    vModel.updateHpvVaccinationStatus(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.dose3,
                                  3,
                                  vModel.isUserHpvVaccinated,
                                  (value) {
                                    vModel.updateHpvVaccinationStatus(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.none,
                                  0,
                                  vModel.isUserHpvVaccinated,
                                  (value) {
                                    vModel.updateHpvVaccinationStatus(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.doYouHaveKids, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Wrap(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.haveKids,
                                  (value) {
                                    vModel.updateHaveKids(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.haveKids,
                                  (value) {
                                    vModel.updateHaveKids(value!);
                                  },
                                ),
                                if (vModel.haveKids == 1) SizedBox(width: 20),
                                if (vModel.haveKids == 1) NumberDropdown(),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.areYouPregnant, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.isPregnant,
                                  (value) {
                                    vModel.updateIsPregnant(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.isPregnant,
                                  (value) {
                                    vModel.updateIsPregnant(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => const PregnancyDialog(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  LocalSvgs.womanFeeding,
                                  height: 22,
                                  width: 22,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context)!.switchtoPregnancyMode,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: CommonColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kCommonSpaceV20,
                          _text(S.of(context)!.areYouTryingToGetPregnant, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.tryPregnant,
                                  (value) {
                                    vModel.updateTryPregnant(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.tryPregnant,
                                  (value) {
                                    vModel.updateTryPregnant(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.tryingSince12MonthsOrMore, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.willPregnant,
                                  (value) {
                                    vModel.updateWillPregnant(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.willPregnant,
                                  (value) {
                                    vModel.updateWillPregnant(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.ifYouAre21YearsOrMore, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.papSmear,
                                  (value) {
                                    vModel.updatePapSmear(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.papSmear,
                                  (value) {
                                    vModel.updatePapSmear(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.ifYouAre50YearsOrMore, 14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.hadPeriod,
                                  (value) {
                                    vModel.updateHadPeriod(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.hadPeriod,
                                  (value) {
                                    vModel.updateHadPeriod(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          kCommonSpaceV20,
                          _text(S.of(context)!.doYouExperience, 14),
                          Consumer<DashBoardViewModel>(
                            builder: (context, vModel, child) {
                              return Column(
                                children: [
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.hotFlushes,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        1), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          1); // Toggle selection
                                    },
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.tiredness,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        2), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          2); // Toggle selection
                                    },
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.moodSwings,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        3), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          3); // Toggle selection
                                    },
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.vaginalDryness,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        4), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          4); // Toggle selection
                                    },
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.decreasedLibido,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        5), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          5); // Toggle selection
                                    },
                                  ),
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      S.of(context)!.jointPain,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: vModel.isExperienceSelected(
                                        6), // Check if selected
                                    onChanged: (value) {
                                      vModel.toggleExperience(
                                          6); // Toggle selection
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          // _displayBox(150,
                          //     'If you’re experiencing above symptoms mentioned above, do not worry these are menopausal symptoms due to estrogen deficiency, consult a gynaecologist to start HRT (Hormone Replacement Therapy) to relieve these symptoms.'),
                          kCommonSpaceV20,
                          _text(S.of(context)!.haveyouExpPostmenopausalSpotting,
                              14),
                          Consumer<DashBoardViewModel>(
                              builder: (context, vModel, child) {
                            return Row(
                              children: [
                                _radioBtn(
                                  S.of(context)!.yes,
                                  1,
                                  vModel.expPostmenopausal,
                                  (value) {
                                    vModel.updateExpPostmenopausal(value!);
                                  },
                                ),
                                _radioBtn(
                                  S.of(context)!.no,
                                  0,
                                  vModel.expPostmenopausal,
                                  (value) {
                                    vModel.updateExpPostmenopausal(value!);
                                  },
                                ),
                              ],
                            );
                          }),
                          // _displayBox(100,
                          //     'Possible causes can be estrogen deficiency, vaginal dryness, or cancer.Get an ultrasound and a Pap Smear now!'),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity, // <-- match_parent
                            height: 40, // <-- match-parent
                            child: ElevatedButton(
                              onPressed: () {
                                mViewModel.updateVaccinationInfo();
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    CommonColors.primaryColor),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              child: Text(S.of(context)!.submit,
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                /* Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldContainer(
                        onTap: () {
                          push(const AilmentsView());
                        },
                        color: CommonColors.mGrey200,
                        labelText: "Medical conditions",
                        controller: medicalConditionController,
                        isReadOnly: true,
                      ),
                    ),
                    kCommonSpaceH10,
                    Expanded(
                      child: CustomTextFieldContainer(
                        onTap: () {
                          push(MedicationView(
                            aid: '',
                          ));
                        },
                        color: primaryColorWithOpacity,
                        labelText: "Medication",
                        controller: medicationController,
                        isReadOnly: true,
                      ),
                    ),
                  ],
                ),
                kCommonSpaceV5,
                CustomTextFieldContainer(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  kCommonSpaceV20,
                                  CommonGenderSelectBox(
                                    onTap: () {
                                      setState(() {
                                        selectedRelation = 1;
                                        maritalStatusController.text = "Solo";
                                      });
                                    },
                                    text: S.of(context)!.solo,
                                    imagePath: LocalImages.img_solo,
                                    isBoxFit: true,
                                    isShowDefaultBorder: true,
                                    isSelected: selectedRelation == 1,
                                  ),
                                  CommonGenderSelectBox(
                                    onTap: () {
                                      setState(() {
                                        selectedRelation = 2;
                                        maritalStatusController.text = "Tied";
                                      });
                                    },
                                    text: S.of(context)!.tied,
                                    imagePath: LocalImages.img_tried,
                                    isBoxFit: true,
                                    isShowDefaultBorder: true,
                                    isSelected: selectedRelation == 2,
                                  ),
                                  CommonGenderSelectBox(
                                    onTap: () {
                                      setState(() {
                                        selectedRelation = 3;
                                        maritalStatusController.text =
                                            "Open for surprise";
                                      });
                                    },
                                    text: S.of(context)!.openForSur,
                                    imagePath: LocalImages.img_open_for_surprises,
                                    isShowDefaultBorder: true,
                                    isBoxFit: true,
                                    isSelected: selectedRelation == 3,
                                  ),
                                  kCommonSpaceV20,
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  color: primaryColorWithOpacity,
                  labelText: "Marital status",
                  controller: maritalStatusController,
                  isReadOnly: true,
                ),
                kCommonSpaceV5,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldContainer(
                        onTap: () {
                          push(const WeightView());
                        },
                        color: primaryColorWithOpacity,
                        labelText: "Weight",
                        controller: weightController,
                        isReadOnly: true,
                      ),
                    ),
                    kCommonSpaceH10,
                    Expanded(
                      child: CustomTextFieldContainer(
                        onTap: () {
                          push(const BmiCalculatorView());
                        },
                        color: primaryColorWithOpacity,
                        labelText: "BMI",
                        controller: bmiController,
                        isReadOnly: true,
                      ),
                    ),
                  ],
                ),
                kCommonSpaceV5,
                CustomTextFieldContainer(
                  onTap: () {
                    push(const EditPeriodDateView());
                  },
                  color: primaryColorWithOpacity,
                  labelText: "Date of last period",
                  controller: lastPeriodController,
                  isReadOnly: true,
                ),
                kCommonSpaceV5,
                CustomTextFieldContainer(
                  onTap: () {
                    push(const EditCycleLengthView());
        
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            height: kDeviceHeight / 2,
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  children: [
                                    kCommonSpaceV20,
                                    Text(
                                      S.of(context)!.averageCycle,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.piedra(
                                        color: CommonColors.primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListWheelScrollView(
                                        itemExtent: 100,
                                        diameterRatio: .8,
                                        perspective: 0.005,
                                        physics: FixedExtentScrollPhysics(),
                                        onSelectedItemChanged: (value) {
                                          selectedCycleLength = value + 1;
                                          cycleLengthController.text =
                                              selectedCycleLength.toString();
                                        },
                                        children: List.generate(
                                          45,
                                          (index) => Container(
                                            height: 120,
                                            width: 120,
                                            decoration: const BoxDecoration(
                                              color: CommonColors.A43786,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${index + 1}",
                                              style: getAppStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColors.mWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  color: primaryColorWithOpacity,
                  labelText: "Average cycle length (days)",
                  controller: cycleLengthController,
                  isReadOnly: true,
                ),
                kCommonSpaceV5,
                CustomTextFieldContainer(
                  onTap: () {
                    push(const EditPeriodLengthView());
        
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                            height: kDeviceHeight / 2,
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  children: [
                                    kCommonSpaceV20,
                                    Text(
                                      S.of(context)!.averagePeriod,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.piedra(
                                        color: CommonColors.primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListWheelScrollView(
                                        itemExtent: 100,
                                        diameterRatio: .8,
                                        physics: FixedExtentScrollPhysics(),
                                        perspective: 0.004,
                                        onSelectedItemChanged: (value) {
                                          selectedPeriodsLength = value + 1;
                                          periodLengthController.text =
                                              selectedPeriodsLength.toString();
                                        },
                                        children: List.generate(
                                          15,
                                          (index) => Container(
                                            height: 120,
                                            width: 120,
                                            decoration: const BoxDecoration(
                                              color: CommonColors.A43786,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${index + 1}",
                                              style: getAppStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  color: CommonColors.mWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  color: primaryColorWithOpacity,
                  labelText: "Average period length (days)",
                  controller: periodLengthController,
                  isReadOnly: true,
                ),
                kCommonSpaceV5,
                CustomTextFieldContainer(
                  onTap: () {
                    push(const InterestView());
                  },
                  color: primaryColorWithOpacity,
                  labelText: "Forum Interest",
                  controller: forumInterestController,
                  isReadOnly: true,
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInputDialog({
    required BuildContext context,
    required String title,
    String? hintText,
    required Function(String) onSubmit,
  }) {
    //TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
              style: TextStyle(
                color: Color(0xff575757),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.purple,
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(-5, 0),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, // Removes the default border
              ),
            ),
          ),
          actions: [
            Center(
              // Center the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Purple background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    onSubmit(emailController.text);
                  }
                  setState(() {});
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  S.of(context)!.update,
                  style: TextStyle(color: Colors.white), // White text
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Helper method for TableCell to avoid repetition:
Widget _tableCell(String text, Color color) {
  return TableCell(
    child: Container(
      color: color,
      height: 70,
      width: 120,
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: CommonColors.blackColor,
          fontSize: 12,
        ),
      ),
    ),
  );
}

List<Map<String, dynamic>> imageList = [
  {
    'name': 'Low',
    'image': LocalImages.intersect,
  },
  {
    'name': 'Medium',
    'image': LocalImages.intersect,
  },
  {
    'name': 'High',
    'image': LocalImages.intersect,
  },
  // You can add more objects here if needed
];

List<Map<String, dynamic>> acneImageList = [
  {
    'name': 'Minimal',
    'image': LocalImages.acne,
  },
  {
    'name': 'None',
    'image': LocalImages.acne,
  },
  {
    'name': 'Minimal',
    'image': LocalImages.acne,
  },
  // You can add more objects here if needed
];

Widget _symptomsCell(context, String text, String info, imageList) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        kCommonSpaceV10,
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 10, top: 0, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: info == '' ? 80 : 50,
            width: MediaQuery.of(context).size.width,
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
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: info == ''
                ? Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center contents horizontally
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      for (int index = 0; index < imageList.length; index++)
                        _listOption(
                            imageList[index]['name'], imageList[index]['image'])
                    ],
                  )
                : Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the content
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center vertically
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10), // Margin left for the dot
                        child: Icon(
                          Icons.circle, // Dot icon
                          size: 5, // Size of the dot
                          color:
                              CommonColors.blackColor, // Adjust color as needed
                        ),
                      ),
                      SizedBox(width: 5), // Space between the dot and text
                      Expanded(
                        child: Text(
                          info,
                          textAlign: TextAlign.left,
                          style: getAppStyle(
                            color: const Color.fromARGB(255, 102, 100, 100),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Widget _track(
    context, String text, String info, image1, image2, left1, subText) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        kCommonSpaceV10,
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 10, top: 0, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: info == '' ? 80 : 50,
            width: MediaQuery.of(context).size.width,
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
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                if (left1 != '')
                  Container(
                    width: 20, // Set image width
                    height: 20,
                    margin: EdgeInsets.all(5), // Set image height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(left1), // Use image from assets
                        fit: BoxFit.cover, // Cover the area of the container
                      ),
                    ),
                  ),
                SizedBox(width: 5), // Space between the dot and text
                Expanded(
                    child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info,
                      textAlign: TextAlign.left,
                      style: getAppStyle(
                        color: const Color.fromARGB(255, 102, 100, 100),
                        fontSize: 12,
                      ),
                    ),
                    if (subText != '')
                      Text(
                        subText,
                        textAlign: TextAlign.left,
                        style: getAppStyle(
                          color: const Color.fromARGB(255, 102, 100, 100),
                          fontSize: 10,
                        ),
                      ),
                  ],
                )),
                if (image1 != '')
                  Container(
                    width: 20, // Set image width
                    height: 20,
                    margin: EdgeInsets.all(5), // Set image height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image1), // Use image from assets
                        fit: BoxFit.cover, // Cover the area of the container
                      ),
                    ),
                  ),

                if (image2 != '')
                  Container(
                    width: 20, // Set image width
                    height: 20,
                    margin: EdgeInsets.all(5), // Set image height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image2), // Use image from assets
                        fit: BoxFit.cover, // Cover the area of the container
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Widget _weight_bmi(context, String text, weightHistory) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        kCommonSpaceV10,
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 10, top: 5, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 300,
            width: MediaQuery.of(context).size.width,
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
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                SizedBox(width: 5), // Space between the dot and text
                Expanded(
                  child: SingleChildScrollView(
                    // Wrap the column with a SingleChildScrollView
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Center the content
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Evenly space between items
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Last Update',
                                textAlign: TextAlign.left,
                                style: getAppStyle(
                                  color:
                                      const Color.fromARGB(255, 102, 100, 100),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'BMI Score',
                                textAlign: TextAlign.left,
                                style: getAppStyle(
                                  color:
                                      const Color.fromARGB(255, 102, 100, 100),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        for (int index = 0;
                            index < weightHistory.length;
                            index++)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  weightHistory[index]['month'],
                                  textAlign: TextAlign.left,
                                  style: getAppStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              for (int inx = 0;
                                  inx < weightHistory[index]['data'].length;
                                  inx++)
                                _bmiValue(
                                  context,
                                  weightHistory[index]['data'][inx],
                                  '${weightHistory[index]['data'][inx]['weight'] ?? "Empty"}',
                                  weightHistory[index]['data'][inx]['date'],
                                  '10',
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
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

void main() {
  double value = 8.5;
  String unit = 'feet';
  double meters = convertToMeters(value, unit);
  print('$value $unit is equal to $meters meters');
}

Widget _quizCell(context, String text, String info) {
  return Center(
    // padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.left,
          style: getAppStyle(
            color: CommonColors.blackColor,
            fontSize: 12,
          ),
        ),
        kCommonSpaceV10,
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 10, top: 0, bottom: 0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 50,
            width: MediaQuery.of(context).size.width,
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
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12), // Margin left for the dot
                  child: Icon(
                    Icons.circle, // Dot icon
                    size: 5, // Size of the dot
                    color: CommonColors.blackColor, // Adjust color as needed
                  ),
                ),
                SizedBox(width: 5), // Space between the dot and text
                Expanded(
                  child: Text(
                    info,
                    textAlign: TextAlign.left,
                    style: getAppStyle(
                      color: const Color.fromARGB(255, 102, 100, 100),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        kCommonSpaceV10,
      ],
    ),
  );
}

Widget _listOption(name, image) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
    crossAxisAlignment:
        CrossAxisAlignment.center, // Center content horizontally
    children: [
      // Image at the top
      Container(
        width: 40, // Set image width
        height: 40,
        margin: EdgeInsets.all(5), // Set image height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image), // Use image from assets
            fit: BoxFit.cover, // Cover the area of the container
          ),
        ),
      ),
      // Add spacing between image and text
      // Text at the bottom
      Text(
        name,
        style: TextStyle(
          fontSize: 10, // You can adjust text size here
          fontWeight: FontWeight.bold, // Bold text
          color: const Color.fromARGB(255, 102, 100, 100), // Text color
        ),
      ),
    ],
  );
}

Widget _text(text, double size) {
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5),
    child: Text(
      text,
      style: TextStyle(
        fontSize: size, // You can adjust text size here
        fontWeight: FontWeight.w500, // Bold text
        color: const Color.fromARGB(255, 5, 5, 5), // Text color
      ),
    ),
  );
}

// Widget _radioBtn(text) {
//   return Container(
//     clipBehavior: Clip.antiAlias,
//     height: 40,
//     width: 120,
//     margin: EdgeInsets.all(5),
//     decoration: ShapeDecoration(
//       color: CommonColors.mWhite,
//       shape: RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.all(Radius.circular(8)), // Border radius for all edges
//       ),
//       shadows: const [
//         BoxShadow(
//           color: Color(0x3F000000),
//           blurRadius: 5,
//           offset: Offset(0, 2),
//           spreadRadius: 0,
//         )
//       ],
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start, // Center the content
//       crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
//       children: [
//         Radio(value: 4, groupValue: 1, onChanged: (value) {}),
//         Padding(
//           padding: EdgeInsets.only(right: 12.0),
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget _radioBtn(
    String text, int value, int? groupValue, Function(int?) onChanged) {
  return GestureDetector(
    onTap: () {
      onChanged(value); // Call the onChanged callback with the selected value
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      height: 40,
      width: 120,
      margin: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: CommonColors.mWhite,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
              Radius.circular(8)), // Border radius for all edges
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Center the content
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          Radio<int>(
            value: value,
            groupValue: groupValue, // Compare with the current group value
            onChanged: onChanged, // Update the selected value
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _displayBox(double size, text) {
  return Container(
    clipBehavior: Clip.antiAlias,
    height: size,
    // width: 120,
    margin: EdgeInsets.all(5),
    decoration: ShapeDecoration(
      color: CommonColors.mWhite,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(8)), // Border radius for all edges
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start, // Center the content
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            // width: 200,
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

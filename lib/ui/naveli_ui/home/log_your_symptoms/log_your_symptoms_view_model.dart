import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/common_ui/bottom_navbar/bottom_navbar_view.dart';
import 'package:naveli_2023/utils/common_utils.dart';

import '../../../../generated/i18n.dart';
import '../../../../models/common_master.dart';
import '../../../../models/user_symptoms_master.dart';
import '../../../../models/user_symptoms_score_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../utils/local_images.dart';

class LogYourSymptomsModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  final PageController pageController = PageController(initialPage: 0);
  SymptomsData? userSymptomsData;
  final now = DateTime.now();
  int? selectedStaining;
  int? selectedClotSize;
  int? selectedWorkingAbility;
  int? selectedLocation;
  List? selectedLocationArray = [];
  int? selectedCramps;
  int? selectedDays;
  int? selectedCollection;
  int? selectedFrequency;
  int? selectedMood;
  int? selectedEnergy;
  int? selectedStress;

  // int? selectedLifeStyle;
  int? selectedAcne;
  int count = 0;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void checkMoreThenThreeSelected() {
    if (selectedStaining == 3) count += 1;
    if (selectedClotSize == 3) count += 1;
    if (selectedWorkingAbility == 4) count += 1;
    if (selectedLocation == 4) count += 1;
    if (selectedCramps == 4) count += 1;
    if (selectedDays == 4) count += 1;
    if (selectedCollection == 4) count += 1;
    if (selectedFrequency == 4) count += 1;
    if (selectedMood == 3) count += 1;
    if (selectedEnergy == 3) count += 1;
    if (selectedStress == 3) count += 1;
    if (selectedAcne == 3) count += 1;

    print("Count is.... :: $count");

    if (count == 3) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kCommonSpaceV20,
                Text(
                  'Mera to zindgi kharab kr diya',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.piedra(
                    color: CommonColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kCommonSpaceV20,
                Image.asset(
                  LocalImages.img_zindgi_kharab,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
              ],
            ),
          );
        },
      );
    }
    notifyListeners();
  }

  Future<void> userSymptomsLogApi({
    int? staining,
    int? clotSize,
    int? workingAbility,
    int? location,
    List? selectedLocationArray,
    int? cramps,
    int? days,
    int? collectionMethod,
    int? frequencyOfChangeDay,
    int? mood,
    int? energy,
    int? stress,
    int? lifestyle,
    int? acne,
    int? stainingScore,
    int? clotSizeScore,
    int? workingAbilityScore,
    int? locationScore,
    int? periodCrampsScore,
    int? daysScore,
  }) async {
    // CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      if (staining != null) ApiParams.staining: staining,
      if (clotSize != null) ApiParams.clot_size: clotSize,
      if (workingAbility != null) ApiParams.working_ability: workingAbility,
      if (location != null) ApiParams.location: location,
      if (cramps != null) ApiParams.cramps: cramps,
      if (days != null) ApiParams.days: days,
      if (collectionMethod != null)
        ApiParams.collection_method: collectionMethod,
      if (frequencyOfChangeDay != null)
        ApiParams.frequency_of_change_day: frequencyOfChangeDay,
      if (mood != null) ApiParams.mood: mood,
      if (energy != null) ApiParams.energy: energy,
      if (stress != null) ApiParams.stress: stress,
      if (lifestyle != null) ApiParams.lifestyle: lifestyle,
      if (acne != null) ApiParams.acne: acne,
      if (stainingScore != null) ApiParams.staining_score: stainingScore,
      if (clotSizeScore != null) ApiParams.clot_size_score: clotSizeScore,
      if (workingAbilityScore != null)
        ApiParams.working_ability_score: workingAbilityScore,
      if (locationScore != null) ApiParams.location_score: locationScore,
      if (periodCrampsScore != null)
        ApiParams.period_cramps_score: periodCrampsScore,
      if (daysScore != null) ApiParams.days_score: daysScore,
      ApiParams.date: DateFormat('yyyy-MM-dd').format(now),
    };
    log(params.toString());

    CommonMaster? master = await _services.api!.userSymptomsLog(params: params);
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................symptoms oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      String? previousDateString = globalUserMaster?.previousPeriodsBegin ?? '';
      List<String> dateParts = previousDateString.split(',');
      int year = int.tryParse(dateParts[0].trim()) ?? 0;
      int month = int.tryParse(dateParts[0].trim()) ?? 0;
      int day = int.tryParse(dateParts[0].trim()) ?? 0;

      DateTime previousDate = DateTime(year, month, day);

      String formattedDate = DateFormat('yyyy-MM-dd').format(previousDate);

      print(
          "................................Previous date is................$formattedDate");

      getSymptomsScoreApi(periodStartDate: formattedDate);
      // getUserSymptomsLogApi();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    // notifyListeners();
  }

  Future<void> getSymptomsScoreApi({
    required String? periodStartDate,
  }) async {
    // CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.period_start_date: periodStartDate,
    };
    UserSymptomsScoreMaster? master =
        await _services.api!.getSymptomsScore(params: params);
    // CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................symptoms oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      if (master.data?.totalScore != null) {
        /* int scr = master.data?.totalScore; */
        // print("--score--");
        // print(master.data!.totalScore!);
        if (master.data!.totalScore! >= 100) {
          show100SymptomsScoreDialog();
        }
      }
      if (master.data?.totalPainScore != null) {
        if (master.data!.totalPainScore! >= 4) {
          // showPainSymptomsScoreDialog();
        }
      }
    }
    notifyListeners();
  }

  Future<void> getUserSymptomsLogApi({required String date}) async {
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.period_start_date: date
    };
    UserSymptomsMaster? master =
        await _services.api!.getUserSymptomsDetails(params: params);
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................symptoms oops.............................");
    } else if (master.success! && master.data != null) {
      // AppPreferences.instance.setUserDetails(UserSymptomsMaster(master.data));
      userSymptomsData = master.data;
      // if(selectedWorkingAbility != userSymptomsData?.workingAbility){
      //   selectedWorkingAbility = userSymptomsData?.workingAbility;
      // }
      selectedStaining = userSymptomsData?.staining;
      selectedClotSize = userSymptomsData?.clotSize;
      selectedWorkingAbility = userSymptomsData?.workingAbility;
      selectedLocation = userSymptomsData?.location;
      selectedLocationArray?.add(userSymptomsData?.location);
      selectedCramps = userSymptomsData?.cramps;
      selectedDays = userSymptomsData?.days;
      selectedCollection = userSymptomsData?.collectionMethod;
      selectedFrequency = userSymptomsData?.frequencyOfChangeDay;
      selectedMood = userSymptomsData?.mood;
      selectedEnergy = userSymptomsData?.energy;
      selectedStress = userSymptomsData?.stress;
      // selectedLifeStyle = userSymptomsData?.lifestyle;
      selectedAcne = userSymptomsData?.acne;
    } else if (!master.success!) {
      // CommonUtils.showRedToastMessage(
      //   master.message ?? S.of(mainNavKey.currentContext!)!.userDataSyncFailed,
      // );
    }
    notifyListeners();
  }

  Future<void> postUserSymptomsLogApi({required Map<String, dynamic> body}) async {

    Map<String,dynamic> master =
        await _services.api!.postUserSymptoms(body: {});
    debugPrint("master: $master");
    notifyListeners();
  }

  void checkFlow() {
    if (selectedStaining != null &&
        selectedClotSize != null &&
        selectedCollection != null &&
        selectedFrequency != null) {
      // pageController.nextPage(
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeIn,
      // );
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    notifyListeners();
  }

  void checkPain() {
    if (selectedWorkingAbility != null &&
        selectedLocation != null &&
        selectedCramps != null &&
        selectedDays != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        pushAndRemoveUntil(const BottomNavbarView());
      });
    }
    notifyListeners();
  }

  Future<void> show100SymptomsScoreDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.76, 0.65),
                  end: Alignment(-0.76, -0.65),
                  colors: [Color(0xFFA43786), Color(0xFF6A41A5)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    kCommonSpaceV10,
                    Text(
                      S.of(context)!.symptomsHundredScore,
                      textAlign: TextAlign.center,
                      style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    kCommonSpaceV10,
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        S.of(context)!.symptomsHundredOption,
                        style: getAppStyle(
                          color: CommonColors.mWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: CommonColors.mWhite,
                          side: const BorderSide(
                            width: 1.0,
                            color: CommonColors.blackColor,
                          ),
                        ),
                        child: Text(
                          S.of(context)!.ok,
                          style: getAppStyle(color: CommonColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> showPainSymptomsScoreDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.76, 0.65),
                  end: Alignment(-0.76, -0.65),
                  colors: [Color(0xFFA43786), Color(0xFF6A41A5)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      S.of(context)!.symptomsPainScore,
                      textAlign: TextAlign.center,
                      style: getAppStyle(
                        color: CommonColors.mWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    kCommonSpaceV10,
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Text(
                        S.of(context)!.symptomsPainOption,
                        style: getAppStyle(
                          color: CommonColors.mWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: CommonColors.mWhite,
                          side: const BorderSide(
                            width: 1.0,
                            color: CommonColors.blackColor,
                          ),
                        ),
                        child: Text(
                          S.of(context)!.ok,
                          style: getAppStyle(color: CommonColors.blackColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

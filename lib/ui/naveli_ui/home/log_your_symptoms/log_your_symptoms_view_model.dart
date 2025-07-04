import 'dart:convert';
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
  Log? userSymptomsData;
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

  bool severeAlert = false;
  bool stainAlert = false;

  void updateLocation(int location) {
    selectedLocation = location;

    if (location == 6) {
      if (selectedLocationArray!.contains(6)) {
        selectedLocationArray!.remove(6);
      } else {
        selectedLocationArray = [6];
      }
    } else {
      if (!selectedLocationArray!.contains(6)) {
        if (selectedLocationArray!.contains(location)) {
          selectedLocationArray!.remove(location);
        } else {
          selectedLocationArray!.add(location);
        }
      }
    }

    checkMoreThenThreeSelected();
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void updateCramps(int cramp) {
    selectedCramps = cramp;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateCollection(int collection) {
    selectedCollection = collection;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateAcne(int acne) {
    selectedAcne = acne;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateMood(int mood) {
    selectedMood = mood;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateEnergy(int energy) {
    selectedEnergy = energy;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateStress(int stress) {
    selectedStress = stress;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateFrequency(int frequency) {
    selectedFrequency = frequency;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateDays(int days) {
    selectedDays = days;
    checkMoreThenThreeSelected();
    notifyListeners();
  }

  void updateStaining(int staining) {
    selectedStaining = staining;
    notifyListeners();
  }

  void updateClotSize(int clotSize) {
    selectedClotSize = clotSize;
    notifyListeners();
  }

  void updateWorkingAbility(int workingAbility) {
    selectedWorkingAbility = workingAbility;
    notifyListeners();
  }

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void _resetAllVariables() {
    selectedStaining = null;
    selectedClotSize = null;
    selectedWorkingAbility = null;
    selectedLocationArray = [];
    selectedCramps = null;
    selectedDays = null;
    selectedCollection = null;
    selectedFrequency = null;
    selectedMood = null;
    selectedEnergy = null;
    selectedStress = null;
    selectedAcne = null;
    notifyListeners(); // Notify listeners to rebuild the UI
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
    Map<String, dynamic> params = {
      ApiParams.period_start_date: date,
    };

    print("Get user data : Before API");
    UserSymptomsMaster? master =
        await _services.api!.getUserSymptomsDetails(params: params);
    print("Get user data : After API");

    if (master == null) {
      print("Get user data : null it is");
      _resetAllVariables();
      CommonUtils.oopsMSG();
      print(
          "................................symptoms oops.............................");
    } else if (master.success == false) {
      _resetAllVariables();
      return;
    } else if (master.success == true &&
        master.data?.logs != null &&
        master.data!.logs!.isNotEmpty) {
      final log = master.data!.logs!.first;
      selectedStaining = log.staining;
      selectedClotSize = log.clotSize;
      selectedWorkingAbility = log.workingAbility;
      selectedLocationArray = log.location != null ? [log.location!] : [];
      selectedCramps = log.cramps;
      selectedDays = log.days;
      selectedCollection = log.collectionMethod;
      selectedFrequency = log.frequencyOfChangeDay;
      selectedMood = log.mood;
      selectedEnergy = log.energy;
      selectedStress = log.stress;
      selectedAcne = log.acne;

      print("Get user data : staining $selectedStaining");
      print("Get user data : clot $selectedClotSize");
    } else {
      print("Get user data : success false or empty logs");
      CommonUtils.oopsMSG();
    }

    notifyListeners();
  }

  Future<void> postUserSymptomsLogApi(BuildContext context) async {
    if (selectedStaining == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectStaining);
      return;
    }

    if (selectedClotSize == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectClotSize);
      return;
    }

    if (selectedWorkingAbility == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectWorkingAbility);
      return;
    }

    if (selectedLocationArray == null || selectedLocationArray!.isEmpty) {
      _showSnackBar(context, S.of(context)!.pleaseSelectAtleastOneLocation);
      return;
    }

    if (selectedCramps == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectCramps);
      return;
    }

    if (selectedDays == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectDays);
      return;
    }

    if (selectedCollection == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectMethod);
      return;
    }

    if (selectedFrequency == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectFrequency);
      return;
    }

    if (selectedMood == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectMood);
      return;
    }

    if (selectedEnergy == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectEnergyLevel);
      return;
    }

    if (selectedStress == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectStressLevel);
      return;
    }

    if (selectedAcne == null) {
      _showSnackBar(context, S.of(context)!.pleaseSelectAcne);
      return;
    }

    Map<String, dynamic> body = {
      "staining": selectedStaining,
      "clot_size": selectedClotSize,
      "working_ability": selectedWorkingAbility,
      "location": selectedLocationArray,
      "cramps": selectedCramps,
      "days": selectedDays,
      "collection_method": selectedCollection,
      "frequency_of_change_day": selectedFrequency.toString(),
      "mood": selectedMood,
      "energy": selectedEnergy,
      "stress": selectedStress,
      "acne": selectedAcne,
    };

    try {
      Map<String, dynamic> master =
          await _services.api!.postUserSymptoms(body: body);
      debugPrint("master: $master");

      if (master.isEmpty) {
        _showSnackBar(context, S.of(context)!.failedToLogSymptoms);
        return;
      } else {
        final data = master['data'];
        severeAlert = data['severealert'];
        stainAlert = data['stainalert'];
        log("Severe Alert: $severeAlert");
        log("Stain Alert: $stainAlert");
        notifyListeners();
      }

      _showSnackBar(context, S.of(context)!.symptomsLoggedSuccess,
          isError: false);
      notifyListeners();
      if (!stainAlert && !severeAlert)
        Navigator.pop(
          context,
        );
    } catch (e) {
      debugPrint("Error logging symptoms: $e");
      _showSnackBar(context, S.of(context)!.failedToLogSymptoms);
    }
  }

  void _showSnackBar(BuildContext context, String message,
      {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void checkFlow() {
    if (selectedStaining != null &&
        selectedClotSize != null &&
        selectedCollection != null &&
        selectedFrequency != null) {
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

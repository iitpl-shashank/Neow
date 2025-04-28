import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../../models/common_master.dart';
import '../../../../models/monthly_mission_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class MoreViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  bool isVisible = false;
  List<String> mainFocusTexts = [];
  List<Map<String, dynamic>> goalsTexts = [];
  List<Map<String, dynamic>> hobbiesTexts = [];
  List<Map<String, dynamic>> habitsToCutTexts = [];
  List<Map<String, dynamic>> habitsToAdoptTexts = [];
  List<Map<String, dynamic>> thingsTexts = [];
  List<Map<String, dynamic>> familyGoalsTexts = [];
  List<Map<String, dynamic>> bookTexts = [];
  List<Map<String, dynamic>> moviesTexts = [];
  List<Map<String, dynamic>> placesTexts = [];
  String wishText = '';

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getMonthlyMissionApi() async {
    CommonUtils.showProgressDialog();
    MonthlyMissionMaster? master = await _services.api!.getMonthlyMission();
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................more oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      mainFocusTexts = master.data?.mainFocusOfMonth ?? [];
      goalsTexts =
          master.data?.goals?.map((goal) => goal.toJson()).toList() ?? [];
      hobbiesTexts =
          master.data?.hobbies?.map((hobbies) => hobbies.toJson()).toList() ??
              [];
      habitsToCutTexts = master.data?.habitsToCut
              ?.map((habitsToCut) => habitsToCut.toJson())
              .toList() ??
          [];
      habitsToAdoptTexts = master.data?.habitsToAdopt
              ?.map((habitsToAdopt) => habitsToAdopt.toJson())
              .toList() ??
          [];
      thingsTexts = master.data?.newThingsToTry
              ?.map((newThingsToTry) => newThingsToTry.toJson())
              .toList() ??
          [];
      familyGoalsTexts = master.data?.familyGoals
              ?.map((familyGoals) => familyGoals.toJson())
              .toList() ??
          [];
      bookTexts = master.data?.booksToRead
              ?.map((booksToRead) => booksToRead.toJson())
              .toList() ??
          [];
      moviesTexts = master.data?.moviesToWatch
              ?.map((moviesToWatch) => moviesToWatch.toJson())
              .toList() ??
          [];
      placesTexts = master.data?.placesToVisit
              ?.map((placesToVisit) => placesToVisit.toJson())
              .toList() ??
          [];
      wishText = master.data?.makeWish ?? '';

      //  CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeMonthlyMissionApi({
    required List<String>? mainFocus,
    required List<Map<String, dynamic>>? goals,
    required List<Map<String, dynamic>>? hobbies,
    required List<Map<String, dynamic>>? habitsCut,
    required List<Map<String, dynamic>>? habitsAdopt,
    required List<Map<String, dynamic>>? things,
    required List<Map<String, dynamic>>? family,
    required List<Map<String, dynamic>>? book,
    required List<Map<String, dynamic>>? movies,
    required List<Map<String, dynamic>>? places,
    required String? wish,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      if (mainFocus != null) ApiParams.main_focus_of_month: mainFocus,
      if (goals != null) ApiParams.goals: goals,
      if (hobbies != null) ApiParams.hobbies: hobbies,
      if (habitsCut != null) ApiParams.habits_to_cut: habitsCut,
      if (habitsAdopt != null) ApiParams.habits_to_adopt: habitsAdopt,
      if (things != null) ApiParams.new_things_to_try: things,
      if (family != null) ApiParams.family_goals: family,
      if (book != null) ApiParams.books_to_read: book,
      if (movies != null) ApiParams.movies_to_watch: movies,
      if (places != null) ApiParams.places_to_visit: places,
      if (wish != null) ApiParams.make_wish: wish,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeMonthlyMission(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................more oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }
}

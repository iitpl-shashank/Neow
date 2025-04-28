import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/local_images.dart';

import '../../../../models/common_master.dart';
import '../../../../models/daily_diary_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';

class ParticularDateDetailsViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<Map<String, dynamic>> dialogData = [
    {
      "id": 1,
      "title": "Rock on",
      "message": "Aaj Khush to bahut hoge tum",
      "image": LocalImages.mood_rock_on,
      "isMultiple": false,
    },
    {
      "id": 1,
      "title": "Sad",
      "message": "Pushpa, I hate tears",
      "image": LocalImages.mood_sad,
      "isMultiple": false,
    },
    {
      "id": 1,
      "title": "Bored",
      "message": "Saala ye dukh kaahe khatam nahi hota hai be",
      "image": LocalImages.mood_bored,
      "isMultiple": false,
    },
    {
      "id": 1,
      "title": "Angry",
      "message": "Tareekh pe tareekh, tareekh pe tareekh",
      "image": LocalImages.mood_angry,
      "isMultiple": false,
    },
    {
      "id": 1,
      "title": "Tired",
      "message": "All izz well",
      "image": LocalImages.mood_tired,
      "isMultiple": false,
    },
    {
      "id": 2,
      "title": "Soulful",
      "message": "",
      "image": LocalImages.music_soulful,
      "isMultiple": false,
    },
    {
      "id": 2,
      "title": "Loud",
      "message": "Aunty police bula degi",
      "image": LocalImages.music_loud,
      "isMultiple": false,
    },
    {
      "id": 2,
      "title": "Spiritual",
      "message": "",
      "image": LocalImages.music_spiritual,
      "isMultiple": false,
    },
    {
      "id": 2,
      "title": "Mix",
      "message": "",
      "image": LocalImages.music_mix,
      "isMultiple": false,
    },
    {
      "id": 2,
      "title": "None",
      "message": "",
      "image": LocalImages.music_none,
      "isMultiple": false,
    },
    {
      "id": 3,
      "title": "Academic",
      "message": "Accha Baccha",
      "image": LocalImages.learning_academic,
      "isMultiple": false,
    },
    {
      "id": 3,
      "title": "Non Academic",
      "message": "Ismaaart",
      "image": LocalImages.learning_non_academic,
      "isMultiple": false,
    },
    {
      "id": 3,
      "title": "None",
      "message": "Kuch to kar lo",
      "image": LocalImages.learning_fail,
      "isMultiple": false,
    },
    {
      "id": 4,
      "title": "Surroundings",
      "message": "",
      "image": LocalImages.cleaning_surroundings,
      "isMultiple": false,
    },
    {
      "id": 4,
      "title": "None",
      "message": "",
      "image": LocalImages.cleaning_none,
      "isMultiple": false,
    },
    {
      "id": 5,
      "title": "Basic",
      "message": "Pamper",
      "image": LocalImages.bodycare_basic,
      "isMultiple": false,
    },
    {
      "id": 5,
      "title": "Pamper",
      "message": "",
      "image": LocalImages.bodycare_pamper,
      "isMultiple": false,
    },
    {
      "id": 5,
      "title": "Spa",
      "message": "",
      "image": LocalImages.bodycare_spa,
      "isMultiple": false,
    },
    {
      "id": 5,
      "title": "None",
      "message": "",
      "image": LocalImages.bodycare_none_bodycare,
      "isMultiple": false,
    },
    {
      "id": 6,
      "title": "Sound",
      "message": "",
      "image": LocalImages.sleep_sound,
      "isMultiple": false,
    },
    {
      "id": 6,
      "title": "Night Owl",
      "message": "",
      "image": LocalImages.sleep_night_owl,
      "isMultiple": false,
    },
    {
      "id": 6,
      "title": "Early Riser",
      "message": "",
      "image": LocalImages.sleep_early_riser,
      "isMultiple": false,
    },
    {
      "id": 6,
      "title": "Oversleep",
      "message": "Sona kahan hai",
      "image": LocalImages.sleep_oversleep,
      "isMultiple": false,
    },
    {
      "id": 6,
      "title": "Irritated",
      "message": "",
      "image": LocalImages.sleep_irritated,
      "isMultiple": false,
    },
    {
      "id": 7,
      "title": "Gym/Aerobics",
      "message": "",
      "image": LocalImages.workout_gym,
      "isMultiple": true,
    },
    {
      "id": 7,
      "title": "Sports",
      "message": "",
      "image": LocalImages.workout_sports,
      "isMultiple": true,
    },
    {
      "id": 7,
      "title": "Yoga",
      "message": "",
      "image": LocalImages.workout_yoga,
      "isMultiple": true,
    },
    {
      "id": 7,
      "title": "Walk",
      "message": "",
      "image": LocalImages.workout_walk,
      "isMultiple": true,
    },
    {
      "id": 7,
      "title": "None",
      "message": "",
      "image": LocalImages.workout_none,
      "isMultiple": true,
    },
    {
      "id": 8,
      "title": "Mall",
      "message": "",
      "image": LocalImages.hangout_mall,
      "isMultiple": true,
    },
    {
      "id": 8,
      "title": "Cafe",
      "message": "",
      "image": LocalImages.hangout_cafe,
      "isMultiple": true,
    },
    {
      "id": 8,
      "title": "Park",
      "message": "",
      "image": LocalImages.hangout_park,
      "isMultiple": true,
    },
    {
      "id": 8,
      "title": "Party",
      "message": "",
      "image": LocalImages.hangout_party,
      "isMultiple": true,
    },
    {
      "id": 8,
      "title": "Binge-watch",
      "message": "",
      "image": LocalImages.hangout_binge_watch,
      "isMultiple": true,
    },
    {
      "id": 9,
      "title": ">2 hours",
      "message": "",
      "image": LocalImages.screen_time_2_hr,
      "isMultiple": false,
    },
    {
      "id": 9,
      "title": "3-4 Hours",
      "message": "",
      "image": LocalImages.screen_time_3_4_hr,
      "isMultiple": false,
    },
    {
      "id": 9,
      "title": "5-6 Hours",
      "message": "",
      "image": LocalImages.screen_time_6_hr,
      "isMultiple": false,
    },
    {
      "id": 9,
      "title": "8 Hours",
      "message": "",
      "image": LocalImages.screen_time_8_hr,
      "isMultiple": false,
    },
    {
      "id": 9,
      "title": "10 hours +",
      "message": "",
      "image": LocalImages.screen_time_10_plus_hr,
      "isMultiple": false,
    },
    {
      "id": 10,
      "title": "Junk/Sweets",
      "message": "",
      "image": LocalImages.food_junk_sweets,
      "isMultiple": true,
    },
    {
      "id": 10,
      "title": "Healthy Food",
      "message": "",
      "image": LocalImages.food_healthy,
      "isMultiple": true,
    },
    {
      "id": 10,
      "title": "Fasting",
      "message": "",
      "image": LocalImages.food_fasting,
      "isMultiple": true,
    },
    {
      "id": 10,
      "title": " Liquor/Soft",
      "message": "",
      "image": LocalImages.food_liquor_soft_drinks,
      "isMultiple": true,
    },
    {
      "id": 10,
      "title": "Intermittent",
      "message": "",
      "image": LocalImages.img_intermittent,
      "isMultiple": true,
    },
  ];
  List<String> dailyDairyTextList = [];
  List<String> toDoListText = [];
  String? selectedMoodEmoji;
  String? selectedMusicEmoji;
  String? selectedLearningEmoji;
  String? selectedCleaningEmoji;
  String? selectedBodyCareEmoji;
  String? selectedSleepEmoji;
  String? selectedWorkoutEmoji;
  String? selectedHangoutEmoji;
  String? selectedScreenTimeEmoji;
  String? selectedFoodEmoji;
  String? gratitude;
  String? edit;
  String? isEdit;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> storeDailyDiaryApi({
    required String? currentDate,
    required String? mood,
    required String? music,
    required String? learning,
    required String? cleaning,
    required String? bodyCare,
    required bool? gratitude,
    required String? hangOut,
    required String? workOut,
    required String? screenTime,
    required String? food,
    required String? sleep,
    required String? edit,
    required bool? isEdit,
    required List<String>? toDoList,
    required List<String>? dailyDairy,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.createdAt: currentDate,
      ApiParams.mood: mood,
      ApiParams.music: music,
      ApiParams.learning: learning,
      ApiParams.cleaning: cleaning,
      ApiParams.body_care: bodyCare,
      ApiParams.gratitude: gratitude,
      ApiParams.hang_out: hangOut,
      ApiParams.work_out: workOut,
      ApiParams.screen_time: screenTime,
      ApiParams.food: food,
      ApiParams.sleep: sleep,
      ApiParams.edit: edit,
      ApiParams.is_edit: isEdit,
      ApiParams.to_do_list: toDoList,
      ApiParams.daily_dairy: dailyDairy,
    };
    log(params.toString());
    CommonMaster? master = await _services.api!.storeDailyDiary(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................particular date detail oops.............................");
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

  Future<void> getDailyDiaryDataApi({
    required String date,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.date: date,
    };
    log(params.toString());
    DailyDiaryMaster? master =
        await _services.api!.getDailyDiaryData(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................particular date detail oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      selectedMoodEmoji = master.data?.mood;
      selectedMusicEmoji = master.data?.music;
      selectedLearningEmoji = master.data?.learning;
      selectedCleaningEmoji = master.data?.cleaning;
      selectedBodyCareEmoji = master.data?.bodyCare;
      selectedSleepEmoji = master.data?.sleep;
      selectedWorkoutEmoji = master.data?.workOut;
      selectedHangoutEmoji = master.data?.hangOut;
      selectedScreenTimeEmoji = master.data?.screenTime;
      selectedFoodEmoji = master.data?.food;
      dailyDairyTextList = master.data?.dailyDairy ?? [];
      toDoListText = master.data?.toDoList ?? [];
      gratitude = master.data?.gratitude;
      edit = master.data?.edit;
      isEdit = master.data?.isEdit;
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<String?> showEmojiSelectDialog(
      BuildContext context, int id, String? initialSelectedEmoji) async {
    List<Map<String, dynamic>> filteredList =
        dialogData.where((data) => data['id'] == id).toList();
    String? selectedEmoji = initialSelectedEmoji;

    selectedEmoji = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: kDeviceWidth / 1,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFDDC1FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kCommonSpaceV20,
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            children: List.generate(
                              filteredList.length,
                              (emojiIndex) {
                                final emojiData = filteredList[emojiIndex];
                                final isSelected =
                                    selectedEmoji == emojiData['image'];
                                return GestureDetector(
                                  onTap: () {
                                    if (!isSelected) {
                                      setState(() {
                                        selectedEmoji = emojiData['image'];
                                      });
                                      Navigator.pop(context, selectedEmoji);
                                      emojiData['message'] != ""
                                          ? showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                                return AlertDialog(
                                                  content: Text(
                                                    emojiData['message'],
                                                    textAlign: TextAlign.center,
                                                    style: getGoogleFontStyle(
                                                      color: CommonColors
                                                          .primaryColor,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : null;
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        emojiData['image'],
                                        fit: BoxFit.contain,
                                        height: 100,
                                        width: 100,
                                      ),
                                      kCommonSpaceV10,
                                      Text(
                                        emojiData['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: isSelected
                                              ? CommonColors.mRed
                                              : CommonColors.blackColor,
                                          fontSize: 15,
                                          fontFamily: 'Outfit',
                                          fontWeight: FontWeight.w500,
                                          height: 0.5,
                                        ),
                                      ),
                                      kCommonSpaceV20
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        kCommonSpaceV20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xFFFF0000),
                                  fontSize: 18,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    notifyListeners();
    return selectedEmoji;
  }
}

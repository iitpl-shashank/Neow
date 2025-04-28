import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/reflections/reflections_view_model.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_secret_diary_container.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_reflections_widgets.dart';
import '../more/more_view_model.dart';
import '../particular_date_details/particular_date_details_view.dart';
import '../secret_diary_view_model.dart';

class ReflectionsView extends StatefulWidget {
  const ReflectionsView({super.key});

  @override
  State<ReflectionsView> createState() => _ReflectionsViewState();
}

class _ReflectionsViewState extends State<ReflectionsView> {
  late MoreViewModel mViewModel;
  late SecretDiaryViewModel mViewSecretModel;
  late ReflectionsViewModel mViewReflectionModel;
  var currentMonth = DateFormat.MMMM().format(DateTime.now());
  List<String> mainFocusOfMonthList = [];
  List<String> goalsAchievedList = [];
  List<String> goalsYetToAchieveList = [];
  List<String> habitToCutList = [];
  List<String> habitToAdoptList = [];
  List<String> newThingTryList = [];
  List<String> familyGoalsList = [];
  List<String> bookToReadList = [];
  List<String> movieToWatchList = [];
  List<String> placesToVisitList = [];
  String wishTextList = '';
  final currentDate = DateTime.now();
  final Map<int, String> emojiMap = {
    1: '😀',
    2: '😎',
    3: '😊',
    4: '😄',
    5: '🥳',
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewSecretModel.attachedContext(context);
      mViewReflectionModel.attachedContext(context);
      mViewReflectionModel.getReflectionApi().whenComplete(
          () => mViewModel.getMonthlyMissionApi().whenComplete(() {
                mainFocusOfMonthList = mViewModel.mainFocusTexts;
                for (var goal in mViewModel.goalsTexts) {
                  if (goal["status"]) {
                    goalsAchievedList.add(goal["value"]);
                  }
                }
                for (var goal in mViewModel.goalsTexts) {
                  if (goal["status"] == false) {
                    goalsYetToAchieveList.add(goal["value"]);
                  }
                }
                for (var habitCut in mViewModel.habitsToCutTexts) {
                  if (habitCut["status"]) {
                    habitToCutList.add(habitCut["value"]);
                  }
                }
                for (var habitAdopt in mViewModel.habitsToAdoptTexts) {
                  if (habitAdopt["status"]) {
                    habitToAdoptList.add(habitAdopt["value"]);
                  }
                }
                for (var things in mViewModel.thingsTexts) {
                  if (things["status"]) {
                    newThingTryList.add(things["value"]);
                  }
                }
                for (var familyGoals in mViewModel.familyGoalsTexts) {
                  if (familyGoals["status"]) {
                    familyGoalsList.add(familyGoals["value"]);
                  }
                }
                for (var book in mViewModel.bookTexts) {
                  if (book["status"]) {
                    bookToReadList.add(book["value"]);
                  }
                }
                for (var movie in mViewModel.moviesTexts) {
                  if (movie["status"]) {
                    movieToWatchList.add(movie["value"]);
                  }
                }
                for (var place in mViewModel.placesTexts) {
                  if (place["status"]) {
                    placesToVisitList.add(place["value"]);
                  }
                }
                if (mViewModel.wishText != '') {
                  wishTextList = mViewModel.wishText;
                }
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MoreViewModel>(context);
    mViewSecretModel = Provider.of<SecretDiaryViewModel>(context);
    mViewReflectionModel = Provider.of<ReflectionsViewModel>(context);
    final lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.reflection,
          textColor: CommonColors.darkPink,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       // push(CalendarView());
          //     },
          //     icon: Icon(
          //       Icons.calendar_month_rounded,
          //       color: CommonColors.primaryColor,
          //       size: 28,
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context)!.reflectOnYour,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kCommonSpaceV10,
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage(LocalImages.img_focus_of_month),
                          fit: BoxFit.contain,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        // shadows: [
                        //   BoxShadow(
                        //     color: Color(0x3F000000),
                        //     blurRadius: 4,
                        //     offset: Offset(0, 4),
                        //     spreadRadius: 0,
                        //   )
                        // ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        S.of(context)!.mainFocusOfMonth,
                        style: const TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                kCommonSpaceV10,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  itemCount: mainFocusOfMonthList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 10,
                          ),
                        ),
                        kCommonSpaceH5,
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              mainFocusOfMonthList[index],
                              style: const TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_main_focus,
                  title: S.of(context)!.goalsAchieved,
                  listTexts: goalsAchievedList,
                  itemCount: goalsAchievedList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_goals_yet_to_achieve,
                  title: S.of(context)!.goalsYetToAchieved,
                  listTexts: goalsYetToAchieveList,
                  itemCount: goalsYetToAchieveList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_habit_adopt,
                  title: S.of(context)!.habitToCut,
                  listTexts: habitToCutList,
                  itemCount: habitToCutList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_hobbies,
                  title: S.of(context)!.habitsToAdopt,
                  listTexts: habitToAdoptList,
                  itemCount: habitToAdoptList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_new_thing_try,
                  title: S.of(context)!.newThingsToTry,
                  listTexts: newThingTryList,
                  itemCount: newThingTryList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_family_goals,
                  title: S.of(context)!.familyGoals,
                  listTexts: familyGoalsList,
                  itemCount: familyGoalsList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_book_read,
                  title: S.of(context)!.bookToRead,
                  listTexts: bookToReadList,
                  itemCount: bookToReadList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_movie_watch,
                  title: S.of(context)!.movieToWatch,
                  listTexts: movieToWatchList,
                  itemCount: movieToWatchList.length,
                ),
                CommonReflectionsWidgets(
                  imageUrl: LocalImages.img_place_to_visit,
                  title: S.of(context)!.placeToVisit,
                  listTexts: placesToVisitList,
                  itemCount: placesToVisitList.length,
                ),
                kCommonSpaceV20,
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage(LocalImages.img_make_wish),
                          fit: BoxFit.contain,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        S.of(context)!.makeAWish,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                kCommonSpaceV10,
                if (mViewModel.wishText != '')
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 10,
                            color: CommonColors.black54,
                          ),
                        ),
                        kCommonSpaceH5,
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              wishTextList,
                              style: const TextStyle(
                                  color: CommonColors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      itemCount: mViewSecretModel.currentMonthList.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                mViewSecretModel.weekDay.length,
                                (index) => Flexible(
                                  child: Text(
                                    mViewSecretModel.weekDay[index],
                                    style: GoogleFonts.ultra(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 18,
                                      color: CommonColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kCommonSpaceV10,
                            GridView.count(
                              crossAxisCount: 7,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: List.generate(
                                  mViewSecretModel.currentMonthList[index]
                                      .daysList.length, (dayIndex) {
                                if (mViewSecretModel.currentMonthList[index]
                                        .daysList[dayIndex].year ==
                                    -1) {
                                  return Container();
                                } else {}

                                int year = mViewSecretModel
                                    .currentMonthList[index].year;
                                int month = mViewSecretModel
                                    .currentMonthList[index].monthNumber;
                                int day = mViewSecretModel
                                    .currentMonthList[index]
                                    .daysList[dayIndex]
                                    .day;

                                String formatMonthOrDay(int value) {
                                  return value.toString().padLeft(2, '0');
                                }

                                String selectedDate =
                                    "$year-${formatMonthOrDay(month)}-${formatMonthOrDay(day)}";

                                return Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      push(ParticularDateDetailsView(
                                        selectedDate: day.toString(),
                                        currentMonth: currentMonth,
                                        selectedFullDate: selectedDate,
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        // width: 80,
                                        // height: 80,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFDDC1FE)
                                                .withOpacity(0.6),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Text(
                                            mViewSecretModel
                                                .currentMonthList[index]
                                                .daysList[dayIndex]
                                                .day
                                                .toString(),
                                            style: GoogleFonts.ultra(
                                                fontSize: 15,
                                                color: CommonColors.primaryColor
                                                // color: selectedDays.contains(day)
                                                //     ? CommonColors.mWhite
                                                //     : Colors.black,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      }),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.mood,
                              defaultImage: LocalImages.img_moods,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.music,
                              defaultImage: LocalImages.img_music,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.learning,
                              defaultImage: LocalImages.img_learning,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.cleaning,
                              defaultImage: LocalImages.img_cleaning,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.bodyCare,
                              defaultImage: LocalImages.img_bodycare,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.sleep,
                              defaultImage: LocalImages.img_sleep_daily_diary,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.workout,
                              defaultImage: LocalImages.img_workout,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.hangout,
                              defaultImage: LocalImages.img_hangout,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.screenTime,
                              defaultImage: LocalImages.img_screen_time,
                            ),
                            kCommonSpaceV10,
                            CommonSecretDiaryContainer(
                              title: S.of(context)!.food,
                              defaultImage: LocalImages.img_food,
                            ),
                          ],
                        ),
                      ),
                      kCommonSpaceH15,
                      SizedBox(
                        // color: Colors.amberAccent,
                        height: 1000,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: lastDayOfMonth,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final date = DateTime(
                                currentDate.year, currentDate.month, index + 1);
                            final formattedDate =
                                DateFormat('d MMM').format(date);
                            final emojiList = _getEmojisForDate(formattedDate);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: CommonColors.darkPink,
                                    ),
                                  ),
                                  Column(
                                    children: emojiList.map((emoji) {
                                      return SizedBox(
                                        height: 95,
                                        width: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.asset(
                                            emoji ??
                                                LocalImages.img_naveli_confuse,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                      // Text(
                                      //   emoji ?? '❓',
                                      //   style: TextStyle(fontSize: 24.0),
                                      // );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                kCommonSpaceV20,
                Row(
                  children: [
                    Text(
                      S.of(context)!.gratitude,
                      style:
                          const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    kCommonSpaceH15,
                    if (mViewReflectionModel.isGratitudeComplete == 1)
                      const Icon(
                        Icons.check_box_rounded,
                        color: CommonColors.greenColor,
                      ),
                    if (mViewReflectionModel.isGratitudeComplete == 0)
                      const Icon(
                        Icons.disabled_by_default_rounded,
                        color: CommonColors.mRed,
                      )
                  ],
                ),
                kCommonSpaceV10,
                if (mViewReflectionModel.editText != '')
                  Row(
                    children: [
                      Text(
                        mViewReflectionModel.editText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                      kCommonSpaceH15,
                      if (mViewReflectionModel.isEditComplete == 1)
                        const Icon(
                          Icons.check_box_rounded,
                          color: CommonColors.greenColor,
                        ),
                      if (mViewReflectionModel.isEditComplete == 0)
                        const Icon(
                          Icons.disabled_by_default_rounded,
                          color: CommonColors.mRed,
                        )
                    ],
                  ),
                kCommonSpaceV20,
                Row(
                  children: [
                    Image.asset(LocalImages.img_quote),
                    kCommonSpaceH3,
                    Text(
                      S.of(context)!.quote,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20, height: 1),
                    ),
                  ],
                ),
                kCommonSpaceV10,
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    S.of(context)!.itDoseNotMatter,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                kCommonSpaceV20
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String?> _getEmojisForDate(String date) {
    final List<String?> emojis = [];

    for (final data in mViewReflectionModel.reflectionData ?? []) {
      // print("Data createdAt: ${data.createdAt}");
      if (data.createdAt.contains(date)) {
        emojis.add(data.mood);
        emojis.add(data.music);
        emojis.add(data.learning);
        emojis.add(data.cleaning);
        emojis.add(data.bodyCare);
        emojis.add(data.hangOut);
        emojis.add(data.sleep);
        emojis.add(data.workOut);
        emojis.add(data.screenTime);
        emojis.add(data.food);
      }
    }
    // print("Emojis for $date: $emojis");
    return emojis;
  }
}

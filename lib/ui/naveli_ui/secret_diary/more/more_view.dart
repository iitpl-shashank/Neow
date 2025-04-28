import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_more_widgets.dart';
import '../../../../widgets/primary_button.dart';
import 'more_view_model.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  TextEditingController textController = TextEditingController();
  TextEditingController goalsController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController habitsToAdoptController = TextEditingController();
  TextEditingController habitsToCutController = TextEditingController();
  TextEditingController thingsController = TextEditingController();
  TextEditingController familyGoalsController = TextEditingController();
  TextEditingController bookController = TextEditingController();
  TextEditingController moviesController = TextEditingController();
  TextEditingController placesController = TextEditingController();
  TextEditingController wishController = TextEditingController();
  late MoreViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getMonthlyMissionApi().whenComplete(() {
        if (mViewModel.wishText != '') {
          mViewModel.isVisible = true;
          wishController.text = mViewModel.wishText;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<MoreViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.monthlyMission,
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
              children: [
                Text(
                  S.of(context)!.kickOffMonthlyMission,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
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
                          fit: BoxFit.cover,
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
                        S.of(context)!.mainFocus,
                        style: const TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          setState(() {
                            mViewModel.mainFocusTexts.add(textController.text);
                            textController.clear();
                          });
                        }
                      },
                      icon: const Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.add_circle,
                          color: CommonColors.primaryColor,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: mViewModel.mainFocusTexts.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.circle_rounded,
                            color: CommonColors.primaryColor,
                            size: 10,
                          ),
                        ),
                        kCommonSpaceH5,
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              mViewModel.mainFocusTexts[index],
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
                kCommonSpaceV10,
                Container(
                  width: kDeviceWidth / 1,
                  // height: 94,
                  decoration: ShapeDecoration(
                    color: CommonColors.primaryLite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          child: TextField(
                            controller: textController,
                            maxLines: null,
                            maxLength: 100,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: const EdgeInsets.all(8.0),
                              hintStyle: const TextStyle(
                                color: CommonColors.mGrey,
                                fontSize: 14,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                              ),
                              hintText: S.of(context)!.addYourSecret,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              S.of(context)!.max100Char,
                              style: const TextStyle(
                                color: CommonColors.primaryColor,
                                fontSize: 11,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    S.of(context)!.targetsMet,
                    style:
                        getAppStyle(fontSize: 16, color: CommonColors.black87),
                  ),
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_main_focus,
                  title: S.of(context)!.goals,
                  buttonTitle: S.of(context)!.addGoals,
                  hintText: S.of(context)!.yourGoals,
                  onPressed: () {
                    if (goalsController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.goalsTexts.add({
                          "status": false,
                          "value": goalsController.text,
                        });
                        goalsController.clear();
                      });
                    }
                  },
                  controller: goalsController,
                  listTexts: mViewModel.goalsTexts,
                  itemCount: mViewModel.goalsTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_goals,
                  title: S.of(context)!.hobbies,
                  buttonTitle: S.of(context)!.addHobbies,
                  hintText: S.of(context)!.yourHobbies,
                  onPressed: () {
                    if (hobbiesController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.hobbiesTexts.add({
                          "status": false,
                          "value": hobbiesController.text,
                        });
                        hobbiesController.clear();
                      });
                    }
                  },
                  controller: hobbiesController,
                  listTexts: mViewModel.hobbiesTexts,
                  itemCount: mViewModel.hobbiesTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_habit_adopt,
                  title: S.of(context)!.habitToCut,
                  buttonTitle: S.of(context)!.addHabitsCut,
                  hintText: S.of(context)!.yourHabits,
                  onPressed: () {
                    if (habitsToCutController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.habitsToCutTexts.add({
                          "status": false,
                          "value": habitsToCutController.text,
                        });
                        habitsToCutController.clear();
                      });
                    }
                  },
                  controller: habitsToCutController,
                  listTexts: mViewModel.habitsToCutTexts,
                  itemCount: mViewModel.habitsToCutTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_hobbies,
                  title: S.of(context)!.habitsToAdopt,
                  buttonTitle: S.of(context)!.addHabitsAdopt,
                  hintText: S.of(context)!.yourHabits,
                  onPressed: () {
                    if (habitsToAdoptController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.habitsToAdoptTexts.add({
                          "status": false,
                          "value": habitsToAdoptController.text,
                        });
                        habitsToAdoptController.clear();
                      });
                    }
                  },
                  controller: habitsToAdoptController,
                  listTexts: mViewModel.habitsToAdoptTexts,
                  itemCount: mViewModel.habitsToAdoptTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_new_thing_try,
                  title: S.of(context)!.newThingsToTry,
                  buttonTitle: S.of(context)!.addThings,
                  hintText: S.of(context)!.yourThings,
                  onPressed: () {
                    if (thingsController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.thingsTexts.add({
                          "status": false,
                          "value": thingsController.text,
                        });
                        thingsController.clear();
                      });
                    }
                  },
                  controller: thingsController,
                  listTexts: mViewModel.thingsTexts,
                  itemCount: mViewModel.thingsTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_family_goals,
                  title: S.of(context)!.familyGoals,
                  buttonTitle: S.of(context)!.addGoals,
                  hintText: S.of(context)!.yourFamilyGoals,
                  onPressed: () {
                    if (familyGoalsController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.familyGoalsTexts.add({
                          "status": false,
                          "value": familyGoalsController.text,
                        });
                        familyGoalsController.clear();
                      });
                    }
                  },
                  controller: familyGoalsController,
                  listTexts: mViewModel.familyGoalsTexts,
                  itemCount: mViewModel.familyGoalsTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_book_read,
                  title: S.of(context)!.bookToRead,
                  buttonTitle: S.of(context)!.addBook,
                  hintText: S.of(context)!.yourBookToRead,
                  onPressed: () {
                    if (bookController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.bookTexts.add({
                          "status": false,
                          "value": bookController.text,
                        });
                        bookController.clear();
                      });
                    }
                  },
                  controller: bookController,
                  listTexts: mViewModel.bookTexts,
                  itemCount: mViewModel.bookTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_movie_watch,
                  title: S.of(context)!.movieToWatch,
                  buttonTitle: S.of(context)!.addMovies,
                  hintText: S.of(context)!.yourMovieToWatch,
                  onPressed: () {
                    if (moviesController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.moviesTexts.add({
                          "status": false,
                          "value": moviesController.text,
                        });
                        moviesController.clear();
                      });
                    }
                  },
                  controller: moviesController,
                  listTexts: mViewModel.moviesTexts,
                  itemCount: mViewModel.moviesTexts.length,
                ),
                CommonMoreWidgets(
                  imageUrl: LocalImages.img_place_to_visit,
                  title: S.of(context)!.placeToVisit,
                  buttonTitle: S.of(context)!.addPlaces,
                  hintText: S.of(context)!.yourPlacesToVisit,
                  onPressed: () {
                    if (placesController.text.isNotEmpty) {
                      setState(() {
                        mViewModel.placesTexts.add({
                          "status": false,
                          "value": placesController.text,
                        });
                        placesController.clear();
                      });
                    }
                  },
                  controller: placesController,
                  listTexts: mViewModel.placesTexts,
                  itemCount: mViewModel.placesTexts.length,
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
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        S.of(context)!.makeAWish,
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
                GestureDetector(
                    onDoubleTap: () {
                      if (mViewModel.isVisible) {
                        mViewModel.isVisible = false;
                      } else if (!mViewModel.isVisible) {
                        mViewModel.isVisible = true;
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(mViewModel.isVisible
                              ? LocalImages.img_gift_box_open
                              : LocalImages.img_gift_box),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                kCommonSpaceV10,
                Text(
                  S.of(context)!.doubleTapOnBox,
                  style: const TextStyle(
                    color: CommonColors.blackColor,
                    fontSize: 14,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kCommonSpaceV20,
                if (mViewModel.isVisible)
                  Container(
                    width: kDeviceWidth / 1,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: CommonColors.primaryLite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      // shadows: [
                      //   BoxShadow(
                      //     color: Color(0x3F000000),
                      //     blurRadius: 4,
                      //     offset: Offset(0, 4),
                      //     spreadRadius: 0,
                      //   )
                      // ],
                    ),
                    child: TextField(
                      controller: wishController,
                      decoration: InputDecoration(
                          hintText: S.of(context)!.addYourWish,
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(left: 8, right: 8, bottom: 8)),
                    ),
                  ),
                const SizedBox(
                  height: 100,
                ),
                PrimaryButton(
                  width: kDeviceWidth / 2,
                  onPress: () {
                    mViewModel.storeMonthlyMissionApi(
                      mainFocus: mViewModel.mainFocusTexts,
                      goals: mViewModel.goalsTexts,
                      hobbies: mViewModel.hobbiesTexts,
                      habitsCut: mViewModel.habitsToCutTexts,
                      habitsAdopt: mViewModel.habitsToAdoptTexts,
                      things: mViewModel.thingsTexts,
                      family: mViewModel.familyGoalsTexts,
                      book: mViewModel.bookTexts,
                      movies: mViewModel.moviesTexts,
                      places: mViewModel.placesTexts,
                      wish: wishController.text.trim(),
                    );
                  },
                  label: S.of(context)!.submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

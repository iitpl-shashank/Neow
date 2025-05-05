import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/common_ui/welcome/widgets/custom_alert_dialog.dart';
import 'package:naveli_2023/ui/common_ui/welcome/widgets/menopause_alert_dialog.dart';
import 'package:naveli_2023/utils/images_route.dart';
import 'package:provider/provider.dart';
import 'package:zodiac/zodiac.dart';
import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/login_master.dart';
import '../../../ui/common_ui/welcome/welcome_view_model.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/global_function.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_gender_select_box.dart';
import '../../../widgets/common_relation_select_box.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../app/app_model.dart';
import '../../naveli_ui/cycle_info/cycle_info_view.dart';
import '../../naveli_ui/cycle_info/cycle_info_view_model.dart';
import '../singin/signin_view_model.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late WelcomeViewModel mViewModel;
  final mNameController = TextEditingController();
  final mOtherController = TextEditingController();
  final mSelectDateController = TextEditingController();
  final mDateController = TextEditingController();
  final mAapkeKonController = TextEditingController();
  final mUniqueIdController = TextEditingController();

  late SignInViewModel singInViewModel = SignInViewModel();

  final PageController pageController = PageController(
    initialPage: 0,
  );
  int currentIndex = 0;
  bool showFloatingButton = false;
  int? selectedGender;
  int? selectedRelation;
  String? zodiac;
  Map<String, dynamic> allData = {};

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // singInViewModel.userRoleId = "";
      mViewModel.attachedContext(context);

      mNameController.text = globalUserMaster?.name ?? '';
      if (globalUserMaster?.gender != null) {
        selectedGender = int.parse(globalUserMaster!.gender!.toString());
      }
      mOtherController.text = globalUserMaster?.genderType ?? '';
      if (globalUserMaster?.relationshipStatus != null) {
        selectedRelation =
            int.parse(globalUserMaster!.relationshipStatus!.toString());
      }
      mDateController.text = globalUserMaster?.birthdate ?? '';
      if (globalUserMaster?.birthdate != null) {
        zodiac = Zodiac().getZodiac(globalUserMaster?.birthdate ?? '');
      }
      if (globalUserMaster?.humApkeHeKon != null) {
        mAapkeKonController.text = globalUserMaster?.humApkeHeKon ?? '';
      }
      navigateNextPage();
    });

    super.initState();
  }

  void navigateNextPage() {
    if (currentIndex == 0) {}
  }

  Future<void> selectDate() async {
    DateTime today = DateTime.now();
    DateTime minimumAllowedDate =
        today.subtract(const Duration(days: 365 * 15)); // 15 years ago

    DateTime? picked = await showDatePicker(
      context: mainNavKey.currentContext!,
      initialDate: mDateController.text.isNotEmpty
          ? DateFormat("yyyy-MM-dd").parse(mDateController.text)
          : minimumAllowedDate,
      firstDate: DateTime(1900),
      lastDate: minimumAllowedDate,
    );

    if (picked != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          mDateController.text =
              CommonUtils.dateFormatyyyyMMDD(picked.toString());
          int age = calculateAge(mDateController.text);
          debugPrint("Age===>: $age");

          if (age >= 9 && age <= 25) {
            handle9To25Dialogs(context);
            singInViewModel.userRoleId = "2";
            gUserType = AppConstants.NEOWME;
          } else if (age > 25 && age <= 45) {
            handle25To45Dialogs(context);
            //TODO : user role id is for what ?
            singInViewModel.userRoleId = "2";
            gUserType = AppConstants.NEOWME;
          } else if (age > 45 && age <= 50) {
            handle45To50Dialogs(context);
            singInViewModel.userRoleId = "2";
            gUserType = AppConstants.NEOWME;
          } else if (age > 50) {
            // await handle50PlusDialogs(context);
            handle50PlusDialogs(context);
          }
        });
      });
    } else {
      print("Date selection canceled");
      singInViewModel.userRoleId = "2";
      gUserType = AppConstants.NEOWME;
    }
  }

//Handle 9 to 25 age group dialogs
  Future<void> handle9To25Dialogs(BuildContext context) async {
    final vaccinated = await showCustomDialog(
      context: context,
      title: S.of(context)!.gottonYourselfVaccinated,
      options: [
        DialogOption(S.of(context)!.yes, "yes"),
        DialogOption(S.of(context)!.no, "no"),
      ],
    );

    if (vaccinated == "yes") {
      final doses = await showCustomDialog(
        context: context,
        title: S.of(context)!.howManyDoseTaken,
        isHorizontal: true,
        options: [
          DialogOption(S.of(context)!.dose1, "1"),
          DialogOption(S.of(context)!.dose2, "2"),
        ],
      );

      if (doses == "1") {
        await showCustomDialog(
            context: context,
            title: S.of(context)!.dose2Pending,
            description: S.of(context)!.dose2Timing,
            icon: Images.pendingClock,
            showCloseIcon: true);
      } else {
        await showCustomDialog(
            context: context,
            title: S.of(context)!.veryGood,
            description: S.of(context)!.vaccinationComplete,
            icon: Images.thumpsUp,
            showCloseIcon: true);
      }
    } else {
      await showCustomDialog(
        context: context,
        title: S.of(context)!.uhoh,
        description: S.of(context)!.getVaccinatedToday,
        icon: Images.dangerSign,
        showCloseIcon: true,
      );
    }
  }

//Handle 25 to 45 age group dialogs
  Future<void> handle25To45Dialogs(BuildContext context) async {
    final trying = await showCustomDialog(
      context: context,
      title: S.of(context)!.tryingToGetPregnant,
      options: [
        DialogOption(S.of(context)!.yes, "yes"),
        DialogOption(S.of(context)!.no, "no"),
      ],
    );

    if (trying == "yes") {
      final tryingDuration = await showCustomDialog(
        context: context,
        title: S.of(context)!.tryingSince12Months,
        isHorizontal: true,
        options: [
          DialogOption(S.of(context)!.yes, "yes"),
          DialogOption(S.of(context)!.no, "no"),
        ],
      );

      if (tryingDuration == "yes") {
        await showCustomDialog(
          context: context,
          title: S.of(context)!.youNeedFertilityWork,
          showCloseIcon: true,
          icon: Images.briefcase,
        );
      }
    } else {
      await showCustomDialog(
        context: context,
        icon: Images.dangerSign,
        showCloseIcon: true,
        showPurpleButton: true,
        title: S.of(context)!.keepTrying,
        options: [DialogOption(S.of(context)!.clickHere, "click")],
      );
    }
  }

  //Handle 45 to 50 age group dialogs
  Future<void> handle45To50Dialogs(BuildContext context) async {
    final bleeding = await showCustomDialog(
      context: context,
      title: S.of(context)!.irregularBleeding,
      options: [
        DialogOption(S.of(context)!.yes, "yes"),
        DialogOption(S.of(context)!.no, "no"),
      ],
    );
    var isClicked;
    if (bleeding == "yes") {
      isClicked = await showCustomDialog(
        context: context,
        title: S.of(context)!.getUltrasound,
        description: S.of(context)!.possiblecause,
        options: [
          DialogOption(S.of(context)!.getExamined, "check"),
        ],
        showPurpleButton: true,
        icon: Images.dangerSign,
      );
    }
    if (bleeding == "no" || (bleeding == "yes" && isClicked == "check")) {
      final gotAnyPapSmearBefore = await showCustomDialog(
        context: context,
        title: S.of(context)!.haveYouGotPapSmear,
        options: [
          DialogOption(S.of(context)!.yes, "yes"),
          DialogOption(S.of(context)!.no, "no"),
        ],
      );

      if (gotAnyPapSmearBefore == "no") {
        await showCustomDialog(
          context: context,
          title: S.of(context)!.getOneToday,
          icon: Images.dangerSign,
          showCloseIcon: true,
        );
      } else {
        final lastPapSmear = await showCustomDialog(
          context: context,
          title: S.of(context)!.lastpapSmear,
          options: [
            DialogOption(S.of(context)!.threeYearsBack, "3"),
            DialogOption(S.of(context)!.lessThanThreeYears, "<3"),
          ],
        );

        if (lastPapSmear == "3") {
          await showCustomDialog(
            context: context,
            title: S.of(context)!.repeatPapSmear,
            icon: Images.pendingClock,
            showPurpleButton: true,
            options: [
              DialogOption(S.of(context)!.okay, "okay"),
            ],
          );
        } else {
          await showCustomDialog(
            context: context,
            title: S.of(context)!.getOneAfter3Years,
            icon: Images.pendingClock,
            showPurpleButton: true,
            options: [
              DialogOption(S.of(context)!.okay, "okay"),
            ],
          );
        }
      }
    }
  }

  //Handle 50+ age group dialogs
  Future<void> handle50PlusDialogs(BuildContext context) async {
    debugPrint("Inside 50+");
    final hadPeriods = await showCustomDialog(
      context: context,
      title: S.of(context)!.hadPeriodLasyYear,
      options: [
        DialogOption(
          S.of(context)!.yes,
          "yes",
        ),
        DialogOption(
          S.of(context)!.no,
          "no",
        ),
      ],
    );

    if (hadPeriods == "no") {
      final selected = await showMenopauseDialog(context);
      if (selected != null && selected.isNotEmpty) {
        print('Selected symptoms: $selected');
      }

      final isOkay = await showCustomDialog(
        context: context,
        title: S.of(context)!.doNotWorry,
        description: S.of(context)!.postmenopausalSymptoms,
        options: [DialogOption(S.of(context)!.okay, "ok")],
        showPurpleButton: true,
        showCloseIcon: true,
      );
      print('Scallback 2');

      if (isOkay == "ok") {
        print('Scallback 3 ok');
        final postmenopausalSymptoms = await showCustomDialog(
          context: context,
          title: S.of(context)!.experiencedPostmenopausalSpotting,
          options: [
            DialogOption(S.of(context)!.yes, "yes"),
            DialogOption(S.of(context)!.no, "no", onClick: () async {
              print('Scallback 4 onClick');
              setState(() {
                print('Scallback 5 setState');
                singInViewModel.userRoleId = "4"; // Assign role for menopause
                gUserType = AppConstants.CYCLE_EXPLORER;
                globalUserMaster = AppPreferences.instance.getUserDetails();

                UserMaster userMaster = UserMaster(
                    id: globalUserMaster!.id,
                    name: globalUserMaster!.name,
                    email: globalUserMaster!.email,
                    roleId: 4,
                    uuId: globalUserMaster!.uuId,
                    birthdate: globalUserMaster!.birthdate,
                    age: globalUserMaster!.age,
                    height: globalUserMaster!.height,
                    weight: globalUserMaster!.weight,
                    bmiScore: globalUserMaster!.bmiScore,
                    bmiType: globalUserMaster!.bmiType,
                    badTime: globalUserMaster!.badTime,
                    wakeUpTime: globalUserMaster!.wakeUpTime,
                    totalSleepTime: globalUserMaster!.totalSleepTime,
                    waterMl: globalUserMaster!.waterMl,
                    gender: globalUserMaster!.gender,
                    genderType: globalUserMaster!.genderType,
                    mobile: globalUserMaster!.mobile,
                    deviceToken: globalUserMaster!.deviceToken,
                    image: globalUserMaster!.image,
                    relationshipStatus: globalUserMaster!.relationshipStatus,
                    humApkeHeKon: globalUserMaster!.humApkeHeKon,
                    status: globalUserMaster!.status,
                    state: globalUserMaster!.state,
                    city: globalUserMaster!.city);

                AppPreferences.instance.setUserDetails(jsonEncode(userMaster));
                gUserType = singInViewModel.userRoleId.toString();

                debugPrint("Role ID: ${singInViewModel.userRoleId}");
                debugPrint("Role ID: ${userMaster.toJson()}");
              });
            }),
          ],
        );

        if (postmenopausalSymptoms == "yes") {
          await showCustomDialog(
            context: context,
            icon: Images.dangerSign,
            title: S.of(context)!.getUltrasoundAndPapSmear,
            description: S.of(context)!.possibleCauses,
            options: [
              DialogOption(S.of(context)!.okay, "ok", onClick: () async {
                setState(() {
                  singInViewModel.userRoleId = "4"; // Assign role for menopause
                  gUserType = AppConstants.CYCLE_EXPLORER;
                  globalUserMaster = AppPreferences.instance.getUserDetails();

                  UserMaster userMaster = UserMaster(
                      id: globalUserMaster!.id,
                      name: globalUserMaster!.name,
                      email: globalUserMaster!.email,
                      roleId: 4,
                      uuId: globalUserMaster!.uuId,
                      birthdate: globalUserMaster!.birthdate,
                      age: globalUserMaster!.age,
                      height: globalUserMaster!.height,
                      weight: globalUserMaster!.weight,
                      bmiScore: globalUserMaster!.bmiScore,
                      bmiType: globalUserMaster!.bmiType,
                      badTime: globalUserMaster!.badTime,
                      wakeUpTime: globalUserMaster!.wakeUpTime,
                      totalSleepTime: globalUserMaster!.totalSleepTime,
                      waterMl: globalUserMaster!.waterMl,
                      gender: globalUserMaster!.gender,
                      genderType: globalUserMaster!.genderType,
                      mobile: globalUserMaster!.mobile,
                      deviceToken: globalUserMaster!.deviceToken,
                      image: globalUserMaster!.image,
                      relationshipStatus: globalUserMaster!.relationshipStatus,
                      humApkeHeKon: globalUserMaster!.humApkeHeKon,
                      status: globalUserMaster!.status,
                      state: globalUserMaster!.state,
                      city: globalUserMaster!.city);

                  AppPreferences.instance
                      .setUserDetails(jsonEncode(userMaster));
                  gUserType = singInViewModel.userRoleId.toString();

                  debugPrint("Role ID: ${singInViewModel.userRoleId}");
                  debugPrint("Role ID: ${userMaster.toJson()}");
                });
              })
            ],
            showPurpleButton: true,
          );
        }
      }
    } else {
      await showCustomDialog(
        context: context,
        title: S.of(context)!.youAreNotMenopausal,
        options: [
          DialogOption(S.of(context)!.okay, "ok", onClick: () async {
            setState(() {
              singInViewModel.userRoleId = "2"; // Default role
              gUserType = AppConstants.NEOWME;
              debugPrint("Role ID: ${singInViewModel.userRoleId}");
            });
          })
        ],
        showPurpleButton: true,
      );
    }
  }

//TODO : Old 50+ function
  void askMenstrualStatus() {
    showDialog(
      context: mainNavKey.currentContext!,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: const Text("Menstrual Status"),
          content: const Text("Are you still having periods?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  singInViewModel.userRoleId = "4"; // Assign role for menopause
                  gUserType = AppConstants.CYCLE_EXPLORER;
                  globalUserMaster = AppPreferences.instance.getUserDetails();

                  UserMaster userMaster = UserMaster(
                      id: globalUserMaster!.id,
                      name: globalUserMaster!.name,
                      email: globalUserMaster!.email,
                      roleId: 4,
                      uuId: globalUserMaster!.uuId,
                      birthdate: globalUserMaster!.birthdate,
                      age: globalUserMaster!.age,
                      height: globalUserMaster!.height,
                      weight: globalUserMaster!.weight,
                      bmiScore: globalUserMaster!.bmiScore,
                      bmiType: globalUserMaster!.bmiType,
                      badTime: globalUserMaster!.badTime,
                      wakeUpTime: globalUserMaster!.wakeUpTime,
                      totalSleepTime: globalUserMaster!.totalSleepTime,
                      waterMl: globalUserMaster!.waterMl,
                      gender: globalUserMaster!.gender,
                      genderType: globalUserMaster!.genderType,
                      mobile: globalUserMaster!.mobile,
                      deviceToken: globalUserMaster!.deviceToken,
                      image: globalUserMaster!.image,
                      relationshipStatus: globalUserMaster!.relationshipStatus,
                      humApkeHeKon: globalUserMaster!.humApkeHeKon,
                      status: globalUserMaster!.status,
                      state: globalUserMaster!.state,
                      city: globalUserMaster!.city);

                  AppPreferences.instance
                      .setUserDetails(jsonEncode(userMaster));
                  gUserType = singInViewModel.userRoleId.toString();

                  debugPrint("Role ID: ${singInViewModel.userRoleId}");
                  debugPrint("Role ID: ${userMaster.toJson()}");
                });
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  singInViewModel.userRoleId = "2"; // Default role
                  gUserType = AppConstants.NEOWME;
                  debugPrint("Role ID: ${singInViewModel.userRoleId}");
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WelcomeViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Builder(builder: (context) {
          var lang = Provider.of<AppModel>(context).locale;
          return Scaffold(
            backgroundColor: CommonColors.mTransparent,
            body: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      kCommonSpaceV10,
                      Text(
                        S.of(context)!.letUsknowYouBetter,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 24,
                          fontWeight:
                              lang == "hi" ? FontWeight.w200 : FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context)!.helpUsPersonaliseyourExp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.greyText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kCommonSpaceV30,
                      Image.asset(
                        height: kDeviceHeight / 2,
                        lang == "hi"
                            ? LocalImages.img_saval_javab_hindi
                            : LocalImages.img_saval_javab,
                        fit: BoxFit.cover,
                      ),
                      kCommonSpaceV10,
                      PrimaryButton(
                        width: kDeviceWidth / 1.3,
                        label: S.of(context)!.getStarted,
                        buttonColor: CommonColors.primaryColor,
                        onPress: () {
                          pageController
                              .nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              )
                              .whenComplete(() => setState(() {
                                    showFloatingButton = true;
                                  }));
                        },
                      ),
                      kCommonSpaceV10,
                    ],
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: kCommonScreenPadding,
                    child: Column(
                      children: [
                        kCommonSpaceV10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              "NeoW, ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CommonColors.blackColor,
                                fontSize: 24,
                                fontWeight: lang == "hi"
                                    ? FontWeight.w400
                                    : FontWeight.w600,
                              ),
                            ),
                            Text(
                              S.of(context)!.neowNaamSunaHoga,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CommonColors.blackColor,
                                fontSize: 24,
                                fontWeight: lang == "hi"
                                    ? FontWeight.w200
                                    : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        kCommonSpaceV30,
                        kCommonSpaceV30,
                        Image.asset(
                          LocalImages.FlowerImage,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(LocalImages.img_image_error);
                          },
                        ),
                        kCommonSpaceV15,
                        Container(
                          width: kDeviceWidth / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                kCommonSpaceV15,
                                Text(
                                  S.of(context)!.yourFabulousName,
                                  style: TextStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: lang == "hi"
                                        ? FontWeight.w200
                                        : FontWeight.w500,
                                  ),
                                ),
                                kCommonSpaceV15,
                                LabelTextField(
                                  hintText: S.of(context)!.typeHere,
                                  controller: mNameController,
                                  isOnlyChar: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        kCommonSpaceV50,
                        Text(
                          S.of(context)!.yourgender,
                          // "Whats your gender vibe? fam?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 24,
                            fontWeight: lang == "hi"
                                ? FontWeight.w200
                                : FontWeight.bold,
                          ),
                        ),
                        Text(
                          S.of(context)!.wesupport,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.mGrey,
                            fontSize: 14,
                            fontWeight: lang == "hi"
                                ? FontWeight.normal
                                : FontWeight.w500,
                          ),
                        ),
                        Image.asset(
                          height: kDeviceHeight / 4,
                          LocalImages.img_gender_screen,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(LocalImages.img_image_error);
                          },
                        ),
                        kCommonSpaceV30,
                        if (gUserType == AppConstants.BUDDY ||
                            gUserType == AppConstants.CYCLE_EXPLORER) ...[
                          kCommonSpaceV30,
                          CommonGenderSelectBox(
                              onTap: () {
                                setState(() {
                                  selectedGender = 1;
                                  mOtherController.clear();
                                });
                              },
                              text: S.of(context)!.male,
                              imagePath: LocalImages.img_male,
                              isSelected: selectedGender == 1),
                        ],
                        CommonGenderSelectBox(
                            onTap: () {
                              setState(() {
                                selectedGender = 2;
                                mOtherController.clear();
                              });
                            },
                            text: S.of(context)!.female,
                            imagePath: LocalImages.img_female,
                            isSelected: selectedGender == 2),
                        CommonGenderSelectBox(
                            onTap: () {
                              setState(() {
                                selectedGender = 4;
                                mOtherController.clear();
                              });
                            },
                            text: S.of(context)!.other,
                            imagePath: LocalImages.img_transgender,
                            isSelected: selectedGender == 4),
                        kCommonSpaceV30,
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        kCommonSpaceV10,
                        Text(
                          S.of(context)!.relationshipStatus,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 24,
                            fontWeight: lang == "hi"
                                ? FontWeight.w200
                                : FontWeight.bold,
                          ),
                        ),
                        kCommonSpaceV50,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonRelationSelectBox(
                                onTap: () {
                                  setState(() {
                                    selectedRelation = 1;
                                  });
                                },
                                text: S.of(context)!.solo,
                                imagePath: LocalImages.img_solo,
                                // isBoxFit: true,
                                isShowDefaultBorder: true,
                                isSelected: selectedRelation == 1,
                              ),
                              kCommonSpaceH10,
                              kCommonSpaceH10,
                              CommonRelationSelectBox(
                                onTap: () {
                                  setState(() {
                                    selectedRelation = 2;
                                  });
                                },
                                text: S.of(context)!.tied,
                                imagePath: LocalImages.img_naveli_heart,
                                // isBoxFit: true,
                                isShowDefaultBorder: true,

                                isSelected: selectedRelation == 2,
                              ),
                            ]),
                        CommonRelationSelectBox(
                          onTap: () {
                            setState(() {
                              selectedRelation = 3;
                            });
                          },
                          text: S.of(context)!.openForSurprises,
                          imagePath: LocalImages.img_open_for_surprises,
                          isShowDefaultBorder: true,

                          // isBoxFit: true,
                          isSelected: selectedRelation == 3,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Icon(Icons.arrow_back,
                              color: CommonColors.primaryColor),
                        ),
                      ),
                      kCommonSpaceV20,
                      Text(
                        S.of(context)!.yourJourneyInCandles,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.blackColor,
                          fontSize: 24,
                          fontWeight:
                              lang == "hi" ? FontWeight.w200 : FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context)!.yourJourneyDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CommonColors.greyText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      kCommonSpaceV20,
                      Image.asset(
                        LocalImages.img_your_journey,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      kCommonSpaceV30,
                      SizedBox(
                        // height: 130,
                        width: kDeviceWidth / 1,

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kCommonSpaceV10,
                              LabelTextField(
                                onTap: () async {
                                  selectDate();
                                },
                                hintText: S.of(context)!.selectDate,
                                controller: mDateController,
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (gUserType == AppConstants.BUDDY)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Icon(Icons.arrow_back,
                                  color: CommonColors.primaryColor),
                            ),
                          ),
                          kCommonSpaceV30,
                          SizedBox(
                            child: Image.asset(
                              LocalImages.img_ham_aapke_kon,
                              fit: BoxFit.cover,
                            ),
                          ),
                          kCommonSpaceV30,
                          Container(
                            // height: 130,
                            width: kDeviceWidth / 1.2,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFE5FE).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context)!.hamAapkeKon,
                                    style: getAppStyle(
                                        color: CommonColors.primaryColor,
                                        fontSize: 18),
                                  ),
                                  kCommonSpaceV15,
                                  LabelTextField(
                                    hintText: S.of(context)!.hamAapkeKon,
                                    controller: mAapkeKonController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (gUserType == AppConstants.BUDDY)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(
                        //   child: Image.asset(
                        //     LocalImages.img_ham_aapke_kon,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          // height: 130,
                          width: kDeviceWidth / 1.2,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFE5FE).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context)!.naveliUniqueId,
                                  style: getAppStyle(
                                      color: CommonColors.primaryColor,
                                      fontSize: 18),
                                ),
                                kCommonSpaceV15,
                                LabelTextField(
                                  hintText: S.of(context)!.enterNaveliUid,
                                  controller: mUniqueIdController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                if (gUserType == AppConstants.NEOWME)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Icon(Icons.arrow_back,
                                color: CommonColors.primaryColor),
                          ),
                        ),
                        kCommonSpaceV20,
                        kCommonSpaceV10,
                        Text(
                          S.of(context)!.quickSurveyTime,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 24,
                            fontWeight: lang == "hi"
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        Text(
                          S.of(context)!.helpUsLevelUp,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.greyText,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                            height: Screen.width() / 1.6,
                            child: Image.asset(LocalImages.img_quick_survey)),
                        const Spacer()
                      ],
                    ),
                  ),
              ],
            ),
            bottomNavigationBar: showFloatingButton
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDeviceWidth / 6, vertical: 20),
                    child: PrimaryButton(
                      label: S.of(context)!.next,
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        if (isValid()) {
                          if (currentIndex == 3) {
                            Future.delayed(const Duration(milliseconds: 3200),
                                () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            });
                          } else {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                          if (currentIndex == 3 && selectedRelation == 1) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: CommonColors.mTransparent,
                                  content: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            LocalImages.img_solo_alert,
                                            width: kDeviceWidth / 1.4,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: CommonColors.mWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      16.0), // Rounded corners
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 10),
                                            child: Text(
                                              S.of(context)!.akeleHaiTohKya,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      CommonColors.blackColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ]),
                                  ),
                                );
                              },
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                            });
                          } else if (currentIndex == 3 &&
                              selectedRelation == 2) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: CommonColors.mTransparent,
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Stack(children: [
                                      Align(
                                        child: Image.asset(
                                          LocalImages.heartHands,
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  insetPadding: const EdgeInsets.all(1.0),
                                );
                              },
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                            });
                          } else if (currentIndex == 3 &&
                              selectedRelation == 3) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: CommonColors.mTransparent,
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: kDeviceHeight / 1.5,
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: CommonColors.mWhite,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0), // Rounded corners
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Text(
                                                S.of(context)!.wohHaiKahan,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18),
                                              ),
                                            )),
                                        Stack(
                                          children: [
                                            Transform.translate(
                                              offset: const Offset(20,
                                                  0), // Shift the image 40 pixels to the left
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Image.asset(
                                                  LocalImages.img_waiting_alert,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  insetPadding: const EdgeInsets.all(1.0),
                                );
                              },
                            );
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                            });
                          }
                          if (gUserType == AppConstants.NEOWME ||
                              gUserType == AppConstants.CYCLE_EXPLORER) {
                            print("neow... & cycle...");
                            allData['name'] = mNameController.text.trim();
                            allData['gender'] = selectedGender.toString();
                            if (mOtherController.text.trim().isNotEmpty) {
                              allData['otherGender'] =
                                  mOtherController.text.trim();
                            }
                            allData['relation'] = selectedRelation.toString();
                            allData['birthdate'] = mDateController.text.trim();
                            if (currentIndex == 5 &&
                                gUserType == AppConstants.NEOWME) {
                              push(CycleInfoView(welcomeData: allData));
                            } else if (currentIndex == 4 &&
                                gUserType == AppConstants.CYCLE_EXPLORER) {
                              print("cycle...");
                              CycleInfoViewModel().userUpdateDetailsApi(
                                isFromCycle: true,
                                roleId: "4",
                                name: allData['name'],
                                birthdate: allData['birthdate'],
                                gender: allData['gender'],
                                genderType: allData['otherGender'],
                                relationshipStatus: allData['relation'],
                              );
                            }
                          }
                          if (currentIndex == 6 &&
                              gUserType == AppConstants.BUDDY) {
                            print("buddy...");
                            allData['name'] = mNameController.text.trim();
                            allData['gender'] = selectedGender.toString();
                            if (mOtherController.text.trim().isNotEmpty) {
                              allData['otherGender'] =
                                  mOtherController.text.trim();
                            }
                            allData['relation'] = selectedRelation.toString();
                            allData['birthdate'] = mDateController.text.trim();
                            allData['humAapkeKon'] =
                                mAapkeKonController.text.trim();
                            if (mUniqueIdController.text.trim().isEmpty) {
                              CommonUtils.showSnackBar(
                                S.of(context)!.plEnterUid,
                                color: CommonColors.mRed,
                              );
                            } else {
                              CycleInfoViewModel()
                                  .userUpdateDetailsApi(
                                isFromCycle: true,
                                roleId: "3",
                                name: allData['name'],
                                birthdate: allData['birthdate'],
                                gender: allData['gender'],
                                genderType: allData['otherGender'],
                                relationshipStatus: allData['relation'],
                                humAapkeHeKon: allData['humAapkeKon'],
                              )
                                  .whenComplete(() {
                                mViewModel.verifyUniqueIdApi(
                                    uniqueId: mUniqueIdController.text.trim(),
                                    isFromCycle: true);
                              });
                            }
                          }
                        }
                      },
                    ),
                  )
                : null,
          );
        }),
      ),
    );
  }

  bool isValid() {
    if (currentIndex == 1 && mNameController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterName,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 2 &&
        selectedGender == null &&
        mOtherController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourGender,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 3 && selectedRelation == null) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourRelation,
        color: CommonColors.mRed,
      );
      return false;
    } else if (currentIndex == 4 && mDateController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectYourBday,
        color: CommonColors.mRed,
      );
      return false;
    } else if (gUserType == AppConstants.BUDDY &&
        currentIndex == 5 &&
        mAapkeKonController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plEnterHamAapkeKon,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

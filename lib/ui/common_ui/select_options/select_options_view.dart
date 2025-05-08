import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../ui/common_ui/select_options/select_option_view_model.dart';
import '../../../ui/common_ui/singin/signin_view.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_user_select.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../app/app_model.dart';

class SelectOptionView extends StatefulWidget {
  const SelectOptionView({super.key});

  @override
  State<SelectOptionView> createState() => _SelectOptionViewState();
}

class _SelectOptionViewState extends State<SelectOptionView>
    with TickerProviderStateMixin {
  late SelectOptionViewModel mViewModel;
  String selectedUser = '';
  late AudioPlayer player;

  bool isSelected = false;
  int selectedIndex = 1;

  void setLanguage(String langCode) {
    AppPreferences.instance.setLanguageCode(langCode);
    CommonUtils.languageCode = langCode;
    Provider.of<AppModel>(mainNavKey.currentContext!, listen: false)
        .changeLanguage();
  }

  void changeLanguage(int index) {
    if (index == 1) {
      setLanguage(AppConstants.LANGUAGE_ENGLISH);
    } else if (index == 2) {
      setLanguage(AppConstants.LANGUAGE_HINDI);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    player.setAsset(LocalImages.au_who_are_you);
    // playAudio();
    if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_ENGLISH) {
      selectedIndex = 1;
    } else if (AppPreferences.instance.getLanguageCode() ==
        AppConstants.LANGUAGE_HINDI) {
      selectedIndex = 2;
    }
  }

  Future<void> playAudio() async {
    try {
      await player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SelectOptionViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: ScaffoldBG(
          child: Builder(builder: (context) {
            var lang = Provider.of<AppModel>(context).locale;
            return Center(
              child: SingleChildScrollView(
                padding: kCommonScreenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.of(context)!.whoAreYou,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            lang == "hi" ? FontWeight.w200 : FontWeight.bold,
                        color: Colors.black,
                      ), /* GoogleFonts.piedra(
                          color: CommonColors.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ), */
                    ),
                    Text(
                      S.of(context)!.selectOption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getAppStyle(
                        color: CommonColors.black87,
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    kCommonSpaceV50,
                    CommonUserSelect(
                      onTap: () {
                        setState(() {
                          selectedUser = AppConstants.NEOWME;
                        });
                      },
                      text: S.of(context)!.optionNeow,
                      imagePath: LocalImages.img_neowme,
                      isSelected: selectedUser == AppConstants.NEOWME,
                      descriptionText: S.of(context)!.optionNeowSubtitle,
                    ),
                    kCommonSpaceV15,
                    CommonUserSelect(
                      onTap: () {
                        setState(() {
                          selectedUser = AppConstants.BUDDY;
                        });
                      },
                      text: S.of(context)!.optionBuddy,
                      imagePath: LocalImages.img_buddy,
                      isSelected: selectedUser == AppConstants.BUDDY,
                      descriptionText: S.of(context)!.optionBuddySubtitle,
                    ),
                    kCommonSpaceV15,
                    CommonUserSelect(
                      onTap: () {
                        setState(() {
                          selectedUser = AppConstants.CYCLE_EXPLORER;
                        });
                      },
                      text: S.of(context)!.optionFitness,
                      imagePath: LocalImages.img_cycle_explorer,
                      isSelected: selectedUser == AppConstants.CYCLE_EXPLORER,
                      descriptionText: S.of(context)!.optionFitnessSubtitle,
                    ),
                    kCommonSpaceV50,
                    kCommonSpaceV20,
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CommonColors.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(30.0),
                          color: CommonColors.mTransparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                                changeLanguage(selectedIndex);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: selectedIndex == 1
                                      // ? Color(0xFFC06CF9)
                                      ? CommonColors.primaryColor
                                      : CommonColors.mTransparent),
                              child: Text(
                                "English",
                                style: getAppStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 1
                                        ? CommonColors.mWhite
                                        : CommonColors.blackColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                                changeLanguage(selectedIndex);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: selectedIndex == 2
                                      // ? Color(0xFFC06CF9)
                                      ? CommonColors.primaryColor
                                      : CommonColors.mTransparent),
                              child: Text(
                                "हिंदी",
                                style: getAppStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 2
                                        ? CommonColors.mWhite
                                        : CommonColors.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kCommonSpaceV20,
                    PrimaryButton(
                      width: kDeviceWidth / 1.0,
                      onPress: () {
                        if (selectedUser == '') {
                          CommonUtils.showSnackBar(
                              S.of(context)!.plSelectUserType,
                              color: CommonColors.mRed);
                          return false;
                        } else {
                          if (selectedUser == AppConstants.NEOWME) {
                            // print(selectedUser);
                            push(
                              SignInView(
                                userType: selectedUser,
                              ),
                            );
                          } else if (selectedUser == AppConstants.BUDDY) {
                            // print(selectedUser);
                            push(
                              SignInView(
                                userType: selectedUser,
                              ),
                            );
                          } else if (selectedUser ==
                              AppConstants.CYCLE_EXPLORER) {
                            // print(selectedUser);
                            push(
                              SignInView(
                                userType: selectedUser,
                              ),
                            );
                          }
                        }
                      },
                      label: S.of(context)!.next,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

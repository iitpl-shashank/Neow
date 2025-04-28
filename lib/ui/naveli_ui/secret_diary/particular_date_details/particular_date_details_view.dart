import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/particular_date_details/particular_date_details_view_model.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_secret_diary_container.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_text_field.dart';
import '../../../../widgets/primary_button.dart';

class ParticularDateDetailsView extends StatefulWidget {
  final String selectedDate;
  final String currentMonth;
  final String selectedFullDate;

  const ParticularDateDetailsView(
      {super.key,
      required this.selectedDate,
      required this.currentMonth,
      required this.selectedFullDate});

  @override
  State<ParticularDateDetailsView> createState() =>
      _ParticularDateDetailsViewState();
}

class _ParticularDateDetailsViewState extends State<ParticularDateDetailsView> {
  late ParticularDateDetailsViewModel mViewModel;
  TextEditingController dailyDiaryTextController = TextEditingController();
  TextEditingController toListTextController = TextEditingController();
  TextEditingController editController = TextEditingController();
  bool? isSelected;
  bool? isEditSelected;

  // List<String> emojisText = [
  //   'Happy',
  //   'Sad',
  //   'Bored',
  //   'Rock on',
  //   'Ainvayi',
  //   'Angry',
  //   'Happy',
  //   'Sad',
  //   'Bored',
  //   'Rock on',
  //   'Ainvayi',
  //   'Angry',
  // ];
  // List<int> selectedMoodEmojiIndices = List.generate(12, (index) => -1);
  // List<String?> selectedMoodEmojis = List.filled(20, null);

  // List<int> selectedToDoListEmojiIndices = List.generate(3, (index) => -1);
  // List<String?> selectedToDoListEmojis = List.filled(20, null);

  // List<int> selectedStickerOfDayEmojiIndices = List.generate(3, (index) => -1);
  // List<String?> selectedStickerOfDayEmojis = List.filled(20, null);

  // List<String> emojisList = [
  //   'https://parspng.com/wp-content/uploads/2022/06/imojipng.parspng.com-4.png',
  //   'https://www.cambridge.org/elt/blog/wp-content/uploads/2019/07/Sad-Face-Emoji.png',
  //   'https://w7.pngwing.com/pngs/954/895/png-transparent-emoji-really-sullen-face-without-expression-bored-yellow-message-whatsapp-social-networks.png',
  //   'https://img.freepik.com/premium-vector/let-s-rock-web-sticker-yellow-emoji-cartoon-character-emoticon-smile-face_106878-529.jpg?w=2000',
  //   'https://emojiisland.com/cdn/shop/products/Emoji_Icon_-_Sunglasses_cool_emoji_large.png?v=1571606093',
  //   'https://static-00.iconduck.com/assets.00/angry-face-emoji-1024x1022-arpjzyy8.png',
  //   'https://static-00.iconduck.com/assets.00/smiling-face-with-hearts-emoji-emoji-2026x2048-a7w8b5yr.png',
  //   'https://emojiisland.com/cdn/shop/products/Flushed_Face_Emoji_large.png?v=1571606037',
  //   'https://emojiisland.com/cdn/shop/products/Smiling_Face_Emoji_with_Blushed_Cheeks_large.png?v=1571606036',
  //   'https://cdn2.shopify.com/s/files/1/1061/1924/products/Hugging_Emoji_Icon_91693a52-1ee6-4e6a-b00b-873d23cdbb91_large.png?v=1542446801',
  //   'https://www.pimprint.nl/images/thumbnails/280/200/detailed/2/Smiling_Face_with_Tightly_Closed_eyes@2x.png',
  //   'https://images-eds-ssl.xboxlive.com/image?url=4rt9.lXDC4H_93laV1_eHM0OYfiFeMI2p9MWie0CvL99U4GA1gf6_kayTt_kBblFwHwo8BW8JXlqfnYxKPmmBaM.nlv6lSmXhGY0w.y7u6LH3MY2btzV_PcIS7W272o74EvEDi5S4xhdoBizRBkGiIBHQYZ73JIE5vuEGnrP9W0-&format=source'
  // ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      print("Full date is :: ${widget.selectedFullDate}");
      mViewModel
          .getDailyDiaryDataApi(date: widget.selectedFullDate)
          .whenComplete(() {
        if (mViewModel.edit != null) {
          editController.text = mViewModel.edit ?? '';
        }
        if (mViewModel.gratitude != null) {
          if (mViewModel.gratitude == "1") {
            isSelected = true;
          } else if (mViewModel.gratitude == "0") {
            isSelected = false;
          }
        }
        if (mViewModel.isEdit != null) {
          if (mViewModel.isEdit == "1") {
            isEditSelected = true;
          } else if (mViewModel.isEdit == "0") {
            isEditSelected = false;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ParticularDateDetailsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.dailyDiary,
          textColor: CommonColors.darkPink,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.square_rounded,
                    color: CommonColors.primaryColor,
                    size: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      widget.selectedDate,
                      style: const TextStyle(
                        color: CommonColors.mWhite,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     push(CalendarView());
            //   },
            //   icon: Icon(
            //     Icons.calendar_month_rounded,
            //     color: CommonColors.darkPink,
            //     size: 28,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                widget.currentMonth,
                style: const TextStyle(
                  color: CommonColors.primaryColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              Text(
                S.of(context)!.yourDailyDose,
                textAlign: TextAlign.center,
                style: getAppStyle(
                  color: CommonColors.mGrey,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV10,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 1, mViewModel.selectedMoodEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedMoodEmoji = selectedEmoji;
                          });
                        }
                        print("Mood :: ${mViewModel.selectedMoodEmoji}");
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.mood,
                        defaultImage: LocalImages.img_moods,
                        imagePath: mViewModel.selectedMoodEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 2, mViewModel.selectedMusicEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedMusicEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.music,
                        defaultImage: LocalImages.img_music,
                        imagePath: mViewModel.selectedMusicEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 3, mViewModel.selectedLearningEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedLearningEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.learning,
                        defaultImage: LocalImages.img_learning,
                        imagePath: mViewModel.selectedLearningEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 4, mViewModel.selectedCleaningEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedCleaningEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.cleaning,
                        defaultImage: LocalImages.img_cleaning,
                        imagePath: mViewModel.selectedCleaningEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 5, mViewModel.selectedBodyCareEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedBodyCareEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.bodyCare,
                        defaultImage: LocalImages.img_bodycare,
                        imagePath: mViewModel.selectedBodyCareEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  backgroundColor: const Color(0xFFDDC1FE),
                                  // insetPadding: EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.cancel_rounded,
                                            color: CommonColors.mRed,
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(S.of(context)!.yes),
                                              value: true,
                                              groupValue: isSelected,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isSelected = value;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(S.of(context)!.no),
                                              value: false,
                                              groupValue: isSelected,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isSelected = value;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.gratitude,
                        defaultImage: LocalImages.img_gratitude,
                      ),
                    ),
                  ],
                ),
              ),
              kCommonSpaceV10,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 6, mViewModel.selectedSleepEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedSleepEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.sleep,
                        defaultImage: LocalImages.img_sleep_daily_diary,
                        imagePath: mViewModel.selectedSleepEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 7, mViewModel.selectedWorkoutEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedWorkoutEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.workout,
                        defaultImage: LocalImages.img_workout,
                        imagePath: mViewModel.selectedWorkoutEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 8, mViewModel.selectedHangoutEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedHangoutEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.hangout,
                        defaultImage: LocalImages.img_hangout,
                        imagePath: mViewModel.selectedHangoutEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 9, mViewModel.selectedScreenTimeEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedScreenTimeEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.screenTime,
                        defaultImage: LocalImages.img_screen_time,
                        imagePath: mViewModel.selectedScreenTimeEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () async {
                        String? selectedEmoji =
                            await mViewModel.showEmojiSelectDialog(
                                context, 10, mViewModel.selectedFoodEmoji);
                        if (selectedEmoji != null) {
                          setState(() {
                            mViewModel.selectedFoodEmoji = selectedEmoji;
                          });
                        }
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.food,
                        defaultImage: LocalImages.img_food,
                        imagePath: mViewModel.selectedFoodEmoji,
                      ),
                    ),
                    kCommonSpaceH10,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  backgroundColor: const Color(0xFFDDC1FE),
                                  // insetPadding: EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.cancel_rounded,
                                            color: CommonColors.mRed,
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: LabeledTextField(
                                          hintText: S.of(context)!.edit,
                                          readOnly: mViewModel.edit != null
                                              ? true
                                              : false,
                                          controller: editController,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(S.of(context)!.yes),
                                              value: true,
                                              groupValue: isEditSelected,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isEditSelected = value;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: RadioListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(S.of(context)!.no),
                                              value: false,
                                              groupValue: isEditSelected,
                                              onChanged: (bool? value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isEditSelected = value;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: CommonSecretDiaryContainer(
                        title: S.of(context)!.edit,
                      ),
                    ),
                  ],
                ),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Image.asset(LocalImages.img_daily_dairy),
                  kCommonSpaceH3,
                  Text(
                    S.of(context)!.dailyDiary,
                    style: getAppStyle(
                      color: CommonColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (dailyDiaryTextController.text.trim().isNotEmpty) {
                        setState(() {
                          mViewModel.dailyDairyTextList
                              .add(dailyDiaryTextController.text);
                          dailyDiaryTextController.clear();
                        });
                      }
                    },
                    icon: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.add_circle,
                        color: CommonColors.primaryColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: mViewModel.dailyDairyTextList.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.circle_rounded,
                          size: 10,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                      kCommonSpaceH5,
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            mViewModel.dailyDairyTextList[index],
                            style: getAppStyle(
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
                height: kDeviceHeight / 6.5,
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
                child: Column(
                  children: [
                    SizedBox(
                      // color: Colors.orange,
                      height: kDeviceHeight / 8,
                      child: TextField(
                        controller: dailyDiaryTextController,
                        maxLines: null,
                        maxLength: 250,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          counterText: '',
                          hintStyle: getAppStyle(
                            color: CommonColors.mGrey,
                            fontSize: 14,
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
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          S.of(context)!.max250Char,
                          style: getAppStyle(
                            color: CommonColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              kCommonSpaceV20,
              Row(
                children: [
                  Image.asset(
                    LocalImages.img_todo_list,
                    fit: BoxFit.cover,
                  ),
                  kCommonSpaceH3,
                  Text(
                    S.of(context)!.toDoList,
                    style: getAppStyle(
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (toListTextController.text.trim().isNotEmpty) {
                        setState(() {
                          mViewModel.toDoListText
                              .add(toListTextController.text);
                          toListTextController.clear();
                        });
                      }
                    },
                    icon: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.add_circle,
                        color: CommonColors.primaryColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: mViewModel.toDoListText.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.circle_rounded,
                          size: 10,
                          color: CommonColors.primaryColor,
                        ),
                      ),
                      kCommonSpaceH5,
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            mViewModel.toDoListText[index],
                            style: getAppStyle(
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
                height: kDeviceHeight / 6.5,
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
                child: Column(
                  children: [
                    SizedBox(
                      // color: Colors.orange,
                      height: kDeviceHeight / 8,
                      child: TextField(
                        controller: toListTextController,
                        maxLines: null,
                        maxLength: 250,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          counterText: '',
                          hintStyle: getAppStyle(
                            color: CommonColors.mGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          hintText: S.of(context)!.addYourBullet,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          S.of(context)!.max250Char,
                          style: getAppStyle(
                            color: CommonColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              kCommonSpaceV20,
              PrimaryButton(
                width: kDeviceWidth / 2,
                onPress: () {
                  mViewModel.storeDailyDiaryApi(
                      currentDate: widget.selectedFullDate,
                      mood: mViewModel.selectedMoodEmoji,
                      music: mViewModel.selectedMusicEmoji,
                      learning: mViewModel.selectedLearningEmoji,
                      cleaning: mViewModel.selectedCleaningEmoji,
                      bodyCare: mViewModel.selectedBodyCareEmoji,
                      gratitude: isSelected,
                      hangOut: mViewModel.selectedHangoutEmoji,
                      workOut: mViewModel.selectedWorkoutEmoji,
                      screenTime: mViewModel.selectedScreenTimeEmoji,
                      food: mViewModel.selectedFoodEmoji,
                      sleep: mViewModel.selectedSleepEmoji,
                      edit: editController.text.trim(),
                      isEdit: isEditSelected,
                      toDoList: mViewModel.toDoListText,
                      dailyDairy: mViewModel.dailyDairyTextList);
                },
                label: S.of(context)!.submit,
              ),
              // GridView.count(
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 20.0,
              //   crossAxisSpacing: 80.0,
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     Container(
              //       width: 100,
              //       height: 100,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage(LocalImages.emoji_testy),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     ...List.generate(
              //       selectedToDoListEmojiIndices.length,
              //       (index) {
              //         return InkWell(
              //           onTap: () => showToDoListDialog(context, index),
              //           child: selectedToDoListEmojis[index] != null
              //               ? Container(
              //                   width: 100,
              //                   height: 100,
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: NetworkImage(
              //                           selectedToDoListEmojis[index]!),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 )
              //               : CommonAddSticker(),
              //         );
              //       },
              //     ),
              //   ],
              // ),
              // *** Sticker of the day *** //
              // kCommonSpaceV20,
              // Row(
              //   children: [
              //     Image.asset(
              //       LocalImages.emoji_sticker_of_day,
              //       fit: BoxFit.cover,
              //     ),
              //     kCommonSpaceH3,
              //     Text(
              //       'Sticker of the Day',
              //       style: getAppStyle(
              //           color: CommonColors.blackColor,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 18),
              //     ),
              //   ],
              // ),
              // kCommonSpaceV20,
              // GridView.count(
              //   padding: EdgeInsets.only(left: 20, right: 20),
              //   crossAxisCount: 2,
              //   mainAxisSpacing: 20.0,
              //   crossAxisSpacing: 80.0,
              //   physics: NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage(LocalImages.emoji_testy),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     ...List.generate(
              //       selectedStickerOfDayEmojiIndices.length,
              //       (index) {
              //         return InkWell(
              //           onTap: () => showStickerOfDayListDialog(context, index),
              //           child: selectedStickerOfDayEmojis[index] != null
              //               ? Container(
              //                   decoration: BoxDecoration(
              //                     image: DecorationImage(
              //                       image: NetworkImage(
              //                           selectedStickerOfDayEmojis[index]!),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 )
              //               : CommonAddSticker(),
              //         );
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

// Future<void> showMoodSelectionDialog(BuildContext context, int index) async {
//   String? selectedEmoji = await showDialog<String?>(
//     context: context,
//     builder: (BuildContext dialogContext) {
//       return Dialog(
//         insetPadding: EdgeInsets.all(15.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Container(
//           width: 390,
//           decoration: ShapeDecoration(
//             color: Color(0xFFFDE6E9),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 kCommonSpaceV10,
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: Text(
//                     'Mood',
//                     style: getAppStyle(
//                       color: CommonColors.darkYellow,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       height: 0,
//                     ),
//                   ),
//                 ),
//                 kCommonSpaceV20,
//                 Expanded(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: emojisList.length,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 20,
//                     ),
//                     itemBuilder: (context, emojiIndex) {
//                       final emoji = emojisList[emojiIndex];
//                       final isEmojiSelected =
//                           selectedMoodEmojis.contains(emoji);
//                       return GestureDetector(
//                         onTap: () {
//                           if (!isEmojiSelected) {
//                             Navigator.pop(context, emojisList[emojiIndex]);
//                             _showGifDialog(context);
//                           }
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 100,
//                               height: 100,
//                               decoration: ShapeDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(emojisList[emojiIndex]),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 shape: OvalBorder(
//                                   side: BorderSide(
//                                     width: 2,
//                                     color: isEmojiSelected
//                                         ? CommonColors.darkYellow
//                                         : CommonColors.mWhite,
//                                   ),
//                                 ),
//                                 shadows: [
//                                   BoxShadow(
//                                     color: Color(0x3F000000),
//                                     blurRadius: 4,
//                                     offset: Offset(0, 4),
//                                     spreadRadius: 0,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             kCommonSpaceV10,
//                             Text(
//                               emojisText[emojiIndex],
//                               style: TextStyle(
//                                 color: isEmojiSelected
//                                     ? CommonColors.darkYellow
//                                     : CommonColors.blackColor,
//                                 fontSize: 22,
//                                 fontFamily: 'Outfit',
//                                 fontWeight: FontWeight.w500,
//                                 height: 0.04,
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 kCommonSpaceV20,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(
//                           color: Color(0xFFFF0000),
//                           fontSize: 18,
//                           fontFamily: 'Outfit',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Handle Ok button press
//                         // Add your logic here
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         'Ok',
//                         style: TextStyle(
//                           color: Color(0xFF02640C),
//                           fontSize: 18,
//                           fontFamily: 'Outfit',
//                           fontWeight: FontWeight.w500,
//                           height: 0.06,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//   if (selectedMoodEmojis != null) {
//     setState(() {
//       selectedMoodEmojis[index] = selectedEmoji;
//     });
//   }
// }

// Future<void> showToDoListDialog(BuildContext context, int index) async {
//   String? selectedEmoji = await showDialog<String?>(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0)),
//           //this right here
//           child: Container(
//             width: 390,
//             decoration: ShapeDecoration(
//               color: Color(0xFFFDE6E9),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   kCommonSpaceV10,
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Text(
//                       'Mood',
//                       style: TextStyle(
//                         color: Color(0xFFF79C03),
//                         fontSize: 18,
//                         fontFamily: 'Outfit',
//                         fontWeight: FontWeight.w500,
//                         height: 0,
//                       ),
//                     ),
//                   ),
//                   kCommonSpaceV20,
//                   // Expanded(
//                   //   child: GridView.builder(
//                   //     shrinkWrap: true,
//                   //     itemCount: emojisList.length,
//                   //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //         crossAxisCount: 3, mainAxisSpacing: 20),
//                   //     itemBuilder: (context, emojiIndex) {
//                   //       final emoji = emojisList[emojiIndex];
//                   //       final isEmojiSelected =
//                   //           selectedToDoListEmojis.contains(emoji);
//                   //       return GestureDetector(
//                   //         onTap: () {
//                   //           if (!isEmojiSelected) {
//                   //             Navigator.pop(context, emojisList[emojiIndex]);
//                   //             _showGifDialog(context);
//                   //           }
//                   //         },
//                   //         child: Column(
//                   //           children: [
//                   //             Container(
//                   //               width: 100,
//                   //               height: 100,
//                   //               decoration: ShapeDecoration(
//                   //                 image: DecorationImage(
//                   //                   image:
//                   //                       NetworkImage(emojisList[emojiIndex]),
//                   //                   fit: BoxFit.cover,
//                   //                 ),
//                   //                 shape: OvalBorder(
//                   //                   side: BorderSide(
//                   //                     width: 2,
//                   //                     color: isEmojiSelected
//                   //                         ? CommonColors.darkYellow
//                   //                         : CommonColors.mWhite,
//                   //                   ),
//                   //                 ),
//                   //                 shadows: [
//                   //                   BoxShadow(
//                   //                     color: Color(0x3F000000),
//                   //                     blurRadius: 4,
//                   //                     offset: Offset(0, 4),
//                   //                     spreadRadius: 0,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //             ),
//                   //             kCommonSpaceV10,
//                   //             Text(
//                   //               emojisText[emojiIndex],
//                   //               style: TextStyle(
//                   //                 color: isEmojiSelected
//                   //                     ? CommonColors.darkYellow
//                   //                     : CommonColors.blackColor,
//                   //                 fontSize: 22,
//                   //                 fontFamily: 'Outfit',
//                   //                 fontWeight: FontWeight.w500,
//                   //                 height: 0.04,
//                   //               ),
//                   //             )
//                   //           ],
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                   kCommonSpaceV20,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           'Cancle',
//                           style: TextStyle(
//                             color: Color(0xFFFF0000),
//                             fontSize: 18,
//                             fontFamily: 'Outfit',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             'Ok',
//                             style: TextStyle(
//                               color: Color(0xFF02640C),
//                               fontSize: 18,
//                               fontFamily: 'Outfit',
//                               fontWeight: FontWeight.w500,
//                               height: 0.06,
//                             ),
//                           )),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
//   // if (selectedToDoListEmojis != null) {
//   //   setState(() {
//   //     selectedToDoListEmojis[index] = selectedEmoji;
//   //   });
//   // }
// }
//
// Future<void> showStickerOfDayListDialog(
//     BuildContext context, int index) async {
//   String? selectedEmoji = await showDialog<String?>(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.all(15.0),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0)),
//           //this right here
//           child: Container(
//             decoration: ShapeDecoration(
//               color: Color(0xFFFDE6E9),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   kCommonSpaceV10,
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Text(
//                       'Mood',
//                       style: TextStyle(
//                         color: Color(0xFFF79C03),
//                         fontSize: 18,
//                         fontFamily: 'Outfit',
//                         fontWeight: FontWeight.w500,
//                         height: 0,
//                       ),
//                     ),
//                   ),
//                   kCommonSpaceV20,
//                   Expanded(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: emojisList.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3, mainAxisSpacing: 20),
//                       itemBuilder: (context, emojiIndex) {
//                         final emoji = emojisList[emojiIndex];
//                         final isEmojiSelected =
//                             selectedStickerOfDayEmojis.contains(emoji);
//                         return GestureDetector(
//                           onTap: () {
//                             if (!isEmojiSelected) {
//                               Navigator.pop(context, emojisList[emojiIndex]);
//                               _showGifDialog(context);
//                             }
//                           },
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 100,
//                                 height: 100,
//                                 decoration: ShapeDecoration(
//                                   image: DecorationImage(
//                                     image:
//                                         NetworkImage(emojisList[emojiIndex]),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   shape: OvalBorder(
//                                     side: BorderSide(
//                                       width: 2,
//                                       color: isEmojiSelected
//                                           ? CommonColors.darkYellow
//                                           : CommonColors.mWhite,
//                                     ),
//                                   ),
//                                   shadows: [
//                                     BoxShadow(
//                                       color: Color(0x3F000000),
//                                       blurRadius: 4,
//                                       offset: Offset(0, 4),
//                                       spreadRadius: 0,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               kCommonSpaceV10,
//                               Text(
//                                 emojisText[emojiIndex],
//                                 style: TextStyle(
//                                   color: isEmojiSelected
//                                       ? CommonColors.darkYellow
//                                       : CommonColors.blackColor,
//                                   fontSize: 22,
//                                   fontFamily: 'Outfit',
//                                   fontWeight: FontWeight.w500,
//                                   height: 0.04,
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   kCommonSpaceV20,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           'Cancle',
//                           style: TextStyle(
//                             color: Color(0xFFFF0000),
//                             fontSize: 18,
//                             fontFamily: 'Outfit',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             'Ok',
//                             style: TextStyle(
//                               color: Color(0xFF02640C),
//                               fontSize: 18,
//                               fontFamily: 'Outfit',
//                               fontWeight: FontWeight.w500,
//                               height: 0.06,
//                             ),
//                           )),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
//   if (selectedStickerOfDayEmojis != null) {
//     setState(() {
//       selectedStickerOfDayEmojis[index] = selectedEmoji;
//     });
//   }
// }
//
// void _showGifDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       Future.delayed(Duration(milliseconds: 1500), () {
//         Navigator.of(context).pop();
//       });
//       return Dialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: Container(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 'assets/gif/gif_wow.gif',
//                 fit: BoxFit.cover,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}

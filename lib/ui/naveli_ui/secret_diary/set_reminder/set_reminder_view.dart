import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/set_reminder/set_reminder_view_model.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_text_field.dart';
import '../secret_diary_view_model.dart';

class SetReminderView extends StatefulWidget {
  const SetReminderView({super.key});

  @override
  State<SetReminderView> createState() => _SetReminderViewState();
}

class _SetReminderViewState extends State<SetReminderView> {
  late SecretDiaryViewModel mViewModel;
  late SetReminderViewModel mSetReminderViewModel;
  DateTime now = DateTime.now();

  String dropdownValue = 'Reminder type';
  DateTime? selectedDate;

  TextEditingController reminderForController = TextEditingController();
  List<MonthModel> tappedMonthList = [];
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> shortMonthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  var currentMonth = DateFormat.MMMM().format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mSetReminderViewModel.attachedContext(context);
      mSetReminderViewModel.getMonthlyReminderDataApi();
    });
  }

  String? getEmojiForReminder(String reminderType) {
    switch (reminderType.toLowerCase()) {
      case 'birthday':
        return '🎂'; // Birthday emoji
      case 'special day':
        return '🎉'; // Special day emoji
      case 'meeting':
        return '🤝'; // Meeting emoji
      case 'go trip':
        return '✈️'; // Trip emoji
      case 'shopping':
        return '🛍️'; // Shopping emoji
      default:
        return null; // Return null for unmatched types
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SecretDiaryViewModel>(context);
    mSetReminderViewModel = Provider.of<SetReminderViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.monthlyReminder,
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
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Text(
                //       'Reminder Date ',
                //       style: TextStyle(
                //         color: CommonColors.blackColor,
                //         fontSize: 18,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     Icon(
                //       Icons.circle_notifications_sharp,
                //       color: CommonColors.darkPink,
                //     ),
                //   ],
                // ),
                Text(
                  S.of(context)!.neverMissADate,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kCommonSpaceV50,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: monthNames.length,
                  itemBuilder: (context, index) {
                    String monthName = monthNames[index];
                    List<String> reminderEmojis = [];
                    for (var data
                        in mSetReminderViewModel.monthlyReminderDataList) {
                      if (data.reminderMonth == monthName) {
                        String? reminderTypeEmoji =
                            getEmojiForReminder(data.reminderType!);
                        if (reminderTypeEmoji != null) {
                          reminderEmojis.add(reminderTypeEmoji);
                        }
                      }
                    }
                    return GestureDetector(
                      onTap: () {
                        String selectedMonthName = monthNames[index];
                        tappedMonthList = mViewModel.monthList
                            .where(
                                (month) => month.monthName == selectedMonthName)
                            .toList();
                        showReminderDialog(tappedMonthList);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFDDC1FE).withOpacity(0.7),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                shortMonthNames[index],
                                style: getGoogleFontStyle(
                                  color: CommonColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (reminderEmojis.isNotEmpty)
                                Text(
                                  textAlign: TextAlign.center,
                                  reminderEmojis.join(
                                      ' '), // Join emojis into a single string
                                  style: const TextStyle(fontSize: 20),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (mSetReminderViewModel.currentMonthReminders.isNotEmpty) ...[
                  kCommonSpaceV30,
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "$currentMonth ${S.of(context)!.reminder} :",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  kCommonSpaceV10,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount:
                        mSetReminderViewModel.currentMonthReminders.length,
                    itemBuilder: (context, index) {
                      var reminder =
                          mSetReminderViewModel.currentMonthReminders[index];
                      String formattedDate = DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(reminder.reminderDate!));
                      String emoji =
                          getEmojiForReminder(reminder.reminderType!) ?? '';
                      String formattedReminder =
                          '$formattedDate $emoji ${reminder.reminderType} ${reminder.reminderFor}';
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 5),
                          //   child: Icon(
                          //     Icons.circle_rounded,
                          //     size: 5,
                          //   ),
                          // ),
                          kCommonSpaceH5,
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "• $formattedReminder",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getAppStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showReminderDialog(List<MonthModel> tappedMonthList) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kCommonSpaceV10,
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(
                                S.of(context)!.reminderDate,
                                style: const TextStyle(
                                  color: CommonColors.darkPink,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.circle_notifications_sharp,
                                color: CommonColors.darkPink,
                              ),
                            ],
                          ),
                        ),
                        kCommonSpaceV20,
                        ListView.builder(
                          itemCount: tappedMonthList.length,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: tappedMonthList.map((month) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: List.generate(
                                        mViewModel.weekDay.length,
                                        (index) => Flexible(
                                          child: Text(
                                            mViewModel.weekDay[index],
                                            style: const TextStyle(
                                              color: CommonColors.blackColor,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
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
                                        month.daysList.length,
                                        (dayIndex) {
                                          if (month.daysList[dayIndex].year ==
                                              -1) {
                                            return Container();
                                          } else {
                                            DateTime currentDate =
                                                month.daysList[dayIndex];
                                            bool isSelected = selectedDate !=
                                                    null &&
                                                currentDate == selectedDate!;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (isSelected) {
                                                    selectedDate = null;
                                                  } else {
                                                    selectedDate = currentDate;
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: isSelected
                                                      ? ShapeDecoration(
                                                          color: const Color(
                                                              0xFFFF3351),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                              width: 2,
                                                              color:
                                                                  CommonColors
                                                                      .mWhite,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          shadows: const [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0x3F000000),
                                                              blurRadius: 4,
                                                              offset:
                                                                  Offset(0, 4),
                                                              spreadRadius: 0,
                                                            )
                                                          ],
                                                        )
                                                      : null,
                                                  child: Center(
                                                    child: Text(
                                                      month.daysList[dayIndex]
                                                          .day
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? CommonColors
                                                                .mWhite
                                                            : CommonColors
                                                                .blackColor,
                                                        fontSize: 18,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),
                        kCommonSpaceV20,
                        Center(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context)!.reminderType,
                                  style: const TextStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 18,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                kCommonSpaceV3,
                                Container(
                                  width: kDeviceWidth / 1.2,
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: CommonColors.mWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded),
                                        style: const TextStyle(
                                          color: CommonColors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Reminder type',
                                          'Birthday',
                                          'Special day',
                                          'Meeting',
                                          'Go Trip',
                                          'Shopping'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        kCommonSpaceV20,
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context)!.reminderFor,
                                style: const TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 18,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              kCommonSpaceV3,
                              Container(
                                width: kDeviceWidth / 1.2,
                                height: 50,
                                decoration: ShapeDecoration(
                                  color: CommonColors.mWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: LabelTextField(
                                    controller: reminderForController,
                                    hintText: S.of(context)!.reminderFor,
                                  ),
                                ),
                              ),
                            ],
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
                              child: Text(
                                S.of(context)!.cancel,
                                style: const TextStyle(
                                  color: Color(0xFFFF0000),
                                  fontSize: 18,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (isValid()) {
                                    print(
                                        'Reminder month: ${tappedMonthList[0].monthName}');
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate!);
                                    print('Reminder date: $formattedDate');
                                    print('Reminder type: $dropdownValue');
                                    print(
                                        'Reminder for: ${reminderForController.text}');
                                    String reminderMonth =
                                        tappedMonthList[0].monthName.toString();
                                    String reminderType = dropdownValue;
                                    String reminderFor =
                                        reminderForController.text.trim();
                                    mSetReminderViewModel
                                        .storeMonthlyReminderApi(
                                            reminderDate: formattedDate,
                                            reminderMonth: reminderMonth,
                                            reminderType: reminderType,
                                            reminderFor: reminderFor)
                                        .whenComplete(() {
                                      selectedDate = null;
                                      dropdownValue = 'Reminder type';
                                      reminderForController.clear();
                                      Navigator.pop(context);
                                    });

                                    //**

                                    // pushReplacement(
                                    //   SecretDiaryView(
                                    //     reminderMonth: reminderMonth,
                                    //     selectedDate: reminderDate,
                                    //     reminderType: reminderType,
                                    //   ),
                                    // );
                                  }
                                },
                                child: Text(
                                  S.of(context)!.ok,
                                  style: const TextStyle(
                                    color: Color(0xFF02640C),
                                    fontSize: 18,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    height: 0.06,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  bool isValid() {
    if (selectedDate == null) {
      CommonUtils.showRedToastMessage(
        S.of(context)!.plSlReminderDate,
        // color: CommonColors.mRed,
      );
      return false;
    } else if (dropdownValue == 'Reminder type') {
      CommonUtils.showRedToastMessage(
        S.of(context)!.plSlReminderType,
        // color: CommonColors.mRed
      );
      return false;
    } else if (reminderForController.text.trim().isEmpty) {
      CommonUtils.showRedToastMessage(
        S.of(context)!.plSlReminderFor,
        // color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

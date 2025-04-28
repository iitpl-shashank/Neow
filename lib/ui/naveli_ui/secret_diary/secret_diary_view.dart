import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/particular_date_details/particular_date_details_view.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/reflections/reflections_view.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/secret_diary_view_model.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/set_reminder/set_reminder_view.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_utils.dart';
import '../../../widgets/scaffold_bg.dart';
import 'more/more_view.dart';

class SecretDiaryView extends StatefulWidget {
  final String? reminderMonth;
  final String? selectedDate;
  final String? reminderType;

  const SecretDiaryView(
      {super.key, this.reminderMonth, this.selectedDate, this.reminderType});

  @override
  State<SecretDiaryView> createState() => _SecretDiaryViewState();
}

class _SecretDiaryViewState extends State<SecretDiaryView> {
  late SecretDiaryViewModel mViewModel;

  int cIndex = -1;
  var currentMonth = DateFormat.MMMM().format(DateTime.now());
  final currentMonthNumber = DateTime.now().month;
  String bannerImagePath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.selectedDate);
    print(widget.reminderMonth);
    print(widget.reminderType);
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      bannerImagePath = _getBannerImagePath(currentMonthNumber);
      mViewModel.getFestivalListApi();
    });
  }

  String _getBannerImagePath(int month) {
    switch (month) {
      case 1:
        return LocalImages.img_jan_banner;
      case 2:
        return LocalImages.img_feb_banner;
      case 3:
        return LocalImages.img_march_banner;
      case 4:
        return LocalImages.img_april_banner;
      case 5:
        return LocalImages.img_may_banner;
      case 6:
        return LocalImages.img_june_banner;
      case 7:
        return LocalImages.img_july_banner;
      case 8:
        return LocalImages.img_aug_banner;
      case 9:
        return LocalImages.img_sep_banner;
      case 10:
        return LocalImages.img_oct_banner;
      case 11:
        return LocalImages.img_nov_banner;
      case 12:
        return LocalImages.img_dec_banner;
      default:
        return LocalImages.img_no_data_found;
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<SecretDiaryViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.secretDiary,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context)!.welcomeToSecret,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.mGrey,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kCommonSpaceV10,
                Image.asset(
                  bannerImagePath,
                ),
                kCommonSpaceV10,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      itemCount: mViewModel.currentMonthList.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                mViewModel.weekDay.length,
                                (index) => Flexible(
                                  child: Text(
                                    mViewModel.weekDay[index],
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
                                  mViewModel.currentMonthList[index].daysList
                                      .length, (dayIndex) {
                                if (mViewModel.currentMonthList[index]
                                        .daysList[dayIndex].year ==
                                    -1) {
                                  return Container();
                                } else {}

                                int year =
                                    mViewModel.currentMonthList[index].year;
                                int month = mViewModel
                                    .currentMonthList[index].monthNumber;
                                int day = mViewModel.currentMonthList[index]
                                    .daysList[dayIndex].day;

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
                                            mViewModel.currentMonthList[index]
                                                .daysList[dayIndex].day
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
                            // GridView.count(
                            //   crossAxisCount: 7,
                            //   shrinkWrap: true,
                            //   physics: ClampingScrollPhysics(),
                            //   children: List.generate(
                            //       mViewModel.currentMonthList[index].daysList
                            //           .length, (dayIndex) {
                            //     if (mViewModel.currentMonthList[index]
                            //             .daysList[dayIndex].year ==
                            //         -1) {
                            //       return Container();
                            //     } else {}
                            //
                            //     int day = mViewModel.currentMonthList[index]
                            //         .daysList[dayIndex].day;
                            //
                            //     return Center(
                            //       child: GestureDetector(
                            //         onTap: () {
                            //           push(ParticularDateDetailsView(
                            //             selectedDate: mViewModel
                            //                 .currentMonthList[index]
                            //                 .daysList[dayIndex]
                            //                 .day
                            //                 .toString(),
                            //             currentMonth: currentMonth,
                            //           ));
                            //         },
                            //         // onTap: () {
                            //         //   if (selectedDays.contains(day)) {
                            //         //     selectedDays.remove(day);
                            //         //   } else {
                            //         //     selectedDays.add(day);
                            //         //   }
                            //         //   setState(() {});
                            //         // },
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(1.0),
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //                 // color: selectedDays.contains(day)
                            //                 //     ? Color(0x7FF32C5A)
                            //                 //     : Colors.transparent,
                            //                 // shape: RoundedRectangleBorder(
                            //                 //     side: BorderSide(
                            //                 //         width: 1,
                            //                 //         color: CommonColors.primaryColor),
                            //                 // ),
                            //                 ),
                            //             child: CustomPaint(
                            //               painter: DottedBorderPainter(),
                            //               child: Align(
                            //                   alignment: Alignment.topLeft,
                            //                   child: Text(
                            //                     mViewModel
                            //                         .currentMonthList[index]
                            //                         .daysList[dayIndex]
                            //                         .day
                            //                         .toString(),
                            //                     style: GoogleFonts.ultra(
                            //                         fontSize: 11,
                            //                         color: CommonColors.darkPink
                            //                         // color: selectedDays.contains(day)
                            //                         //     ? CommonColors.mWhite
                            //                         //     : Colors.black,
                            //                         ),
                            //                   )),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   }),
                            // ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    push(const MoreView());
                                  },
                                  child: const Icon(
                                    Icons.add_box,
                                    color: CommonColors.A43786,
                                  ),
                                ),
                                kCommonSpaceH5,
                                InkWell(
                                  onTap: () {
                                    push(const ReflectionsView());
                                  },
                                  child: const Icon(Icons.more_horiz_outlined),
                                ),
                                kCommonSpaceH5,
                                InkWell(
                                  onTap: () {
                                    push(const SetReminderView());
                                  },
                                  child: const Icon(
                                    Icons.notifications_sharp,
                                    color: CommonColors.darkPink,
                                  ),
                                )
                              ],
                            ),
                            kCommonSpaceV20,
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: mViewModel.festivalList.length,
                              itemBuilder: (context, index) {
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "• ${mViewModel.festivalList[index]}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: getAppStyle(
                                            color: CommonColors.blackColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      }),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         push(SetReminderView());
                //       },
                //       child: Container(
                //         width: 125,
                //         height: 40,
                //         decoration: ShapeDecoration(
                //           color: CommonColors.primaryColor,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Set Reminder',
                //             style: getAppStyle(
                //               color: CommonColors.mWhite,
                //               fontSize: 16,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         push(MoreView());
                //       },
                //       child: Container(
                //         width: 80,
                //         height: 40,
                //         decoration: ShapeDecoration(
                //           color: CommonColors.A43786,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //         ),
                //         child: Center(
                //           child: Text(
                //             'More',
                //             style: getAppStyle(
                //               color: CommonColors.mWhite,
                //               fontSize: 16,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () {
                //         push(ReflectionsView());
                //       },
                //       child: Container(
                //         width: 120,
                //         height: 40,
                //         decoration: ShapeDecoration(
                //           color: CommonColors.primaryColor,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Reflections',
                //             style: getAppStyle(
                //               color: CommonColors.mWhite,
                //               fontSize: 16,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //     child: Column(
        //       children: [
        //         ListView.separated(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           padding: const EdgeInsets.symmetric(vertical: 20),
        //           itemCount: 5,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               title: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "\u2022",
        //                     style: getAppStyle(
        //                         fontWeight: FontWeight.w400,
        //                         fontSize: 25,
        //                         color: CommonColors.blackColor),
        //                   ),
        //                   kCommonSpaceH10,
        //                   Flexible(
        //                     child: Text(
        //                       'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Isomass been the industry',
        //                       textAlign: TextAlign.left,
        //                       style: getAppStyle(
        //                           fontWeight: FontWeight.w400,
        //                           fontSize: 15,
        //                           color: CommonColors.blackColor),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           },
        //           separatorBuilder: (context, index) {
        //             return Container(
        //               height: 10,
        //             );
        //           },
        //         ),
        //         Align(
        //           alignment: Alignment.topLeft,
        //           child: Text(
        //             S.of(context)!.reminder,
        //             style: getAppStyle(
        //                 fontWeight: FontWeight.w400,
        //                 fontSize: 15,
        //                 color: CommonColors.blackColor),
        //           ),
        //         ),
        //         kCommonSpaceV30,
        //         SizedBox(
        //           width: 180,
        //           height: 35,
        //           child: PrimaryButton(
        //             onPress: () async {
        //               TimeOfDay? picked = await showTimePicker(
        //                   context: context,
        //                   initialTime: TimeOfDay.now(),
        //                   //initialEntryMode: TimePickerEntryMode.inputOnly,
        //                   builder: (BuildContext? context, Widget? child) {
        //                     return MediaQuery(
        //                       data: MediaQuery.of(context!)
        //                           .copyWith(alwaysUse24HourFormat: false),
        //                       child: child!,
        //                     );
        //                   });
        //               if (picked != null) {}
        //             },
        //             label: S.of(context)!.setReminder,
        //             lblSize: 14,
        //             buttonColor: CommonColors.A43786,
        //             borderRadius: BorderRadius.circular(20.0),
        //           ),
        //         ),
        //         kCommonSpaceV30,
        //         Align(
        //           alignment: Alignment.topLeft,
        //           child: Text(
        //             S.of(context)!.mood,
        //             style: getAppStyle(
        //                 fontWeight: FontWeight.w400,
        //                 fontSize: 15,
        //                 color: CommonColors.blackColor),
        //           ),
        //         ),
        //         kCommonSpaceV20,
        //         ListView.builder(
        //           shrinkWrap: true,
        //           physics: const NeverScrollableScrollPhysics(),
        //           itemCount: emoji.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Wrap(
        //               children: [
        //                 InkWell(
        //                   onTap: () {
        //                     setState(() {
        //                       cIndex = index;
        //                     });
        //                   },
        //                   child: Text(
        //                     emoji[index],
        //                     textAlign: TextAlign.left,
        //                     style: getAppStyle(fontSize: 40),
        //                   ),
        //                 ),
        //               ],
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: "Add secrets",
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

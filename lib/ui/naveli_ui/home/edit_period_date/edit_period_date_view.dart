import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../../common_ui/bottom_navbar/bottom_navbar_view.dart';
import '../../../common_ui/bottom_navbar/bottom_navbar_view_model.dart';
import '../../../common_ui/splash/splash_view_model.dart';
import '../../cycle_info/cycle_info_view_model.dart';

class EditPeriodDateView extends StatefulWidget {
  const EditPeriodDateView({super.key});

  @override
  State<EditPeriodDateView> createState() => _EditPeriodDateViewState();
}

class _EditPeriodDateViewState extends State<EditPeriodDateView> {
  DateTime? selectedDate;
  String? selectedPreviousPeriodDate;
  FixedExtentScrollController? scrollController;
  late CycleInfoViewModel mCycleViewModel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mCycleViewModel.attachedContext(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mCycleViewModel = Provider.of<CycleInfoViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: const CommonAppBar(title: "Edit Period Date"),
          body: SingleChildScrollView(
            padding: kCommonScreenPadding,
            child: Column(
              children: [
                kCommonSpaceV20,
                SizedBox(
                  child: Image.asset(
                    LocalImages.img_naveli_cloud,
                  ),
                ),
                kCommonSpaceV20,
                Text(
                  S.of(context)!.whenDidYour,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.piedra(
                    color: CommonColors.primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 230,
                  // color: Colors.amberAccent,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: ListWheelScrollView(
                      itemExtent: 100,
                      diameterRatio: .8,
                      physics: const FixedExtentScrollPhysics(),
                      perspective: 0.005,
                      controller: scrollController,
                      onSelectedItemChanged: (value) {
                        // DateTime selectedDate = DateTime.now().subtract(Duration(days: value));
                        // selectedPreviousPeriodDate = selectedDate.day;
                        DateTime selectedDate =
                            DateTime.now().subtract(Duration(days: value));
                        selectedPreviousPeriodDate =
                            '${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}';
                      },
                      children: List.generate(
                        60,
                        (index) {
                          DateTime date =
                              DateTime.now().subtract(Duration(days: index));
                          String formattedDate =
                              DateFormat('d MMM yyyy').format(date);

                          return Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: CommonColors.A43786,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                formattedDate,
                                textAlign: TextAlign.center,
                                style: getAppStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CommonColors.mWhite,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  width: kDeviceWidth / 2,
                  onPress: () {
                    if (isValid()) {
                      mCycleViewModel
                          .userUpdateDetailsApi(
                              isFromCycle: false,
                              previousPeriodsBegin: selectedPreviousPeriodDate)
                          .whenComplete(() {
                        mainNavKey.currentContext!
                            .read<BottomNavbarViewModel>()
                            .selectedIndex = 0;
                        SplashViewModel().getUserDetails().whenComplete(
                            () => pushAndRemoveUntil(const BottomNavbarView()));
                      });
                      // print(selectedPreviousPeriodDate);
                    }
                  },
                  label: S.of(context)!.update,
                ),
              ],
            ),
          )),
    );
  }

  bool isValid() {
    if (selectedPreviousPeriodDate == null) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectPreviousPeriodDate,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

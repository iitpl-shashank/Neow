import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/global_variables.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../../common_ui/bottom_navbar/bottom_navbar_view.dart';
import '../../../common_ui/bottom_navbar/bottom_navbar_view_model.dart';
import '../../../common_ui/splash/splash_view_model.dart';
import '../../cycle_info/cycle_info_view_model.dart';

class EditCycleLengthView extends StatefulWidget {
  const EditCycleLengthView({super.key});

  @override
  State<EditCycleLengthView> createState() => _EditCycleLengthViewState();
}

class _EditCycleLengthViewState extends State<EditCycleLengthView> {
  int? selectedCycleLength = 0;
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
        appBar: const CommonAppBar(title: "Edit Cycle Length"),
        body: Column(
          children: [
            SizedBox(
              child: Image.asset(
                LocalImages.img_naveli_with_calendar,
                height:190,
              ),
            ),
            kCommonSpaceV10,
            Text(
              S.of(context)!.averageCycle,
              textAlign: TextAlign.center,
              style: GoogleFonts.piedra(
                color: CommonColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              S.of(context)!.numberOfDays,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: getAppStyle(
                color: CommonColors.black87,
                fontSize: 18,
                height: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: ListWheelScrollView(
                itemExtent: 100,
                diameterRatio: .8,
                perspective: 0.005,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (value) {
                  selectedCycleLength = value + 1;
                },
                children: List.generate(
                  45,
                  (index) => Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: CommonColors.A43786,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${index + 1}",
                      style: getAppStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: CommonColors.mWhite),
                    ),
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
                          averageCycleLength: selectedCycleLength.toString())
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
            kCommonSpaceV20,
          ],
        ),
      ),
    );
  }

  bool isValid() {
    if (selectedCycleLength == 0) {
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

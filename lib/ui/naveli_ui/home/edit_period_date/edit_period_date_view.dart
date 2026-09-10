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
import '../../../../widgets/ios_wheel_date_picker.dart';
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
  late CycleInfoViewModel mCycleViewModel;

  @override
  void initState() {
    super.initState();
    if (globalUserMaster?.previousPeriodsBegin != null &&
        globalUserMaster!.previousPeriodsBegin!.isNotEmpty) {
      try {
        selectedDate = DateFormat("yyyy-MM-dd")
            .parse(globalUserMaster!.previousPeriodsBegin!);
        selectedPreviousPeriodDate =
            CommonUtils.dateFormatyyyyMMDD(selectedDate.toString());
      } catch (_) {
        selectedDate = DateTime.now();
        selectedPreviousPeriodDate =
            CommonUtils.dateFormatyyyyMMDD(selectedDate.toString());
      }
    } else {
      selectedDate = DateTime.now();
      selectedPreviousPeriodDate =
          CommonUtils.dateFormatyyyyMMDD(selectedDate.toString());
    }

    Future.delayed(Duration.zero, () {
      mCycleViewModel.attachedContext(context);
    });
  }

  Future<void> _selectPeriodDate() async {
    DateTime now = DateTime.now();
    DateTime minDate = DateTime(now.year - 1, 1, 1);

    DateTime? picked = await showIosWheelDatePickerModal(
      context: context,
      initialDate: selectedDate ?? now,
      minDate: minDate,
      maxDate: now,
      title: S.of(context)!.whenDidYour,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedPreviousPeriodDate =
            CommonUtils.dateFormatyyyyMMDD(picked.toString());
      });
    }
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
                  width: kDeviceWidth / 1.7,
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
              kCommonSpaceV30,
              // Interactive iOS Style Date Selection Card
              InkWell(
                onTap: () async {
                  await _selectPeriodDate();
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: CommonColors.mWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: CommonColors.primaryColor.withAlpha(50),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CommonColors.primaryColor.withAlpha(15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: CommonColors.primaryLite.withAlpha(100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: CommonColors.primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context)!.selectDate,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 13,
                                color: CommonColors.greyText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedDate != null
                                  ? DateFormat('dd MMMM yyyy')
                                      .format(selectedDate!)
                                  : S.of(context)!.selectDate,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: CommonColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: CommonColors.primaryColor,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
              PrimaryButton(
                width: kDeviceWidth / 1.5,
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
                  }
                },
                label: S.of(context)!.update,
              ),
            ],
          ),
        ),
      ),
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

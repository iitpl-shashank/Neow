import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/home_view_model.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_daily_insight_container.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../profile/dashboard/quiz_view_report.dart';
import '../all_about_periods/all_about_periods_view.dart';
import '../de_stress/de_stress_view.dart';
import '../log_your_symptoms/log_your_symptoms_view.dart';
import '../log_your_symptoms/log_your_symptoms_view_model.dart';
import '../track/track_view.dart';

class TrackHealthViewAllView extends StatefulWidget {
  const TrackHealthViewAllView({super.key});

  @override
  State<TrackHealthViewAllView> createState() => _TrackHealthViewAllViewState();
}

class _TrackHealthViewAllViewState extends State<TrackHealthViewAllView>
    with SingleTickerProviderStateMixin {
  LogYourSymptomsModel? mViewSymptomsModel;
  late HomeViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewSymptomsModel =
          Provider.of<LogYourSymptomsModel>(context, listen: false);
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.trackYourHealth,
          ),
          body: Container(
            // Set the container height to full screen
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              child: Column(
                // scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                children: <Widget>[
                  if (gUserType == AppConstants.NEOWME)
                    CommonDailyInsightContainer(
                      onTap: () {
                        if (mViewModel.dateWiseTextList.msg.periodMsg
                                .contains("Period Day") ||
                            mViewModel.dateWiseTextList.msg.periodMsg
                                .contains("पीरियड दिन")) {
                          push(const LogYourSymptoms());
                        } else {
                          CommonUtils.showToastMessage(
                            S.of(context)!.logOnlyOnPeriodDay,
                          );
                        }
                      },
                      isHorizontalView: true,
                      text: S.of(context)!.logYourSymptoms,
                      image: LocalImages.img_log_symptoms,
                      gradientColors: const [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                      borderColor: CommonColors.bglightPinkColor,
                    ),
                  if (false) kCommonSpaceV15,
                  if (false)
                    CommonDailyInsightContainer(
                      onTap: () {
                        push(const TrackView());
                      },
                      isHorizontalView: true,
                      text: S.of(context)!.track,
                      image: LocalImages.img_track,
                      gradientColors: const [
                        Color(0xFF9E72C3),
                        Color(0xFF7338A0),
                      ],
                      borderColor: CommonColors.bglightPinkColor,
                    ),
                  kCommonSpaceV15,
                  CommonDailyInsightContainer(
                    onTap: () {
                      // push(const KnowYourBodyView());
                      push(const AllAboutPeriodsView());
                    },
                    isHorizontalView: true,
                    text: S.of(context)!.articles,
                    image: LocalImages.img_know_your_body,
                    gradientColors: const [
                      Color(0xFF9E72C3),
                      Color(0xFF7338A0),
                    ],
                    borderColor: CommonColors.bglightPinkColor,
                  ),
                  if (false) kCommonSpaceV15,
                  if (false)
                    CommonDailyInsightContainer(
                      onTap: () {
                        // showPopusDialog();
                        // showSymptomsDialog(context);
                        push(const QuizView());
                      },
                      isHorizontalView: true,
                      text: S.of(context)!.quickQuestion,
                      image: LocalImages.img_quick_question,
                      gradientColors: const [
                        Color(0xFF9E72C3),
                        Color(0xFF7338A0),
                      ],
                      borderColor: CommonColors.bglightPinkColor,
                    ),
                  kCommonSpaceV15,
                  CommonDailyInsightContainer(
                    onTap: () {
                      // showPopusDialog();
                      push(const DeStressView());
                    },
                    isHorizontalView: true,
                    text: S.of(context)!.deStress,
                    image: LocalImages.img_de_stress,
                    gradientColors: const [
                      Color(0xFF9E72C3),
                      Color(0xFF7338A0),
                    ],
                    borderColor: CommonColors.bglightPinkColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

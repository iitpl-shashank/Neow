import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/ask_your_question/question_of_the_day/question_of_the_day_view.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/primary_button.dart';
import '../../health_mix/video_particular.dart';
import 'ask_your_question_view_model.dart';

class AskYourQuestionView extends StatefulWidget {
  const AskYourQuestionView({super.key});

  @override
  State<AskYourQuestionView> createState() => _AskYourQuestionViewState();
}

class _AskYourQuestionViewState extends State<AskYourQuestionView> {
  late AskYourQuestionViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAdminAnswerApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AskYourQuestionViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.askYourQuestion,
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              Text(
                S.of(context)!.ifYouHave,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
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
                  const Spacer(),
                  Expanded(
                    child: PrimaryButton(
                      onPress: () {
                        push(const QuestionOfTheDay());
                      },
                      label: S.of(context)!.here,
                    ),
                  ),
                  // SizedBox.shrink(),
                  Expanded(
                    child: Image.asset(
                      height: 120,
                      LocalImages.img_naveli_nurse,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
              kCommonSpaceV50,
              if (mViewModel.answerList.isNotEmpty) ...[
                Text(
                  S.of(context)!.questionOfDay,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: CommonColors.primaryColor),
                ),
                kCommonSpaceV20,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mViewModel.answerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Q. ${mViewModel.answerList[index].userQuestion ?? '--'}",
                          textAlign: TextAlign.start,
                          style: getAppStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: CommonColors.primaryColor),
                        ),
                        Text(
                          "(By Neow ${mViewModel.answerList[index].name ?? '--'})",
                          textAlign: TextAlign.start,
                          style: getAppStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: CommonColors.mGrey),
                        ),
                        kCommonSpaceV10,
                        Container(
                          width: kDeviceWidth / 1,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: CommonColors.mWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (mViewModel.answerList[index].fileType ==
                                  'image')
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute<void>(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Image.network(
                                            height: kDeviceHeight / 1,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            mViewModel
                                                    .answerList[index].image ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                            fit: BoxFit.contain,
                                          ),
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    height: kDeviceHeight / 4.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(mViewModel
                                                .answerList[index].image ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              if (mViewModel.answerList[index].fileType ==
                                  'link')
                                SizedBox(
                                  height: kDeviceHeight / 4,
                                  child: VideoPlayerScreen(
                                    link: mViewModel.answerList[index].image ??
                                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                    // isFillAvailableSpace: false,
                                    // isLoop: true,
                                    // isMute: false,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  mViewModel.answerList[index].questionAnswer ??
                                      '--',
                                  style: getAppStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        kCommonSpaceV20,
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

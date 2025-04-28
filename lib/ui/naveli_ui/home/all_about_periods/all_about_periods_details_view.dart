import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../health_mix/video_particular.dart';
import 'all_about_periods_view_model.dart';

class AllAboutPeriodsDetailsView extends StatefulWidget {
  const AllAboutPeriodsDetailsView({super.key});

  @override
  State<AllAboutPeriodsDetailsView> createState() =>
      _AllAboutPeriodsDetailsViewState();
}

class _AllAboutPeriodsDetailsViewState
    extends State<AllAboutPeriodsDetailsView> {
  late AllAboutPeriodsViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AllAboutPeriodsViewModel>(context);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.allAboutPeriods,
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.primaryColor,
          style: getGoogleFontStyle(
            color: CommonColors.primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        body: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          padding: kCommonScreenPadding,
          itemCount: mViewModel.detailDataList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: kDeviceWidth / 1,
                // clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: CommonColors.mTransparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // shadows: [
                  //   BoxShadow(
                  //     color: Color(0x3F000000),
                  //     blurRadius: 8,
                  //     offset: Offset(0, 2),
                  //     spreadRadius: 0,
                  //   )
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (mViewModel.detailDataList[index].mediaType == 'image')
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.network(
                                  height: kDeviceHeight / 1,
                                  width: MediaQuery.of(context).size.width,
                                  mViewModel.detailDataList[index].media ??
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
                                      .detailDataList[index].media ??
                                  "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (mViewModel.detailDataList[index].mediaType == 'link')
                      // Text(
                      //   mViewModel.postsList[index].posts ?? 'no video',
                      //   style: getAppStyle(
                      //     color: CommonColors.mGrey,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //     height: 1,
                      //   ),
                      // ),
                      //   VideoPlayerScreen(
                      //     link: mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                      //     // isButtonVisible: true,
                      //     isFillAvailableSpace: false,
                      //     isLoop: true,
                      //     isMute: true,
                      //   ),
                      SizedBox(
                        height: kDeviceHeight / 4,
                        child: VideoPlayerScreen(
                          link: mViewModel.detailDataList[index].media ??
                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                          // isFillAvailableSpace: false,
                          // isLoop: true,
                          // isMute: false,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        mViewModel.detailDataList[index].description ?? '--',
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
            );
          },
        ),
      ),
    );
  }
}

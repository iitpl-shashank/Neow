import 'package:flutter/material.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/ui/naveli_ui/home/women_in_news/women_in_news_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/local_images.dart';
import '../../health_mix/video_particular.dart';

class WomenInNewsView extends StatefulWidget {
  const WomenInNewsView({super.key});

  @override
  State<WomenInNewsView> createState() => _WomenInNewsViewState();
}

class _WomenInNewsViewState extends State<WomenInNewsView> {
  late WomenInNewsViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getWomenNewsApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<WomenInNewsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.womenInNews,
          bgColor: CommonColors.mTransparent,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: kCommonScreenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context)!.leadingLadies,
                    textAlign: TextAlign.center,
                    style: getAppStyle(
                      color: CommonColors.black87,
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                kCommonSpaceV10,
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    LocalImages.img_naveli_mike,
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
                kCommonSpaceV15,
                SizedBox(
                  height: kDeviceHeight,
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mViewModel.newsDataList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mViewModel.newsDataList[index].title ?? '--',
                            style: getAppStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          kCommonSpaceV10,
                          if (mViewModel.newsDataList[index].fileType ==
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        mViewModel.newsDataList[index].posts ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                        fit: BoxFit.contain,
                                      ),
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                height: kDeviceHeight / 4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(mViewModel
                                            .newsDataList[index].posts ??
                                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          if (mViewModel.newsDataList[index].fileType == 'link')
                            SizedBox(
                              height: kDeviceHeight / 4,
                              child: VideoPlayerScreen(
                                link: mViewModel.newsDataList[index].posts ??
                                    "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                              ),
                            ),
                          kCommonSpaceV15,
                          Text(
                            mViewModel.newsDataList[index].description ?? '--',
                            style: getAppStyle(fontSize: 16, height: 0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

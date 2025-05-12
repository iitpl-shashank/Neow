import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/ui/naveli_ui/home/you_know/all_posts_model.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../services/api_para.dart';
import '../../../../utils/common_colors.dart';
import '../../health_mix/video_particular.dart';

class YouKnowView extends StatefulWidget {
  final int position;
  const YouKnowView({super.key, required this.position});

  @override
  State<YouKnowView> createState() => _YouKnowViewState(position);
}

class _YouKnowViewState extends State<YouKnowView> {
  late AllPostsModel mViewModel;
  int position;
  final List<String> titles = [
    'Puberty',
    'Perimenopause',
    'All About Periods',
    'Monopause',
    'Post Monopause',
    'Senior Year',
    'Others',
  ];
  _YouKnowViewState(this.position);
  // position;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      // mViewModel.getAllPostsApi(parentTitleId: position, filterBy: 'newest');
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AllPostsModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: '',
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.blackColor,
          style: TextStyle(
            color: CommonColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                /* Text(
                  S.of(context)!.exploreTheHidden,
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
                kCommonSpaceV30,
                Image.asset(
                  LocalImages.img_naveli_confuse,
                  fit: BoxFit.cover,
                ),
                kCommonSpaceV20, */
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Container(
                        width: kDeviceWidth / 1,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: CommonColors.mWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
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
                            if (mViewModel.postsList[position].fileType ==
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
                                          mViewModel
                                                  .postsList[position].posts ??
                                              "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  height: kDeviceHeight / 2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mViewModel
                                              .postsList[position].posts ??
                                          "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          CommonColors.mTransparent,
                                          CommonColors.blackColor
                                              .withOpacity(0.7)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        // stops:[0,0.2,0.4,0.6,0.8,1],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            mViewModel
                                                .postsList[position].title!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: CommonColors.mWhite,
                                              fontSize: 20,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            mViewModel.postsList[position]
                                                .diffrenceTime!,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: CommonColors.mWhite,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            if (mViewModel.postsList[index].fileType == 'link')
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
                                  link: mViewModel.postsList[position].posts ??
                                      "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                  // isFillAvailableSpace: false,
                                  // isLoop: true,
                                  // isMute: false,
                                ),
                              ),
                            kCommonSpaceV20,
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            /* mViewModel.likeHealthMixPostApi(
                                                healthMixId: mViewModel
                                                    .healthPostsList[index].id,
                                                isLike: mViewModel.isLikedList[index]
                                                    ? 0
                                                    : 1);
                                            setState(() {
                                              mViewModel.isLikedList[index] =
                                                  !mViewModel.isLikedList[index];
                                            }); */
                                          },
                                          icon: Icon(CupertinoIcons.heart,
                                              color: CommonColors.blackColor),
                                        ),
                                        // kCommonSpaceH3,
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(Icons.thumb_down_alt_rounded,
                                        //         color: CommonColors.primaryColor)),
                                        kCommonSpaceH3,
                                        IconButton(
                                            onPressed: () {
                                              /* if (mViewModel.healthPostsList[index]
                                                      .mediaType ==
                                                  "image") {
                                                // print("File type image");
                                                shareNetworkImage(
                                                  mViewModel
                                                      .healthPostsList[index].media,
                                                  text: mViewModel
                                                      .healthPostsList[index]
                                                      .description,
                                                );
                                              } else if (mViewModel
                                                      .healthPostsList[index]
                                                      .mediaType ==
                                                  "link") {
                                                // print("File type link");
                                                share(
                                                    mViewModel
                                                        .healthPostsList[index].media,
                                                    text: mViewModel
                                                        .healthPostsList[index]
                                                        .description);
                                              } */
                                            },
                                            icon: const Icon(
                                                Icons.share_outlined,
                                                color:
                                                    CommonColors.blackColor)),

                                        kCommonSpaceH3,
                                        kCommonSpaceH3,
                                        IconButton(
                                            onPressed: () {
                                              mViewModel
                                                  .saveUserPostApi(params: {
                                                ApiParams.post_id: mViewModel
                                                    .postsList[index].id,
                                                ApiParams.is_saved: 1,
                                              });
                                            },
                                            icon: Icon(
                                                Icons.bookmark_outline_rounded,
                                                color:
                                                    CommonColors.blackColor)),
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            /* mViewModel.likeHealthMixPostApi(
                                                healthMixId: mViewModel
                                                    .healthPostsList[index].id,
                                                isLike: mViewModel.isLikedList[index]
                                                    ? 0
                                                    : 1);
                                            setState(() {
                                              mViewModel.isLikedList[index] =
                                                  !mViewModel.isLikedList[index];
                                            }); */
                                          },
                                          icon: Icon(Icons.check_circle_rounded,
                                              color: CommonColors.greenColor),
                                        ),
                                        // kCommonSpaceH3,
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(Icons.thumb_down_alt_rounded,
                                        //         color: CommonColors.primaryColor)),
                                        // kCommonSpaceH3,
                                        Text('Reviewed by Experts',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            )),
                                      ]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                mViewModel.postsList[position].description!,
                                style: TextStyle(
                                  color: CommonColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

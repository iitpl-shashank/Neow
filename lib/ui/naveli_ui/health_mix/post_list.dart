import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/video_particular.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/common_appbar.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/scaffold_bg.dart';
import 'health_mix_view_model.dart';

class PostList extends StatefulWidget {
  final int position;
  final int selectedTabIndex;

  const PostList(
      {super.key, required this.position, required this.selectedTabIndex});

  @override
  State<PostList> createState() => _PostList(position, selectedTabIndex);
}

class _PostList extends State<PostList> with SingleTickerProviderStateMixin {
  late HealthMixViewModel mViewModel;

  // late HealthMixViewModel mViewModel;
  final bool _isLiked = false;
  int position;
  int selectedTabIndex;
  final List<String> text = [
    'Nutrition',
    S.of(mainNavKey.currentContext!)!.expertAdvice,
    S.of(mainNavKey.currentContext!)!.cycleWisdom,
    S.of(mainNavKey.currentContext!)!.grooveWithNeow,
    S.of(mainNavKey.currentContext!)!.testimonials,
    S.of(mainNavKey.currentContext!)!.funCorner,
    S.of(mainNavKey.currentContext!)!.calebSpeaks,
    S.of(mainNavKey.currentContext!)!.empowHer,
  ];

  _PostList(this.position, this.selectedTabIndex);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      //   tabController = TabController(length: text.length, vsync: this);
      // selectedTabIndex = position;
      print('position = $position');
      getPostList();
    });
  }

  void getPostList() {
    if (selectedTabIndex == 0) {
      mViewModel.getHealthMixPostsApi(titleId: 7,type: "popular");
    } else if (selectedTabIndex == 1) {
      mViewModel.getHealthMixPostsApi(titleId: 1,type: "popular");
    } else if (selectedTabIndex == 2) {
      mViewModel.getHealthMixPostsApi(titleId: 2,type: "popular");
    } else if (selectedTabIndex == 3) {
      mViewModel.getHealthMixPostsApi(titleId: 3,type: "popular");
    } else if (selectedTabIndex == 4) {
      mViewModel.getHealthMixPostsApi(titleId: 4,type: "popular");
    } else if (selectedTabIndex == 5) {
      mViewModel.getHealthMixPostsApi(titleId: 5,type: "popular");
    } else if (selectedTabIndex == 6) {
      mViewModel.getHealthMixPostsApi(titleId: 6,type: "popular");
    } else if (selectedTabIndex == 7) {
      mViewModel.getHealthMixPostsApi(titleId: 8,type: "popular");
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HealthMixViewModel>(context);
    return ScaffoldBG(
      bgColor: CommonColors.mWhite,
      child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: text[selectedTabIndex],
            bgColor: CommonColors.mTransparent,
            iconColor: CommonColors.blackColor,
            style: TextStyle(
              color: CommonColors.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(bottom: 25, left: 10, right: 10, top: 15),
            child: ListView.builder(
              itemCount: mViewModel.healthPostsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 3, left: 3, top: 3, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: CommonColors.mTransparent,
                                  backgroundImage: AssetImage(
                                    LocalImages.img_app_logo,
                                  ),
                                  radius: 25,
                                ),
                                kCommonSpaceH10,
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Neow',
                                      style: getAppStyle(
                                        color: CommonColors.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      mViewModel.healthPostsList[index]
                                              .diffrenceTime ??
                                          '',
                                      style: getAppStyle(
                                        color: CommonColors.mGrey,
                                        fontSize: 14,
                                        height: 0.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                                // Expanded(
                                //   child: Align(
                                //     alignment: Alignment.topRight,
                                //     child: PopupMenuButton<SampleItem>(
                                //       initialValue: selectedMenu,
                                //       onSelected: (SampleItem item) {
                                //         setState(() {
                                //           selectedMenu = item;
                                //         });
                                //       },
                                //       itemBuilder: (BuildContext
                                //               context) =>
                                //           <PopupMenuEntry<SampleItem>>[
                                //         const PopupMenuItem<SampleItem>(
                                //           value: SampleItem.itemOne,
                                //           child: Text('Block User'),
                                //         ),
                                //         const PopupMenuItem<SampleItem>(
                                //           value: SampleItem.itemTwo,
                                //           child: Text('Report Post'),
                                //         ),
                                //         const PopupMenuItem<SampleItem>(
                                //           value: SampleItem.itemThree,
                                //           child: Text('Report User'),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ), */
                      if (mViewModel.healthPostsList[index].mediaType ==
                          'image')
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
                                    mViewModel.healthPostsList[index].media ??
                                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            ));
                          },
                          child: Container(
                            height: 314,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                  mViewModel.healthPostsList[index].media ??
                                      "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                ),
                                    fit: BoxFit.fill
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CommonColors.mGrey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ]),
                            // child: Image.network(
                            //     mViewModel
                            //     .healthPostsList[index].media ??
                            //     "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                            //    fit: BoxFit.fill,
                            //
                            // ),
                          ),
                        ),
                      if (mViewModel.healthPostsList[index].mediaType == 'link')
                        Container(
                          height: 314,
                          width: double.infinity,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: CommonColors.mGrey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                          child: VideoPlayerScreen(
                            link: mViewModel.healthPostsList[index].media ??
                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                            // isFillAvailableSpace: false,
                            // isLoop: true,
                            // isMute: false,
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              mViewModel.likeHealthMixPostApi(
                                  healthMixId:
                                      mViewModel.healthPostsList[index].id,
                                  isLike:
                                      mViewModel.isLikedList[index] ? 0 : 1);
                              setState(() {
                                mViewModel.isLikedList[index] =
                                    !mViewModel.isLikedList[index];
                              });
                            },
                            icon: Icon(
                                mViewModel.isLikedList[index]
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: CommonColors.primaryColor),
                          ),
                          // kCommonSpaceH3,
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(Icons.thumb_down_alt_rounded,
                          //         color: CommonColors.primaryColor)),
                          kCommonSpaceH3,
                          IconButton(
                              onPressed: () {
                                if (mViewModel
                                        .healthPostsList[index].mediaType ==
                                    "image") {
                                  // print("File type image");
                                  shareNetworkImage(
                                    mViewModel.healthPostsList[index].media,
                                    text: mViewModel
                                        .healthPostsList[index].description,
                                  );
                                } else if (mViewModel
                                        .healthPostsList[index].mediaType ==
                                    "link") {
                                  // print("File type link");
                                  share(mViewModel.healthPostsList[index].media,
                                      text: mViewModel
                                          .healthPostsList[index].description);
                                }
                              },
                              icon: const Icon(Icons.share_outlined,
                                  color: CommonColors.primaryColor)),

                          kCommonSpaceH3,
                          kCommonSpaceH3,
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_outline_rounded,
                                  color: CommonColors.primaryColor)),

                          // Expanded(
                          //   child: PrimaryButton(
                          //     height: 40,
                          //     onPress: () {},
                          //     borderRadius: BorderRadius.zero,
                          //     label: S.of(context)!.like,
                          //     lblSize: 13,
                          //   ),
                          // ),
                          // kCommonSpaceH3,
                          // Expanded(
                          //   child: PrimaryButton(
                          //     height: 40,
                          //     onPress: () {},
                          //     borderRadius: BorderRadius.zero,
                          //     label: S.of(context)!.dislike,
                          //     lblSize: 13,
                          //   ),
                          // ),
                          // kCommonSpaceH3,
                          // Expanded(
                          //   child: PrimaryButton(
                          //     height: 40,
                          //     onPress: () {},
                          //     borderRadius: BorderRadius.zero,
                          //     label: S.of(context)!.share,
                          //     lblSize: 13,
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Wrap(
                          children:
                              (mViewModel.healthPostsList[index].hashtags ?? '')
                                  .split(',')
                                  .map((tag) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag,
                                    style: TextStyle(
                                        color: CommonColors.secondaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            CommonColors.mTransparent,
                                        decorationThickness: 0,
                                        height: 1.5),
                                  ),
                                  kCommonSpaceH5,
                                  Container(
                                    width: 1,
                                    height: 15,
                                    color: CommonColors.mGrey,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          mViewModel.healthPostsList[index].description ?? '',
                          style: TextStyle(
                            color: CommonColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: CommonColors.mTransparent,
                            decorationThickness: 0,
                            //   height: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}

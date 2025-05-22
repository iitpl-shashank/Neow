import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:provider/provider.dart';
import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/scaffold_bg.dart';
import '../../health_mix/video_particular.dart';
import '../all_about_periods/saved_post_screen.dart';
import '../you_know/all_posts_model.dart';
import '../you_know/you_know_view.dart';

class MythVsFactsView extends StatefulWidget {
  final int position;
  const MythVsFactsView({super.key, required this.position});

  @override
  State<MythVsFactsView> createState() => _MythVsFactsViewState(position);
}

class _MythVsFactsViewState extends State<MythVsFactsView> {
  late AllPostsModel mViewModel;
  int position;
  int selectedTabIndex = 0;

  List<String> get titles => [
        S.of(context)!.puberty,
        S.of(context)!.perimenopause,
        S.of(context)!.allAboutPeriods,
        S.of(context)!.menopause,
        S.of(context)!.postMenopause,
        S.of(context)!.seniorYears,
        S.of(context)!.others,
      ];

  List<String> get type => [
        S.of(context)!.popular,
        S.of(context)!.latest,
        S.of(context)!.oldest,
        S.of(context)!.saved,
      ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAllPostsApi(parentTitleId: position, filterBy: 'newest');
    });
  }

  _MythVsFactsViewState(this.position);

  void onButtonPressed(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    if (index == 2) {
      mViewModel.getAllPostsApi(parentTitleId: position, filterBy: 'oldest');
    } else {
      mViewModel.getAllPostsApi(parentTitleId: position, filterBy: 'newest');
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AllPostsModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: titles[position - 1],
          bgColor: CommonColors.mTransparent,
          iconColor: CommonColors.blackColor,
          style: TextStyle(
            color: CommonColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.bookmark_border,
                size: 28,
              ),
              onPressed: () {
                push(
                  SavedPostScreen(),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 40,
                    child: Container(
                        child: ListView.builder(
                            itemCount: type.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var txtColor = selectedTabIndex == index
                                  ? CommonColors.mWhite
                                  : CommonColors.blackColor;
                              return (GestureDetector(
                                  onTap: () {
                                    onButtonPressed(index);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 10),
                                      margin: const EdgeInsets.only(left: 5),
                                      decoration: BoxDecoration(
                                        color: selectedTabIndex == index
                                            ? CommonColors.primaryColor
                                            : CommonColors.mGrey
                                                .withOpacity(0.3),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: CommonColors.mWhite,
                                            width: 1),
                                      ),
                                      child: Text(type[index],
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: txtColor,
                                          )))));
                            }))),
                kCommonSpaceV10,
                mViewModel.postsList.length == 0
                    ? Container(
                        height: kDeviceHeight / 2,
                        width: kDeviceWidth,
                        child: Center(
                          child: Text(
                            S.of(context)!.noData,
                            style: TextStyle(
                              color: CommonColors.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mViewModel.postsList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
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
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.of(context)
                            push(
                              YouKnowView(
                                position: index,
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: kDeviceWidth - 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      /*crossAxisAlignment:CrossAxisAlignment.end, */
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            mViewModel.postsList[index].title!,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: CommonColors.blackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            mViewModel.postsList[index]
                                                .diffrenceTime!,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: CommonColors.mGrey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              if (mViewModel.postsList[index].fileType ==
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
                                            height: 100,
                                            width: 100,
                                            mViewModel.postsList[index].posts ??
                                                "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                            fit: BoxFit.fitHeight,
                                          ),
                                        );
                                      },
                                    ));
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: CommonColors.mGrey
                                              .withOpacity(0.6),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(mViewModel
                                                .postsList[index].posts ??
                                            "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              if (mViewModel.postsList[index].fileType ==
                                  'link')
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
                                  height: 90,
                                  width: 90,
                                  child: VideoPlayerScreen(
                                    link: mViewModel.postsList[index].posts ??
                                        "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                                    // isFillAvailableSpace: false,
                                    // isLoop: true,
                                    // isMute: false,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: mViewModel.postsList.length,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 5),
                //       child: Container(
                //         width: 390,
                //         height: kDeviceHeight / 3,
                //         clipBehavior: Clip.antiAlias,
                //         decoration: ShapeDecoration(
                //           color: CommonColors.mWhite,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           shadows: [
                //             BoxShadow(
                //               color: Color(0x3F000000),
                //               blurRadius: 8,
                //               offset: Offset(0, 2),
                //               spreadRadius: 0,
                //             )
                //           ],
                //         ),
                //         child: Column(
                //           children: [
                //             Container(
                //               width: 390,
                //               height: kDeviceHeight / 4.5,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                   image: NetworkImage(mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //               child: Align(
                //                 alignment: Alignment.topRight,
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: CommonColors.mWhite
                //                     ),
                //                     child: Padding(
                //                       padding: const EdgeInsets.all(4.0),
                //                       child: Icon(
                //                         Icons.favorite_outlined,
                //                         size: 25,
                //                         color: CommonColors.greenColor,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Flexible(
                //               child: Padding(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   mViewModel.postsList[index].description!,
                //                   style: getAppStyle(
                //                     color: CommonColors.mGrey,
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w400,
                //                     height: 1,
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

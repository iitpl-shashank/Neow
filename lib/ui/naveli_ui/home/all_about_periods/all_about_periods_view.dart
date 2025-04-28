import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/local_images.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/scaffold_bg.dart';
import 'all_about_periods_view_model.dart';
import '../myth_vs_facts/myth_vs_facts_view.dart';

class AllAboutPeriodsView extends StatefulWidget {
  const AllAboutPeriodsView({super.key});

  @override
  State<AllAboutPeriodsView> createState() => _AllAboutPeriodsViewState();
}

class _AllAboutPeriodsViewState extends State<AllAboutPeriodsView> {
  late AllAboutPeriodsViewModel mViewModel;
  String dropdownValue = 'Newest';
  int selectedTabIndex = 0;
  final List<String> titles = [
    'Explore All',
    'Puberty',
    'Perimenopause',
    'All About Periods',
    'Monopause',
    'Post Monopause',
    'Senior Year',
    'Others',
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAllAboutPeriodListApi();
    });
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    if (index > 0) {
      push(MythVsFactsView(position: index));
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AllAboutPeriodsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: 'Articles',
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                    height: 40,
                    child: Container(
                        child: ListView.builder(
                            itemCount: titles.length,
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
                                      child: Text(titles[index],
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: txtColor,
                                          )))));
                            }))),
                kCommonSpaceV10,
                /* Text(
                  S.of(context)!.decodingPeriod,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    color: CommonColors.black87,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ), */
                // kCommonSpaceV20,
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Container(
                //     // width: kDeviceWidth / 4,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       color: Color(0xFFFAF7F9),
                //       border: Border.all(color: CommonColors.primaryColor,width: 1),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Padding(
                //       padding:
                //       const EdgeInsets.only(left: 8, right: 8),
                //       child: DropdownButtonHideUnderline(
                //         child: DropdownButton<String>(
                //           value: dropdownValue,
                //           icon: const Icon(
                //               Icons.keyboard_arrow_down_rounded,color: CommonColors.primaryColor,),
                //           style: const TextStyle(
                //             color: CommonColors.primaryColor,
                //             fontSize: 16,
                //             fontWeight: FontWeight.w400,
                //           ),
                //           onChanged: (String? newValue) {
                //             setState(() {
                //               dropdownValue = newValue!;
                //             });
                //             mViewModel.getAllPostsApi(parentTitleId: 3,filterBy: dropdownValue.toLowerCase());
                //           },
                //           items: <String>[
                //             'Newest',
                //             'Oldest',
                //           ].map<DropdownMenuItem<String>>(
                //                   (String value) {
                //                 return DropdownMenuItem<String>(
                //                   value: value,
                //                   child: Text(value),
                //                 );
                //               }).toList(),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // kCommonSpaceV20,
                Image.asset(
                  width: kDeviceWidth - 20,
                  LocalImages.img_naveli_flower,
                  fit: BoxFit.cover,
                ),
                kCommonSpaceV20,
                Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // kCommonSpaceH10,
                          InkWell(
                              onTap: () {
                                push(MythVsFactsView(position: 1));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFF8F7FE),
                                            Color(0xFFF8F7FE).withOpacity(0.4),
                                            Color(0XFF150A5C).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_puberty,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Puberty",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),

                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:3));
                                push(MythVsFactsView(position: 3));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFF6EFFF),
                                            Color(0xFFF6EFFF).withOpacity(0.4),
                                            Color(0XFF3D1152).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_about,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" All About Period",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),
                        ])),
                kCommonSpaceV20,
                Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // kCommonSpaceH10,
                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:2));
                                push(MythVsFactsView(position: 2));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFEF0ED),
                                            Color(0xFFFEF0ED).withOpacity(0.4),
                                            Color(0XFF900000).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages
                                                  .img_article_perimenopause,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Perimenopause",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),

                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:4));
                                push(MythVsFactsView(position: 4));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFFEFB),
                                            Color(0xFFFFFEFB).withOpacity(0.4),
                                            Color(0XFF5E5D2C).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_monopause,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Monopause",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),
                        ])),
                kCommonSpaceV20,
                Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // kCommonSpaceH10,
                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:5));
                                push(MythVsFactsView(position: 5));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth - 20,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFF7E8),
                                            Color(0xFFFFF7E8).withOpacity(0.4),
                                            Color(0XFF221805).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_post,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Post Monopause",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),
                        ])),
                kCommonSpaceV20,
                Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // kCommonSpaceH10,
                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:6));
                                push(MythVsFactsView(position: 6));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFF3EE),
                                            Color(0xFFFFF3EE).withOpacity(0.4),
                                            Color(0XFF440000).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_senior,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Senior Years",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),

                          InkWell(
                              onTap: () {
                                // push(YouKnowView(position:7));
                                push(MythVsFactsView(position: 7));
                                // push(PostList(position:0,selectedTabIndex:0));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: kDeviceWidth / 2.2,
                                      height: 180,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      decoration: BoxDecoration(
                                        // color:Color(0xFFFFE6D7),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0xFFFFFFFF).withOpacity(0.4),
                                            Color(0XFF210352).withOpacity(0.2)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops:[0,0.2,0.4,0.6,0.8,1],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              LocalImages.img_article_others,
                                              // width:kDeviceWidth/1.4,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(" Others",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ])),
                        ])),
                /* GridView.builder(
                  padding: kCommonScreenPadding,
                  itemCount: mViewModel.dataList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: kDeviceHeight / 6.5),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              mViewModel
                                  .getAllAboutPeriodDetailApi(
                                      categoryId: mViewModel.dataList[index].id)
                                  .whenComplete(
                                      () => push(const AllAboutPeriodsDetailsView()));
                            },
                            child: Container(
                              width: kDeviceWidth,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFEAE0EB).withOpacity(0.6),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(15))),
                              child: Image.network(
                                mViewModel.dataList[index].categoryIcon ?? '',
                                fit: BoxFit.fill,
                              ),
                              // CachedNetworkImage(
                              //   imageUrl: mViewModel.quizData[index].icon ?? '',
                              //   placeholder: (context, url) => CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) => Icon(Icons.wifi_off),
                              // )),
                            ),
                          ),
                        ),
                        Text(
                          mViewModel.dataList[index].categoryName ?? '',
                          // textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getAppStyle(
                            color: CommonColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ), */
                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: mViewModel.postsList.length,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 10),
                //       child: Container(
                //         width: kDeviceWidth / 1,
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
                //           crossAxisAlignment: CrossAxisAlignment.stretch,
                //           children: [
                //             if(mViewModel.postsList[index].fileType == 'image')
                //               GestureDetector(
                //                 onTap: () {
                //                   Navigator.of(context).push(MaterialPageRoute<void>(
                //                     fullscreenDialog: true,
                //                     builder: (BuildContext context) {
                //                       return GestureDetector(
                //                         onTap: () {
                //                           Navigator.pop(context);
                //                         },
                //                         child: Image.network(
                //                           height: kDeviceHeight / 1,
                //                           width:
                //                           MediaQuery.of(context).size.width,
                //                           mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                //                           fit: BoxFit.contain,
                //                         ),
                //                       );
                //                     },
                //                   ));
                //                 },
                //               child: Container(
                //                 height: kDeviceHeight / 4.5,
                //                 decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                     image: NetworkImage(
                //                         mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg"),
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             if(mViewModel.postsList[index].fileType == 'link')
                //               // Text(
                //               //   mViewModel.postsList[index].posts ?? 'no video',
                //               //   style: getAppStyle(
                //               //     color: CommonColors.mGrey,
                //               //     fontSize: 16,
                //               //     fontWeight: FontWeight.w400,
                //               //     height: 1,
                //               //   ),
                //               // ),
                //               // VideoPlayerScreen(
                //               //   link: mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                //               //   // isButtonVisible: true,
                //               //   isFillAvailableSpace: false,
                //               //   isLoop: true,
                //               //   isMute: true,
                //               // ),
                //               SizedBox(
                //                 height: kDeviceHeight / 4,
                //                 child: VideoPlayerScreen(
                //                   link: mViewModel.postsList[index].posts ?? "https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg",
                //                   // isFillAvailableSpace: false,
                //                   // isLoop: true,
                //                   // isMute: false,
                //                 ),
                //               ),
                //             Padding(
                //               padding: const EdgeInsets.all(10.0),
                //               child: Text(
                //                 mViewModel.postsList[index].description!,
                //                 style: getAppStyle(
                //                   color: CommonColors.mGrey,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w400,
                //                   height: 1,
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

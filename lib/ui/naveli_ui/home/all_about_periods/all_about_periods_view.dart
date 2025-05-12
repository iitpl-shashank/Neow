import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/home/all_about_periods/widgets/searchbar_widget.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
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
    return SafeArea(
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: CommonAppBar(
            title: S.of(context)!.articles,
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
                  const SizedBox(
                    height: 10,
                  ),
                  SearchBarWidget(),
                  const SizedBox(
                    height: 10,
                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: kDeviceWidth / 2.2,
                                        height: 200,
                                        padding: const EdgeInsets.all(
                                          10,
                                        ),
                                        decoration: BoxDecoration(
                                          // color:Color(0xFFFFE6D7),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF8F7FE),
                                              Color(0xFFF8F7FE)
                                                  .withOpacity(0.4),
                                              Color(0XFF150A5C).withOpacity(0.2)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // stops:[0,0.2,0.4,0.6,0.8,1],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                LocalImages.img_article_puberty,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              )),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(S.of(context)!.puberty,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: kDeviceWidth / 2.2,
                                        height: 200,
                                        padding: const EdgeInsets.all(
                                          10,
                                        ),
                                        decoration: BoxDecoration(
                                          // color:Color(0xFFFFE6D7),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF6EFFF),
                                              Color(0xFFF6EFFF)
                                                  .withOpacity(0.4),
                                              Color(0XFF3D1152).withOpacity(0.2)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // stops:[0,0.2,0.4,0.6,0.8,1],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                LocalImages.img_article_about,
                                                // width:kDeviceWidth/1.4,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              )),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                                S.of(context)!.allAboutPeriods,
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
                                    height: 200,
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
                                            height: 130,
                                            fit: BoxFit.cover,
                                          )),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child:
                                            Text(S.of(context)!.perimenopause,
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
                                height: 200,
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
                                        height: 130,
                                        fit: BoxFit.cover,
                                      )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      S.of(context)!.menopause,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                  // push(YouKnowView(position:5));
                                  push(MythVsFactsView(position: 5));
                                  // push(PostList(position:0,selectedTabIndex:0));
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: kDeviceWidth - 20,
                                        height: 200,
                                        padding: const EdgeInsets.all(
                                          10,
                                        ),
                                        decoration: BoxDecoration(
                                          // color:Color(0xFFFFE6D7),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFFFF7E8),
                                              Color(0xFFFFF7E8)
                                                  .withOpacity(0.4),
                                              Color(0XFF221805).withOpacity(0.2)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            // stops:[0,0.2,0.4,0.6,0.8,1],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Stack(children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                LocalImages.img_article_post,
                                                // width:kDeviceWidth/1.4,
                                                height: 130,
                                                fit: BoxFit.cover,
                                              )),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                                S.of(context)!.postMenopause,
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
                                height: 200,
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
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          LocalImages.img_article_senior,
                                          // width:kDeviceWidth/1.4,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(S.of(context)!.seniorYears,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            push(MythVsFactsView(position: 7));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: kDeviceWidth / 2.2,
                                height: 200,
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
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          LocalImages.img_article_others,
                                          // width:kDeviceWidth/1.4,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        S.of(context)!.others,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

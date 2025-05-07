import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/health_mix/healthmix_detail_view.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../widgets/scaffold_bg.dart';
import '../home/home_view_model.dart';
import 'health_mix_view_model.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HealthMixView extends StatefulWidget {
  const HealthMixView({super.key});

  @override
  State<HealthMixView> createState() => _HealthMixViewState();
}

class _HealthMixViewState extends State<HealthMixView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  TabController? tabController2;
  late HealthMixViewModel mViewModel;
  SampleItem? selectedMenu;
  late HealthMixViewModel mViewHealthMixModel;
  int selectedTabIndex = 0;
  int selectedTabIndex2 = 0;
  late HomeViewModel mHomeViewModel;
  late List<String> subHeadings = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subHeadings = [
        S.of(context)!.popular,
        S.of(context)!.latest,
        S.of(context)!.saved
      ];
      mViewModel.attachedContext(context);
      mViewHealthMixModel =
          Provider.of<HealthMixViewModel>(context, listen: false);
      mViewHealthMixModel.getHealthMixPostsApi(titleId: 1, type: "Popular");
      tabController = TabController(
          length: mHomeViewModel.healthMixCategoryList.length, vsync: this);
      tabController2 = TabController(length: subHeadings.length, vsync: this);
      getPostList();
    });
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    tabController?.animateTo(selectedTabIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    getPostList();
  }

  void onButtonPressed2(int index) {
    setState(() {
      selectedTabIndex2 = index;
    });
    tabController2?.animateTo(selectedTabIndex2,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    getPostList();
  }

  void getPostList() {
    if (selectedTabIndex2 == 1) {
      mViewModel.getHealthMixPostsApi(
          titleId: selectedTabIndex + 1, type: "latest");
    } else if (selectedTabIndex2 == 2) {
      mViewModel.getHealthMixPostsApi(
          titleId: selectedTabIndex + 1, type: "saved");
    } else {
      mViewModel.getHealthMixPostsApi(
          titleId: selectedTabIndex + 1, type: "popular");
    }
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HealthMixViewModel>(context);
    mHomeViewModel = Provider.of<HomeViewModel>(context);

    return DefaultTabController(
      length: mHomeViewModel.healthMixCategoryList.length,
      initialIndex: selectedTabIndex,
      child: ScaffoldBG(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: AppBar(
            backgroundColor: CommonColors.mTransparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: CommonColors.primaryColor,
            ),
            title: Text(
              S.of(context)!.healthMix,
              style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 40,
                  child: Container(
                      child: ListView.builder(
                          itemCount:
                              mHomeViewModel.healthMixCategoryList.length,
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
                                          : CommonColors.mGrey.withOpacity(0.3),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: CommonColors.mWhite, width: 1),
                                    ),
                                    child: Text(
                                        mHomeViewModel
                                                .healthMixCategoryList[index]
                                                .name ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: txtColor,
                                        )))));
                          }))),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: 50,
                  child: Container(
                      child: ListView.builder(
                          itemCount: subHeadings.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var txtColor = selectedTabIndex2 == index
                                ? CommonColors.primaryColor
                                : CommonColors.blackColor;
                            return (GestureDetector(
                                onTap: () {
                                  onButtonPressed2(index);
                                },
                                child: Container(
                                    height: 70,
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      right: 15,
                                    ),
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(subHeadings[index],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: txtColor,
                                                )),
                                          ],
                                        ),
                                        Visibility(
                                          visible: selectedTabIndex2 == index,
                                          child: Container(
                                              height: 3,
                                              width: 80,
                                              color: txtColor),
                                        )
                                      ],
                                    ))));
                          }))),
              /* Text(
                  "Testing code",
                ), */
              // TabBar(
              //     controller: tabController2,
              //     tabs: subHeadings.map((title) {
              //   return Tab(
              //
              //     child: Text(
              //       title.toUpperCase(),
              //       style: TextStyle(
              //         color: CommonColors.blackColor,
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   );
              // }).toList()),
              // kCommonSpaceV20,
              Expanded(
                child: mViewModel.healthPostsList.length != 0
                    ? SingleChildScrollView(
                        padding: EdgeInsets.only(left: 15),
                        child: Wrap(
                          spacing: 15.0, // space between items horizontally
                          runSpacing: 0.0, // space between lines
                          children: List.generate(
                            mViewModel.healthPostsList.length,
                            (index) {
                              final item = mViewModel.healthPostsList[index];
                              final isImage = item.mediaType == 'image';
                              final mediaUrl = item.mediaType == "image"
                                  ? item.media
                                  : (item.thumbnail!.contains(".png")
                                      ? item.thumbnail
                                      : "https://cdn.pixabay.com/photo/2020/11/22/04/10/youtube-5765608_640.png");

                              return GestureDetector(
                                onTap: () {
                                  push(HealthmixDetailView(
                                    post: mViewModel.healthPostsList[index],
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20, // approx half-width with padding
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            height: 150,
                                            width: double.infinity,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    // isImage
                                                    //     ?
                                                    Image.network(
                                                  mediaUrl!,
                                                  fit: BoxFit.cover,
                                                  scale: 0.5,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Icon(
                                                        Icons.broken_image,
                                                        size: 50,
                                                        color: Colors.grey);
                                                  },
                                                )
                                                // : Align(
                                                //     alignment: Alignment.center,
                                                //     child: Image.network(
                                                //       "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png",
                                                //       height: 110,
                                                //     ),
                                                //   ),
                                                ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: Icon(
                                                isImage
                                                    ? Icons.image
                                                    : Icons.videocam,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          item.description ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          item.diffrenceTime ?? '',
                                          style: TextStyle(
                                            color: CommonColors.blackColor
                                                .withOpacity(0.6),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                    : Center(
                        child: Text(
                          S.of(context)!.noContentInThisCategory,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

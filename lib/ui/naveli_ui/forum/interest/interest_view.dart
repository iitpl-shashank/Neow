import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/global_variables.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/common_interest_filter_container.dart';
import '../../../../widgets/common_interest_option.dart';
import 'interest_view_model.dart';

class InterestView extends StatefulWidget {
  const InterestView({super.key});

  @override
  State<InterestView> createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  late InterestViewModel mViewModel;

  int currentIndex = 0;

  void onPageSelected(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void handleOptionSelection(String title, bool isSelected) {
    mViewModel.toggleOption(title);
  }

  void handleFavouriteSelection(String title, bool isSelected) {
    mViewModel.toggleOption(title);
  }

  void handleNotInterestedSelection(String title, bool isSelected) {
    if (isSelected) {
      mViewModel.addOption(title);
    } else {
      mViewModel.removeOption(title);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.loadSelectedOptions();
      mViewModel.getForumCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<InterestViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(mainNavKey.currentContext!)!.interests,
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: ListView.builder(
                  itemCount: mViewModel.forumCategoryList.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CommonFilterContainer(
                        title: "All",
                        onTap: () => onPageSelected(0),
                        isSelected: currentIndex == 0,
                      );
                    } else {
                      final category = mViewModel.forumCategoryList[index - 1];
                      return CommonFilterContainer(
                        title: category.name ?? "",
                        onTap: () => onPageSelected(index),
                        isSelected: currentIndex == index,
                      );
                    }
                  },
                ),
              ),
              kCommonSpaceV10,
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: mViewModel.forumCategoryList.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    if (pageIndex == 0) {
                      
                      return ListView.builder(
                        itemCount: mViewModel.forumCategoryList.length,
                        itemBuilder: (context, index) {
                          final category = mViewModel.forumCategoryList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kCommonSpaceV10,
                              CommonInterestOption(
                                title: category.name ?? "",
                                isFavouriteSelected: false,
                                isMainTitle: true,
                                isOption: false,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: category.subCategories?.length ?? 0,
                                itemBuilder: (context, topicIndex) {
                                  final topic =
                                      category.subCategories?[topicIndex];
                                  return CommonInterestOption(
                                    title: topic?.name ?? "",
                                    isFavouriteSelected: mViewModel
                                        .isFavoriteSelected(topic?.name ?? ""),
                                    onFavouriteSelectionChanged:
                                        handleFavouriteSelection,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                 
                      final category =
                          mViewModel.forumCategoryList[pageIndex - 1];
                      return ListView(
                        children: [
                          kCommonSpaceV10,
                          CommonInterestOption(
                            title: category.name ?? "",
                            isFavouriteSelected: false,
                            isMainTitle: true,
                            isOption: false,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: category.subCategories?.length ?? 0,
                            itemBuilder: (context, topicIndex) {
                              final topic = category.subCategories?[topicIndex];
                              return CommonInterestOption(
                                title: topic?.name ?? "",
                                isFavouriteSelected: mViewModel
                                    .isFavoriteSelected(topic?.name ?? ""),
                                onFavouriteSelectionChanged:
                                    handleFavouriteSelection,
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

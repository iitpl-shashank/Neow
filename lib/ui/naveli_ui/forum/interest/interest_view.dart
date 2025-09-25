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
 
late InterestViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
    
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
                        onTap: () => mViewModel.onPageSelected(0),
                        isSelected: mViewModel.currentIndex == 0,
                      );
                    } else {
                      final category = mViewModel.forumCategoryList[index - 1];
                      return CommonFilterContainer(
                        title: category.name ?? "",
                        onTap: () => mViewModel.onPageSelected(index),
                        isSelected: mViewModel.currentIndex == index,
                      );
                    }
                  },
                ),
              ),
              kCommonSpaceV10,
              Expanded(
                child: PageView.builder(
                  controller: mViewModel.pageController,
                  itemCount: mViewModel.forumCategoryList.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      mViewModel.currentIndex = value;
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
                                id: category.id ?? 0,
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
                                    id: topic?.id ?? 0,
                                    isFavouriteSelected:
                                        topic?.isLike ?? false,
                                    onFavouriteSelectionChanged: (id, isSelected) =>
                                        mViewModel.handleFavouriteSelection(id, isSelected),
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
                            id: category.id ?? 0,
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
                                id: topic?.id ?? 0,
                                title: topic?.name ?? "",
                                isFavouriteSelected: topic?.isLike ?? false,
                                onFavouriteSelectionChanged:
                                    mViewModel.handleFavouriteSelection,
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

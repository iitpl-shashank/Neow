import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/common_colors.dart';
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
    initialPage: 1,
  );
  late InterestViewModel mViewModel;

  int currentIndex = 1;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<InterestViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: const CommonAppBar(
          title: "Forum",
        ),
        body: Padding(
          padding: kCommonScreenPadding,
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CommonFilterContainer(
                      title: 'My',
                      isIcon: true,
                      onTap: () => onPageSelected(0),
                      isSelected: currentIndex == 0,
                    ),
                    CommonFilterContainer(
                      title: 'All',
                      onTap: () => onPageSelected(1),
                      isSelected: currentIndex == 1,
                    ),
                    CommonFilterContainer(
                      title: 'Life Style',
                      onTap: () => onPageSelected(2),
                      isSelected: currentIndex == 2,
                    ),
                    CommonFilterContainer(
                      title: 'Mental Health',
                      onTap: () => onPageSelected(3),
                      isSelected: currentIndex == 3,
                    ),
                    CommonFilterContainer(
                      title: 'Period Talk',
                      onTap: () => onPageSelected(4),
                      isSelected: currentIndex == 4,
                    ),
                    CommonFilterContainer(
                      title: 'Relationships',
                      onTap: () => onPageSelected(5),
                      isSelected: currentIndex == 5,
                    ),
                    CommonFilterContainer(
                      title: 'General Health',
                      onTap: () => onPageSelected(6),
                      isSelected: currentIndex == 6,
                    ),
                    CommonFilterContainer(
                      title: 'My body',
                      onTap: () => onPageSelected(7),
                      isSelected: currentIndex == 7,
                    ),
                    CommonFilterContainer(
                      title: 'Career and study',
                      onTap: () => onPageSelected(8),
                      isSelected: currentIndex == 8,
                    ),
                    CommonFilterContainer(
                      title: 'Parenting',
                      onTap: () => onPageSelected(9),
                      isSelected: currentIndex == 9,
                    ),
                    CommonFilterContainer(
                      title: 'Pregnancy',
                      onTap: () => onPageSelected(10),
                      isSelected: currentIndex == 10,
                    ),
                    CommonFilterContainer(
                      title: 'Other',
                      onTap: () => onPageSelected(11),
                      isSelected: currentIndex == 11,
                    ),
                  ],
                ),
              ),
              kCommonSpaceV10,
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        mViewModel.previousSelectedOptions.isEmpty
                            ? Column(
                                children: [
                                  Image.asset(
                                    LocalImages.img_no_favourite,
                                    fit: BoxFit.contain,
                                    height: 100,
                                  ),
                                  Text(
                                    "No favourite yet...",
                                    style: getAppStyle(
                                        fontSize: 22,
                                        color: CommonColors.blackColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      mViewModel.previousSelectedOptions.length,
                                  itemBuilder: (context, index) {
                                    return CommonInterestOption(
                                      title: mViewModel.previousSelectedOptions[index],
                                      isFavouriteSelected: mViewModel.isFavoriteSelected(mViewModel.previousSelectedOptions[index]),
                                      onFavouriteSelectionChanged:
                                          (title, isSelected) {
                                        handleFavouriteSelection(
                                            title, isSelected);
                                      },
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "Life style",
                              isFavouriteSelected: false,
                              // isNotInterestedSelected: false,
                              isMainTitle: true,
                              isOption: false),
                          CommonInterestOption(
                            title: "Screen time",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Screen time"),
                            // isNotInterestedSelected: mViewModel.isNotInterestedSelected("Life Style"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged: (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          CommonInterestOption(
                            title: "Diet",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Diet"),
                            // isNotInterestedSelected:
                            //     mViewModel.isNotInterestedSelected("Diet"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged:
                            //     (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          CommonInterestOption(
                            title: "Physical activity",
                            isFavouriteSelected: mViewModel
                                .isFavoriteSelected("Physical activity"),
                            // isNotInterestedSelected:
                            //     mViewModel.isNotInterestedSelected("Physical Activity"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged:
                            //     (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "Mental health",
                              isFavouriteSelected: false,
                              // isNotInterestedSelected: false,
                              isMainTitle: true,
                              isOption: false),
                          CommonInterestOption(
                            title: "Stress",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Stress"),
                            // isNotInterestedSelected:
                            //     mViewModel.isNotInterestedSelected("Stress"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged:
                            //     (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          CommonInterestOption(
                            title: "Depression",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Depression"),
                            // isNotInterestedSelected:
                            //     mViewModel.isNotInterestedSelected("Depression"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged:
                            //     (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          CommonInterestOption(
                            title: "Self care",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Self care"),
                            // isNotInterestedSelected:
                            //     mViewModel.isNotInterestedSelected("Selfcare"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                            // onNotInterestedSelectionChanged:
                            //     (title, isSelected) {
                            //   handleNotInterestedSelection(title, isSelected);
                            // },
                          ),
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "Period talk",
                              isMainTitle: true,
                              isFavouriteSelected: false,
                              isOption: false),
                          CommonInterestOption(
                            title: "PMS",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("PMS"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "PCO",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("PCO"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Heavy periods",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Heavy periods"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Perimenopause",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Perimenopause"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Menopause",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Menopause"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "Relationships",
                              isMainTitle: true,
                              isFavouriteSelected: false,
                              isOption: false),
                          CommonInterestOption(
                            title: "Break up",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Break up"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Family",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Family"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Friends",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Friends"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Professional relationships",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Professional relationships"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          CommonInterestOption(
                            title: "General health",
                            isMainTitle: true,
                            isFavouriteSelected: mViewModel
                                .isFavoriteSelected("General health"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "My body",
                              isMainTitle: true,
                              isFavouriteSelected: false,
                              isOption: false),
                          CommonInterestOption(
                            title: "Acne",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Acne"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Body image",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Body image"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Face and Body care",
                            isFavouriteSelected: mViewModel
                                .isFavoriteSelected("Face and Body care"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Hygiene test",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Hygiene test"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          CommonInterestOption(
                            title: "Career and study",
                            isMainTitle: true,
                            isFavouriteSelected: mViewModel
                                .isFavoriteSelected("Career and study"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          CommonInterestOption(
                            title: "Parenting",
                            isMainTitle: true,
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Parenting"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          const CommonInterestOption(
                              title: "Pregnancy",
                              isMainTitle: true,
                              isFavouriteSelected: false,
                              isOption: false),
                          CommonInterestOption(
                            title: "1st trimester",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("1st trimester"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "2nd trimester",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("2nd trimester"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "3rd trimester",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("3rd trimester"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Infertility",
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Infertility"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          CommonInterestOption(
                            title: "Trying to conceive",
                            isFavouriteSelected: mViewModel
                                .isFavoriteSelected("Trying to conceive"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                          kCommonSpaceV10,
                          CommonInterestOption(
                            title: "Others",
                            isMainTitle: true,
                            isFavouriteSelected:
                                mViewModel.isFavoriteSelected("Others"),
                            onFavouriteSelectionChanged: (title, isSelected) {
                              handleFavouriteSelection(title, isSelected);
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "Life style",
                            isFavouriteSelected: false,
                            // isNotInterestedSelected: false,
                            isMainTitle: true,
                            isOption: false),
                        CommonInterestOption(
                          title: "Life style",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Life style"),
                          // isNotInterestedSelected: mViewModel.isNotInterestedSelected("Life Style"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                          // onNotInterestedSelectionChanged: (title, isSelected) {
                          //   handleNotInterestedSelection(title, isSelected);
                          // },
                        ),
                        CommonInterestOption(
                          title: "Diet",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Diet"),
                          // isNotInterestedSelected:
                          //     mViewModel.isNotInterestedSelected("Diet"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                          // onNotInterestedSelectionChanged:
                          //     (title, isSelected) {
                          //   handleNotInterestedSelection(title, isSelected);
                          // },
                        ),
                        CommonInterestOption(
                          title: "Physical activity",
                          isFavouriteSelected: mViewModel
                              .isFavoriteSelected("Physical activity"),
                          // isNotInterestedSelected:
                          //     mViewModel.isNotInterestedSelected("Physical Activity"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                          // onNotInterestedSelectionChanged:
                          //     (title, isSelected) {
                          //   handleNotInterestedSelection(title, isSelected);
                          // },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "Mental Health",
                            isFavouriteSelected: false,
                            // isNotInterestedSelected: false,
                            isMainTitle: true,
                            isOption: false),
                        CommonInterestOption(
                          title: "Stress",
                          isFavouriteSelected:
                              mViewModel.isFavoriteSelected("Stress"),
                          // isNotInterestedSelected:
                          //     mViewModel.isNotInterestedSelected("Stress"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                          // onNotInterestedSelectionChanged:
                          //     (title, isSelected) {
                          //   handleNotInterestedSelection(title, isSelected);
                          // },
                        ),
                        CommonInterestOption(
                          title: "Depression",
                          isFavouriteSelected:
                              mViewModel.isFavoriteSelected("Depression"),
                          // isNotInterestedSelected:
                          //     mViewModel.isNotInterestedSelected("Depression"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                          // onNotInterestedSelectionChanged:
                          //     (title, isSelected) {
                          //   handleNotInterestedSelection(title, isSelected);
                          // },
                        ),
                        CommonInterestOption(
                          title: "Selfcare",
                          isFavouriteSelected:
                              mViewModel.isFavoriteSelected("Selfcare"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "Period talk",
                            isMainTitle: true,
                            isFavouriteSelected: false,
                            isOption: false),
                        CommonInterestOption(
                          title: "PMS",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("PMS"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "PCO",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("PCO"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Heavy periods",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Heavy periods"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Perimenopause",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Perimenopause"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Menopause",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Menopause"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "Relationships",
                            isMainTitle: true,
                            isFavouriteSelected: false,
                            isOption: false),
                        CommonInterestOption(
                          title: "Break up",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Break up"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Family",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Family"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Friends",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Friends"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Professional relationships",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Professional relationships"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        CommonInterestOption(
                          title: "General health",
                          isMainTitle: true,
                          isFavouriteSelected: mViewModel
                              .isFavoriteSelected("General health"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "My body",
                            isMainTitle: true,
                            isFavouriteSelected: false,
                            isOption: false),
                        CommonInterestOption(
                          title: "Acne",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Acne"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Body image",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Body image"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Face and Body care",
                          isFavouriteSelected: mViewModel
                              .isFavoriteSelected("Face and Body care"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Hygiene test",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Hygiene test"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        CommonInterestOption(
                          title: "Career and study",
                          isMainTitle: true,
                          isFavouriteSelected: mViewModel
                              .isFavoriteSelected("Career and study"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        CommonInterestOption(
                          title: "Parenting",
                          isMainTitle: true,
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Parenting"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        const CommonInterestOption(
                            title: "Pregnancy",
                            isMainTitle: true,
                            isFavouriteSelected: false,
                            isOption: false),
                        CommonInterestOption(
                          title: "1st trimester",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("1st trimester"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "2nd trimester",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("2nd trimester"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "3rd trimester",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("3rd trimester"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Infertility",
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Infertility"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                        CommonInterestOption(
                          title: "Trying to conceive",
                          isFavouriteSelected: mViewModel
                              .isFavoriteSelected("Trying to conceive"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        kCommonSpaceV10,
                        CommonInterestOption(
                          title: "Others",
                          isMainTitle: true,
                          isFavouriteSelected:
                          mViewModel.isFavoriteSelected("Others"),
                          onFavouriteSelectionChanged: (title, isSelected) {
                            handleFavouriteSelection(title, isSelected);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

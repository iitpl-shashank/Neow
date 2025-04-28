import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/scaffold_bg.dart';
import 'forum_full_post/forum_full_post_view.dart';
import 'forum_view_model.dart';
import 'interest/interest_view.dart';
import 'interest/interest_view_model.dart';

class ForumView extends StatefulWidget {
  const ForumView({super.key});

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  late ForumViewModel mViewModel;
  late InterestViewModel mInterestViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mInterestViewModel =
          Provider.of<InterestViewModel>(context, listen: false);
      getData();
    });
  }

  void getData() {
    mViewModel.getForumPostApi().whenComplete(() => mInterestViewModel
        .loadSelectedOptions()
        .whenComplete(() => filterPostsBySelectedOptions()));
    // print("....Interested category.... :: ${mInterestViewModel.previousSelectedOptions.length}");
  }

  void filterPostsBySelectedOptions() {
    if (mInterestViewModel.previousSelectedOptions.isNotEmpty) {
      mViewModel.forumPostList = mViewModel.forumPostList.where((post) {
        bool containsOption = false;
        // Check both forum category and subcategory
        // if (post.forumCategory != null && post.forumSubCategory != null) {
        //   if (mInterestViewModel.previousSelectedOptions.contains(post.forumCategory!.name) ||
        //       mInterestViewModel.previousSelectedOptions.contains(post.forumSubCategory!.name)) {
        //     containsOption = true;
        //   }
        // }
        // else if (post.forumCategory != null) {
        //   if (mInterestViewModel.previousSelectedOptions.contains(post.forumCategory!.name)) {
        //     containsOption = true;
        //   }
        // }
        // else
        if (post.forumSubCategory != null) {
          if (mInterestViewModel.previousSelectedOptions
              .contains(post.forumSubCategory!.name)) {
            containsOption = true;
          }
        } else if (post.forumCategory != null) {
          if (mInterestViewModel.previousSelectedOptions
              .contains(post.forumCategory!.name)) {
            containsOption = true;
          }
        }
        return containsOption;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ForumViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.welcomeForum,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 25, left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // kCommonSpaceV5,
                // Text(
                //   S.of(context)!.welcomeToOurForum,
                //   textAlign: TextAlign.center,
                //   style: getAppStyle(
                //     color: CommonColors.blackColor,
                //     fontSize: 20,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // kCommonSpaceV10,
                GestureDetector(
                  onTap: () {
                    push(const InterestView()).then((value) => getData());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite_outlined,
                        color: CommonColors.darkPink,
                        size: 22,
                      ),
                      Text(
                        S.of(context)!.interest,
                        style: getAppStyle(
                            fontSize: 18,
                            color: CommonColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                kCommonSpaceV20,
                Container(
                  width: kDeviceWidth / 1,
                  // height: kDeviceHeight / 3.5,
                  decoration: ShapeDecoration(
                    color: CommonColors.primaryLite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // shadows: [
                    //   BoxShadow(
                    //     color: Color(0x3F000000),
                    //     blurRadius: 8,
                    //     offset: Offset(0, 2),
                    //     spreadRadius: 0,
                    //   )
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          LocalImages.img_welcome_our_forum,
                          fit: BoxFit.contain,
                        ),
                        kCommonSpaceV5,
                        Flexible(
                          child: Text(
                            S.of(context)!.welcomeToNeow,
                            style: getAppStyle(
                                color: CommonColors.mGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                kCommonSpaceV10,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mViewModel.forumPostList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          push(ForumFullPostView(
                            time: mViewModel.forumPostList[index].time ?? '--',
                            title:
                                mViewModel.forumPostList[index].title ?? '--',
                            description:
                                mViewModel.forumPostList[index].description ??
                                    '--',
                            forumId: mViewModel.forumPostList[index].id ?? 0,
                          ));
                        },
                        child: Container(
                          width: kDeviceWidth / 1,
                          // height: kDeviceHeight / 5,
                          decoration: ShapeDecoration(
                            color: CommonColors.primaryLite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage(LocalImages.img_app_logo),
                                      radius: 30,
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
                                          mViewModel
                                                  .forumPostList[index].time ??
                                              '--',
                                          style: getAppStyle(
                                            color: CommonColors.mGrey,
                                            fontSize: 14,
                                            height: 0.5,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  mViewModel.forumPostList[index].title ?? '--',
                                  textAlign: TextAlign.start,
                                  style: getAppStyle(
                                    color: CommonColors.blackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
                                child: Text(
                                  mViewModel.forumPostList[index].description ??
                                      '--',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: getAppStyle(
                                    color: CommonColors.mGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

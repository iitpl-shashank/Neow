import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/ui/naveli_ui/forum/interest/interest_view.dart';
import 'package:naveli_2023/ui/naveli_ui/forum/widgets/forum_post_card.dart';
import 'package:naveli_2023/ui/naveli_ui/home/inapp_notificatons/custom_notification.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => CustomNotification(
          imagePath: LocalImages.welcomeForum,
          height: 173,
          width: 293,
          subtitleText: S.of(context)!.welcomeToNeowForum,
          subtitleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          prepareText: S.of(context)!.welcomeForumSubtitle,
          prepareTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: CommonColors.greyText,
          ),
        ),
      );
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
          actions: [
            SvgPicture.asset(
              LocalSvgs.icInfo,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                push(const InterestView()).then((value) => getData());
              },
              child: SvgPicture.asset(
                LocalSvgs.icInterestEdit,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 25, left: 16, right: 16, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                        child: ForumPostCard(
                          title: mViewModel.forumPostList[index].title,
                          description:
                              mViewModel.forumPostList[index].description,
                          time: mViewModel.forumPostList[index].time,
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

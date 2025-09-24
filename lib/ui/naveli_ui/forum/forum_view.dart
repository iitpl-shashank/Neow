import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/ui/naveli_ui/home/inapp_notificatons/custom_notification.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../common_ui/forum/forum_post_widget.dart';
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
    print(
        "....Interested category.... :: ${mInterestViewModel.previousSelectedOptions.length}");
  }

  void filterPostsBySelectedOptions() {
    if (mInterestViewModel.previousSelectedOptions.isNotEmpty) {
      mViewModel.forumPostList = mViewModel.forumPostList.where((post) {
        bool containsOption = false;
        //TODO: Need to check with backend team for subcategory
        // if (post.forumSubCategory != null) {
        //   if (mInterestViewModel.previousSelectedOptions
        //       .contains(post.forumSubCategory!.name)) {
        //     containsOption = true;
        //   }
        // } else if (post.forumCategory != null) {
        //   if (mInterestViewModel.previousSelectedOptions
        //       .contains(post.forumCategory!.name)) {
        //     containsOption = true;
        //   }
        // }
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
        body: mViewModel.forumPostList.isEmpty
            ? Center(
                child: Text(S.of(context)!.noData),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 15, right: 15, top: 5),
                child: ListView.builder(
                  itemCount: mViewModel.forumPostList.length,
                  itemBuilder: (context, index) {
                    final post = mViewModel.forumPostList[index];
                    return ForumPostWidget(
                      forumId: post.id ?? 0,
                      username: "NeoW",
                      timeAgo: post.time ?? "1 min ago",
                      postText: post.title ?? "",
                      isLike: post.liked ?? false,
                      likes: post.totalLike ?? 10,
                      comment: "",
                      commentsCount: post.commentCount ?? 0,
                      onLike: (forumId)=> mViewModel.forumPostLikeDislike(
                        forumId: forumId,
                      
                      ),
                      onComment: null,
                      onShare: null,
                      commentUser: "NeoW User",
                     
                    );
                  },
                ),
              ),
        // SingleChildScrollView(
        //     child: Padding(
        //       padding: const EdgeInsets.only(
        //           bottom: 25, left: 15, right: 15, top: 5),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           kCommonSpaceV10,
        //           ForumPostWidget(
        //             username: "NeoW",
        //             timeAgo: "1 min ago",
        //             postText:
        //                 "What rights do women lack?\nWhere are the barriers that are locking them out of the economic system?",
        //             likes: 54,
        //             comment:
        //                 "I never realized how much diet and exercise could impact my period until I tried these tips! Feeling so much better during that time of the month now 💪",
        //             onLike: null,
        //             onComment: null,
        //             onShare: null,
        //             commentUser: "NeoW User",
        //             commentsCount: 1,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
      ),
    );
  }
}

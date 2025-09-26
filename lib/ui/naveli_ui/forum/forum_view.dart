import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/ui/naveli_ui/home/inapp_notificatons/custom_notification.dart';
import 'package:provider/provider.dart';
import '../../../generated/i18n.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/local_images.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/scaffold_bg.dart';
import '../../common_ui/forum/forum_post_widget.dart';
import 'forum_view_model.dart';
import 'interest/interest_view.dart';

class ForumView extends StatelessWidget {
  ForumView({super.key});

  Future<void> getData(BuildContext context) async {
    try {
      final viewModel = Provider.of<ForumViewModel>(context, listen: false);
      await viewModel.getForumPostApi();
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }

  void _onScroll(ScrollController scrollController, BuildContext context) {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      final viewModel = Provider.of<ForumViewModel>(context, listen: false);
      if (viewModel.hasMoreData && !viewModel.isLoadingMore) {
        viewModel.getForumPostApi(showLoader: false, loadMore: true);
      } else if (!viewModel.hasShownEndMessage && !viewModel.isLoadingMore) {
        viewModel.hasShownEndMessage = true;
        CommonUtils.showSnackBar(
          S.of(context)!.noMorePosts,
          color: CommonColors.greyText,
        );
        }
    }

  }

  final ScrollController _scrollController = ScrollController();
  showInfoDialog(BuildContext context) {
    return showDialog(
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
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ForumViewModel>(context, listen: false);
      viewModel.attachedContext(context);
      viewModel.getForumPostApi();

      _scrollController.addListener(() {
        _onScroll(_scrollController, context);
      });
    });

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.welcomeForum,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                showInfoDialog(context);
              },
              child: SvgPicture.asset(
                LocalSvgs.icInfo,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                push(const InterestView()).then((_) => getData(context));
              },
              child: SvgPicture.asset(
                LocalSvgs.icInterestEdit,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Consumer<ForumViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.forumPostList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(S.of(context)!.noData),
                    // const SizedBox(height: 16),
                    // ElevatedButton(
                    //   onPressed: () => getData(context),
                    //   child: Text("Retry"),
                    // ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => getData(context),
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 25,
                  left: 15,
                  right: 15,
                  top: 5,
                ),
                itemCount: viewModel.forumPostList.length +
                    (viewModel.hasMoreData ? 1 : 0),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == viewModel.forumPostList.length) {
                    return viewModel.isLoadingMore
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  final post = viewModel.forumPostList[index];
                  return ForumPostWidget(
                    post: post,
                    onLike: (id) {
                      viewModel.forumPostLikeDislike(
                        forumId: id,
                        isLike: post.liked == true ? 0 : 1,
                      );
                    },
                    onCommentSubmit: (commentText, forumId) {
                      viewModel.forumPostComment(
                        forumId: forumId,
                        comment: commentText,
                      );
                    },
                    onSave: () {
                      viewModel.forumPostSaveUnsave(
                        forumId: post.id ?? 0,
                        isSaved: post.saved == "yes" ? 0 : 1,
                      );
                    },
                    onShare: () {
                      viewModel.sharePost(
                        postId: post.id ?? 0,
                        index: index,
                       
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

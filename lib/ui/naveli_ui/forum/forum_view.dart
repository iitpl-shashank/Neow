import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/ui/naveli_ui/forum/forum_full_post/forum_full_post_view.dart';
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

class ForumView extends StatefulWidget {
  const ForumView({super.key});

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = Provider.of<ForumViewModel>(context, listen: false);
        viewModel.attachedContext(context);
        viewModel.getForumPostApi();

        _scrollController.addListener(() {
          viewModel.handleScroll(_scrollController);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<ForumViewModel>(context, listen: false);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: CommonAppBar(
          title: S.of(context)!.welcomeForum,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () => viewModel.showInfoDialog(),
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
                push(const InterestView())
                    .then((_) => viewModel.refreshData());
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
              return const Center(
                child: SizedBox.shrink(),
              );
            }

            return RefreshIndicator(
              onRefresh: () => viewModel.refreshData(),
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
                  return GestureDetector(
                    onTap: () => push(ForumFullPostView(
                      post: post,
                      index: index,
                      currentPage: viewModel.currentPage,
                    )),
                    child: ForumPostWidget(
                      post: post,
                      isFullPost: false,
                      onLike: (id) {
                        viewModel.forumPostLikeDislike(
                          forumId: id,
                          isLike: post.liked == true ? 0 : 1,
                        );
                      },
                      onCommentSubmit: (commentText, forumId) =>
                          viewModel.forumPostComment(
                        forumId: forumId,
                        comment: commentText,
                      ),
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
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  Future<void> getData(BuildContext context) async {
    try {
      final viewModel = Provider.of<ForumViewModel>(context, listen: false);
      await viewModel.getForumPostApi();
    } catch (e) {
      debugPrint("Error loading data: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<ForumViewModel>(context, listen: false);
      viewModel.getForumPostApi();
    });

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
                    Text(S.of(context)!.noData),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => getData(context),
                      child: Text("Retry"),
                    ),
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
                itemCount: viewModel.forumPostList.length,
                itemBuilder: (context, index) {
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
                      // Implement share functionality
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
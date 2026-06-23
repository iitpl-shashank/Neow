import 'package:flutter/material.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
import 'package:naveli_2023/ui/common_ui/forum/forum_post_widget.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import 'forum_full_post_view_model.dart';

class ForumFullPostView extends StatefulWidget {
  final ForumPost post;
  final int index;
  final int currentPage;

  const ForumFullPostView({
    super.key,
    required this.post,
    required this.index,
    required this.currentPage,
  });

  @override
  State<ForumFullPostView> createState() => _ForumFullPostViewState();
}

class _ForumFullPostViewState extends State<ForumFullPostView> {
  TextEditingController commentController = TextEditingController();
  late ForumFullPostViewModel mViewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeViewModel();
    });
  }

  void _initializeViewModel() {
    mViewModel = Provider.of<ForumFullPostViewModel>(context, listen: false);
    mViewModel.attachedContext(context);

    // Set the properties
    mViewModel.post = widget.post;
    mViewModel.index = widget.index;
    mViewModel.currentPage = widget.currentPage;

    // Fetch comments
    mViewModel.getForumsCommentApi(forumId: widget.post.id ?? 0);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<ForumFullPostViewModel>(context);

    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        appBar: const CommonAppBar(
          title: 'Forum',
        ),
        body: SingleChildScrollView(
          padding: kCommonScreenPadding,
          child: ForumPostWidget(
            post: mViewModel.post ?? widget.post,
            showCommentField: false,
            isFullPost: true,
            onLike: (id) {
              mViewModel.forumPostLikeDislike(
                forumId: id,
                isLike: (mViewModel.post ?? widget.post).liked == true ? 0 : 1,
              );
            },
            onCommentSubmit: (commentText, forumId) {
              mViewModel.forumPostComment(
                forumId: forumId,
                comment: commentText,
              );
            },
            onSave: () {
              mViewModel.forumPostSaveUnsave(
                forumId: (mViewModel.post ?? widget.post).id ?? 0,
                isSaved: (mViewModel.post ?? widget.post).saved == "yes" ? 0 : 1,
              );
            },
            onShare: () {
              mViewModel.sharePost(
                postId: (mViewModel.post ?? widget.post).id ?? 0,
                index: widget.index,
              );
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton.small(
        //   backgroundColor: CommonColors.mWhite,
        //   onPressed: () => _showCommentDialog(),
        //   shape: RoundedRectangleBorder(
        //     side: const BorderSide(width: 1, color: CommonColors.primaryColor),
        //     borderRadius: BorderRadius.circular(100),
        //   ),
        //   child: const Icon(
        //     Icons.add,
        //     color: CommonColors.primaryColor,
        //     size: 30,
        //   ),
        // ),
      ),
    );
  }

  // ✅ Extracted dialog method for cleaner code
  void _showCommentDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kCommonSpaceV10,
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Add Comment',
                      style: getAppStyle(
                        color: CommonColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  kCommonSpaceV5,
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: CommonColors.mWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            child: TextField(
                              controller: commentController,
                              maxLines: null,
                              maxLength: 500,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                counterText: '',
                                hintStyle: getAppStyle(
                                  color: CommonColors.mGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                hintText: 'add your comment',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '(Max. 500 Character)',
                                style: getAppStyle(
                                  color: CommonColors.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (isValid()) {
                            Navigator.pop(context);
                            mViewModel.storeForumCommentApi(
                              forumId: widget.post.id ?? 0,
                              comment: commentController.text.trim(),
                            );
                            commentController.clear();
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  bool isValid() {
    if (commentController.text.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plAddComment,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

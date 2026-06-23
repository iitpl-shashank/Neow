import 'package:flutter/material.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
import 'package:naveli_2023/models/forum_comment_master.dart';
import 'package:naveli_2023/services/index.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../generated/i18n.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';

class ForumCommentsSheet extends StatefulWidget {
  final ForumPost initialPost;
  final ValueNotifier<ForumPost> postNotifier;
  final Function(String, int)? onCommentSubmit;

  const ForumCommentsSheet({
    required this.initialPost,
    required this.postNotifier,
    this.onCommentSubmit,
    super.key,
  });

  @override
  State<ForumCommentsSheet> createState() => _ForumCommentsSheetState();
}

class _ForumCommentsSheetState extends State<ForumCommentsSheet> {
  late final TextEditingController _commentController;
  List<CommentData> _commentsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _fetchComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _fetchComments() async {
    if (widget.initialPost.id == null) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final services = Services();
      final params = <String, dynamic>{
        "forum_id": widget.initialPost.id,
      };
      final response = await services.api!.getForumComment(params: params);
      if (response != null && response.success == true) {
        setState(() {
          _commentsList = (response.data ?? []).reversed.toList();
        });
      }
    } catch (e) {
      debugPrint("Error fetching comments: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _submitComment(ForumPost post) async {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty && post.id != null) {
      final dynamic result = widget.onCommentSubmit?.call(comment, post.id!);
      _commentController.clear();
      FocusScope.of(context).unfocus();
      
      if (result is Future) {
        await result;
      } else {
        // Fallback delay to let the server update
        await Future.delayed(const Duration(milliseconds: 1000));
      }
      
      _fetchComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ValueListenableBuilder<ForumPost>(
      valueListenable: widget.postNotifier,
      builder: (context, post, child) {
        return Container(
          decoration: const BoxDecoration(
            color: CommonColors.mWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: bottomInset + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pull handle / indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: CommonColors.mGrey300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isLoading
                        ? "${S.of(mainNavKey.currentContext!)!.comments}..."
                        : "${S.of(mainNavKey.currentContext!)!.comments} (${_commentsList.length})",
                    style: getAppStyle(
                      fontSize: 18,
                      color: CommonColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),

              // Comments list or Skeleton loader
              if (_isLoading)
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: const _SkeletonCommentsList(),
                  ),
                )
              else if (_commentsList.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 48,
                        color: CommonColors.mGrey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "No comments yet",
                        style: getAppStyle(
                          fontSize: 16,
                          color: CommonColors.greyText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Be the first to share your thoughts!",
                        style: getAppStyle(
                          fontSize: 14,
                          color: CommonColors.greyText.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _commentsList.length,
                      itemBuilder: (context, index) {
                        final comment = _commentsList[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CommonColors.mGrey200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  comment.userDetail?.image != null &&
                                          comment.userDetail!.image!.isNotEmpty
                                      ? ClipOval(
                                          child: Image.network(
                                            comment.userDetail!.image!,
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Image.asset(
                                              LocalImages.unknownUser,
                                              height: 36,
                                              width: 36,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          LocalImages.unknownUser,
                                          height: 36,
                                          width: 36,
                                        ),
                                  const SizedBox(width: 8),
                                  Text(
                                    comment.userDetail?.name ?? "",
                                    style: getAppStyle(
                                      fontSize: 14,
                                      color: CommonColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (comment.commentTime != null)
                                    Text(
                                      comment.commentTime!,
                                      style: getAppStyle(
                                        fontSize: 11,
                                        color: CommonColors.greyText,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                comment.comment ?? "",
                                style: getAppStyle(
                                  fontSize: 15,
                                  color: CommonColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (comment.adminReply != null &&
                                  comment.adminReply!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Admin Reply: ${comment.adminReply}",
                                    style: getAppStyle(
                                      fontSize: 13,
                                      color: CommonColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              // Input field
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: CommonColors.bgGrey,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: CommonColors.mGrey300),
                      ),
                      child: TextField(
                        controller: _commentController,
                        textAlignVertical: TextAlignVertical.center,
                        style: getAppStyle(
                          fontSize: 15,
                          color: CommonColors.blackColor,
                        ),
                        decoration: InputDecoration(
                          hintText: S.of(mainNavKey.currentContext!)!.leaveAComment,
                          hintStyle: getAppStyle(
                            fontSize: 14,
                            color: CommonColors.greyText,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          suffixIcon: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _commentController,
                            builder: (context, value, child) {
                              final text = value.text.trim();
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: text.isEmpty
                                      ? CommonColors.mGrey300
                                      : CommonColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.arrow_upward_outlined,
                                    size: 18,
                                    color: text.isEmpty
                                        ? CommonColors.blackColor
                                        : CommonColors.mWhite,
                                  ),
                                  onPressed: text.isEmpty ? null : () => _submitComment(post),
                                ),
                              );
                            },
                          ),
                        ),
                        onSubmitted: (_) => _submitComment(post),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkeletonCommentItem extends StatelessWidget {
  final double opacity;

  const _SkeletonCommentItem({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CommonColors.mGrey200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar placeholder
                Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: CommonColors.mWhite,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                // Name placeholder
                Container(
                  height: 14,
                  width: 100,
                  decoration: BoxDecoration(
                    color: CommonColors.mWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                // Time placeholder
                Container(
                  height: 11,
                  width: 50,
                  decoration: BoxDecoration(
                    color: CommonColors.mWhite,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Comment lines placeholder
            Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CommonColors.mWhite,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 14,
              width: 180,
              decoration: BoxDecoration(
                color: CommonColors.mWhite,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonCommentsList extends StatefulWidget {
  const _SkeletonCommentsList();

  @override
  State<_SkeletonCommentsList> createState() => _SkeletonCommentsListState();
}

class _SkeletonCommentsListState extends State<_SkeletonCommentsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _SkeletonCommentItem(opacity: _animation.value);
          },
        );
      },
    );
  }
}

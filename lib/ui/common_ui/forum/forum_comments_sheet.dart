import 'package:flutter/material.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
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

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment(ForumPost post) {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty && post.id != null) {
      widget.onCommentSubmit?.call(comment, post.id!);
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ValueListenableBuilder<ForumPost>(
      valueListenable: widget.postNotifier,
      builder: (context, post, child) {
        final comments = post.comments ?? [];

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
                    "${S.of(mainNavKey.currentContext!)!.comments} (${comments.length})",
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

              // Comments list
              comments.isEmpty
                  ? Container(
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
                  : Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.5,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
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

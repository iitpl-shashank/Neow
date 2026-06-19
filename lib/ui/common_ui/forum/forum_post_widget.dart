import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../generated/i18n.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';

class ForumPostWidget extends StatefulWidget {
  final ForumPost post;
  final ValueChanged<int>? onLike;
  final bool? showCommentField;

  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final Function(String, int)? onCommentSubmit;
  final bool isComments;

  const ForumPostWidget({
    super.key,
    this.showCommentField = true,
    required this.post,
    this.onLike,
    this.onShare,
    this.onSave,
    this.onCommentSubmit,
    this.isComments = true,
  });

  @override
  State<ForumPostWidget> createState() => _ForumPostWidgetState();
}

class _ForumPostWidgetState extends State<ForumPostWidget> {
  bool showComment = false;
  final TextEditingController _commentController =
      TextEditingController(); // Add this line
  bool showAllComments = false;
  @override
  void dispose() {
    _commentController.dispose(); // Add this line
    super.dispose();
  }

  void onTapComment() {
    setState(() {
      showComment = !showComment;
    });
  }

  void _submitComment() {
    final comment = _commentController.text.trim();
    if (comment.isNotEmpty && widget.post.id != null) {
      widget.onCommentSubmit?.call(comment, widget.post.id!);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: CommonColors.mWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CommonColors.mGrey300)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: widget.post.authorImage != null &&
                          widget.post.authorImage!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            widget.post.authorImage!,
                            height: 42,
                            width: 42,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              LocalImages.postCardIcon,
                              height: 42,
                              width: 42,
                            ),
                          ),
                        )
                      : Image.asset(
                          LocalImages.postCardIcon,
                          height: 42,
                          width: 42,
                        ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.author ?? "",
                      style: getAppStyle(
                        fontSize: 16,
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.post.time ?? "",
                      style: getAppStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Purple Question Box
            Container(
              height: 185,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CommonColors.textPurple,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(LocalImages.postBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  widget.post.title ?? "",
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                    fontSize: 18,
                    color: CommonColors.mWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            if (widget.post.description != null &&
                widget.post.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.post.description!,
                  style: getAppStyle(
                    fontSize: 14,
                    color: CommonColors.blackColor,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Bottom row
            Row(
              children: [
                GestureDetector(
                  onTap: () => widget.onLike?.call(widget.post.id ?? 0),
                  child: Row(
                    children: [
                      Icon(
                        widget.post.liked == true
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: widget.post.liked == true
                            ? Colors.red
                            : CommonColors.blackColor,
                      ),
                      const SizedBox(width: 4),
                      if (widget.post.totalLike != null &&
                          widget.post.totalLike! > 0)
                        Text(
                          "${widget.post.totalLike}",
                          style: getAppStyle(
                            fontSize: 18,
                            color: CommonColors.blackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    onTapComment();
                    // widget.isCommentVisible?.call();
                  },
                  child: Row(
                    children: [
                      Image.asset(LocalImages.chat, height: 35, width: 35),
                      const SizedBox(width: 1),
                      Text(
                        "${widget.post.commentCount ?? 0}",
                        style: getAppStyle(
                          fontSize: 18,
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: widget.onShare,
                  child: Image.asset(LocalImages.shareCustom,
                      height: 25, width: 25),
                ),
                Spacer(),
                GestureDetector(
                  onTap: widget.onSave,
                  child: widget.post.saved == "yes"
                      ? SvgPicture.asset(LocalSvgs.icBookmarkSaved,
                          height: 25,
                          width: 25,
                          colorFilter: ColorFilter.mode(
                              CommonColors.primaryColor, BlendMode.srcIn))
                      : SvgPicture.asset(
                          LocalSvgs.icBookmark,
                          height: 25,
                          width: 25,
                        ),
                ),
              ],
            ),
            kCommonSpaceV10,

            // Comments section
            if (showComment &&
                widget.post.comments != null &&
                widget.post.comments!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${S.of(mainNavKey.currentContext!)!.comments}",
                    style: getAppStyle(
                      fontSize: 16,
                      color: CommonColors.greyText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kCommonSpaceV5,
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: widget.post.comments!.length == 1
                          ? 180.0 // Height for single comment
                          : 360.0, // Height for multiple comments
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.post.comments!.length
                      //  > 2
                      //     ? 2
                      //     : widget.post.comments!.length,
                      ,
                      itemBuilder: (context, index) {
                        final comment = widget.post.comments![index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CommonColors.mGrey200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  comment.userDetail?.image != null
                                      ? ClipOval(
                                          child: Image.network(
                                            comment.userDetail!.image!,
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              LocalImages.unknownUser,
                                              height: 40,
                                              width: 40,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          LocalImages.unknownUser,
                                          height: 40,
                                          width: 40,
                                        ),
                                  kCommonSpaceH10,
                                  Text(
                                    comment.userDetail?.name ?? "",
                                    style: getAppStyle(
                                      fontSize: 16,
                                      color: CommonColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_horiz_outlined),
                                  )
                                ],
                              ),
                              kCommonSpaceV5,
                              Text(
                                comment.comment ?? "",
                                style: getAppStyle(
                                  fontSize: 16,
                                  color: CommonColors.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (comment.adminReply != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Admin Reply: ${comment.adminReply}",
                                    style: getAppStyle(
                                      fontSize: 14,
                                      color: CommonColors.textPurple,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              if (comment.commentTime != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    comment.commentTime!,
                                    style: getAppStyle(
                                      fontSize: 12,
                                      color: CommonColors.greyText,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // if (widget.post.comments!.length > 2)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 8.0),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         // widget.onComment?.call();
                  //       },
                  //       child: Text(
                  //         "View all ${widget.post.comments!.length} comments",
                  //         style: getAppStyle(
                  //           fontSize: 14,
                  //           color: CommonColors.primaryColor,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),

            // Comment input field
            if (widget.showCommentField ?? true)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: CommonColors.mWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _commentController, // Add this line
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText:
                                S.of(mainNavKey.currentContext!)!.leaveAComment,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                            suffixIcon: Container(
                              height: 30,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _commentController.text.trim().isEmpty
                                    ? CommonColors.mGrey300
                                    : CommonColors
                                        .primaryColor, // Change color based on input
                                shape: BoxShape.circle,
                              ),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_upward_outlined,
                                  color: _commentController.text.trim().isEmpty
                                      ? CommonColors.blackColor
                                      : CommonColors.mWhite,
                                ),
                                onTap: _submitComment,
                              ),
                            ),
                          ),
                          onSubmitted: (_) =>
                              _submitComment(), // Allow submission with keyboard
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

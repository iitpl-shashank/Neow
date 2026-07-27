import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
import 'package:naveli_2023/utils/common_colors.dart';

import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';
import 'forum_comments_sheet.dart';

class ForumPostWidget extends StatefulWidget {
  final ForumPost post;
  final ValueChanged<int>? onLike;
  final bool? showCommentField;

  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final Function(String, int)? onCommentSubmit;
  final bool isComments;
  final bool isFullPost;

  const ForumPostWidget({
    super.key,
    this.showCommentField = true,
    required this.post,
    this.onLike,
    this.onShare,
    this.onSave,
    this.onCommentSubmit,
    this.isComments = true,
    this.isFullPost = false,
  });

  @override
  State<ForumPostWidget> createState() => _ForumPostWidgetState();
}

class _ForumPostWidgetState extends State<ForumPostWidget> {
  late ValueNotifier<ForumPost> _postNotifier;

  @override
  void initState() {
    super.initState();
    _postNotifier = ValueNotifier<ForumPost>(widget.post);
  }

  @override
  void didUpdateWidget(covariant ForumPostWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.post != oldWidget.post) {
      _postNotifier.value = widget.post;
    }
  }

  @override
  void dispose() {
    _postNotifier.dispose();
    super.dispose();
  }

  void onTapComment() {
    _showCommentsBottomSheet();
  }

  void _showCommentsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ForumCommentsSheet(
          initialPost: widget.post,
          postNotifier: _postNotifier,
          onCommentSubmit: widget.onCommentSubmit,
        );
      },
    );
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

            // Purple Question Box / Media Image Box
            Builder(
              builder: (context) {
                final bool hasMedia = widget.post.media != null &&
                    widget.post.media!.trim().isNotEmpty;
                final ImageProvider bgImage = hasMedia
                    ? NetworkImage(widget.post.media!)
                    : AssetImage(LocalImages.postBackground) as ImageProvider;

                return Container(
                  height: 185,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CommonColors.textPurple,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: bgImage,
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
                );
              },
            ),

            if (widget.post.description != null &&
                widget.post.description!.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.post.description!,
                  maxLines: widget.isFullPost ? null : 3,
                  overflow: widget.isFullPost ? null : TextOverflow.ellipsis,
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
          ],
        ),
      ),
    );
  }
}

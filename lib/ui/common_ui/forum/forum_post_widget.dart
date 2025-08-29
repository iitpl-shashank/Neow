import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/global_variables.dart';

import '../../../generated/i18n.dart';
import '../../../utils/constant.dart';
import '../../../utils/local_images.dart';

class ForumPostWidget extends StatefulWidget {
  final int forumId;
  final String username;
  final String timeAgo;
  final String postText;
  final int likes;
  final String comment;
  final ValueChanged<int>? onLike; 
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final bool isComments;
  final int commentsCount;
  final String commentUser;

  const ForumPostWidget({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.likes,
    required this.comment,
    this.onLike,
    this.onComment,
    this.onShare,
    this.isComments = true,
    required this.commentsCount,
    required this.commentUser, 
    required this.forumId,
  });

  @override
  State<ForumPostWidget> createState() => _ForumPostWidgetState();
}

class _ForumPostWidgetState extends State<ForumPostWidget> {
  bool showComment = false;
  onTapComment() {
    setState(() {
      showComment = !showComment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                child: Image.asset(
                  height: 42,
                  width: 42,
                  LocalImages.postCardIcon,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: getAppStyle(
                        fontSize: 16,
                        color: CommonColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.timeAgo,
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

          /// Purple Question Box
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
            child: SizedBox(
              child: Center(
                child: Text(
                  widget.postText,
                  textAlign: TextAlign.center,
                  style: getAppStyle(
                      fontSize: 18,
                      color: CommonColors.mWhite,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// Bottom row: Likes, Comments, Share
          Row(
            children: [
              GestureDetector(
              onTap: () => widget.onLike?.call(widget.forumId),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.likes}",
                      style: getAppStyle(
                          fontSize: 18,
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  onTapComment();
                  widget.onComment?.call();
                },
                child: Row(
                  children: [
                    Image.asset(LocalImages.chat, height: 35, width: 35),
                    const SizedBox(width: 1),
                    Text(
                      "${widget.commentsCount}",
                      style: getAppStyle(
                          fontSize: 18,
                          color: CommonColors.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: widget.onShare,
                child:
                    Image.asset(LocalImages.shareCustom, height: 25, width: 25),
              ),
              Spacer(),
              GestureDetector(
                onTap: widget.onShare,
                child: Image.asset(LocalImages.bookmark, height: 32, width: 32),
              ),
            ],
          ),
          kCommonSpaceV10,
          if (showComment)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CommonColors.mGrey200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${S.of(mainNavKey.currentContext!)!.comments}(${widget.commentsCount})",
                          style: getAppStyle(
                              fontSize: 16,
                              color: CommonColors.greyText,
                              fontWeight: FontWeight.w500),
                        ),
                        kCommonSpaceV5,
                        Row(
                          children: [
                            Image.asset(
                              LocalImages.unknownUser,
                              height: 40,
                              width: 40,
                            ),
                            kCommonSpaceH10,
                            Text(
                              widget.commentUser,
                              style: getAppStyle(
                                  fontSize: 16,
                                  color: CommonColors.blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_outlined))
                          ],
                        ),
                        kCommonSpaceV5,
                        Text(
                          widget.comment,
                          style: getAppStyle(
                              fontSize: 16,
                              color: CommonColors.blackColor,
                              fontWeight: FontWeight.w400),
                        ),
                        kCommonSpaceV15,
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: CommonColors.mWhite,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        hintText:
                                            "${S.of(mainNavKey.currentContext!)!.leaveAComment}",
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 12),
                                        suffixIcon: Container(
                                          height: 30,
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: CommonColors.mGrey300,
                                            shape: BoxShape.circle,
                                          ),
                                          child: GestureDetector(
                                            child: const Icon(
                                                Icons.arrow_upward_outlined),
                                            onTap: () {
                                              // handle action
                                            },
                                          ),
                                        ),
                                      ),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

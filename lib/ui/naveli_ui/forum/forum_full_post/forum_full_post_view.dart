import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/common_appbar.dart';
import 'forum_full_post_view_model.dart';

class ForumFullPostView extends StatefulWidget {
  final int forumId;
  final String time;
  final String title;
  final String description;

  const ForumFullPostView(
      {super.key,
      required this.time,
      required this.title,
      required this.description,
      required this.forumId});

  @override
  State<ForumFullPostView> createState() => _ForumFullPostViewState();
}

class _ForumFullPostViewState extends State<ForumFullPostView> {
  TextEditingController commentController = TextEditingController();
  late ForumFullPostViewModel mViewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getForumsCommentApi(forumId: widget.forumId);
    });
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
          child: Column(
            children: [
              Container(
                width: kDeviceWidth / 1,
                decoration: ShapeDecoration(
                  color: CommonColors.primaryLite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage(LocalImages.img_app_logo),
                              radius: 30,
                            ),
                            kCommonSpaceH10,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Neow',
                                    style: getAppStyle(
                                      color: CommonColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    widget.time,
                                    style: getAppStyle(
                                      color: CommonColors.mGrey,
                                      fontSize: 14,
                                      height: 0.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Container(
                            //   width: 100,
                            //   height: 25,
                            //   decoration: ShapeDecoration(
                            //     color: CommonColors.primaryColor,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20),
                            //     ),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       'Follow +',
                            //       style: getAppStyle(
                            //         color: CommonColors.mWhite,
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Text(
                        widget.title,
                        style: getAppStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kCommonSpaceV5,
                      Text(
                        widget.description,
                        style: getAppStyle(
                            color: CommonColors.mGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          height: 2,
                          color: const Color(0xFF8B8B8B),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mViewModel.commentList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mViewModel.commentList[index].userDetail
                                            ?.image !=
                                        null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(mViewModel
                                                .commentList[index]
                                                .userDetail
                                                ?.image ??
                                            ''),
                                        radius: 16,
                                      )
                                    : const CircleAvatar(
                                        backgroundColor:
                                            CommonColors.mTransparent,
                                        radius: 16,
                                        child: Icon(
                                          Icons.no_accounts,
                                          color: CommonColors.mGrey,
                                          size: 32,
                                        ),
                                      ),
                                kCommonSpaceH10,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mViewModel.commentList[index].userDetail
                                                ?.name ??
                                            '--',
                                        style: getAppStyle(
                                          color: CommonColors.blackColor,
                                          fontSize: 14,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        mViewModel.commentList[index]
                                                .commentTime ??
                                            '--',
                                        style: getAppStyle(
                                          color: CommonColors.mGrey,
                                          fontSize: 12,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        mViewModel.commentList[index].comment ??
                                            '--',
                                        style: getAppStyle(
                                          color: const Color(0xFF8B8B8B),
                                          fontSize: 13,
                                          height: 1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      kCommonSpaceV5,
                                      if (mViewModel
                                              .commentList[index].adminReply !=
                                          null) ...[
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: kDeviceWidth / 2.2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "reply",
                                                  style: getAppStyle(
                                                    color:
                                                        CommonColors.blackColor,
                                                    fontSize: 14,
                                                    height: 1,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  mViewModel.commentList[index]
                                                          .adminReply ??
                                                      '--',
                                                  style: getAppStyle(
                                                    color: CommonColors.mGrey,
                                                    fontSize: 12,
                                                    height: 1,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              kCommonSpaceV20
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: CommonColors.mWhite,
          onPressed: () {
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
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          kCommonSpaceV5,
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              // height: kDeviceHeight / 6.5,
                              decoration: ShapeDecoration(
                                color: CommonColors.mWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    // color: Colors.orange,
                                    // height: kDeviceHeight / 7.8,
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
                                        forumId: widget.forumId,
                                        comment: commentController.text.trim());
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
          },
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: CommonColors.primaryColor),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: CommonColors.primaryColor,
            size: 30,
          ),
        ),
      ),
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

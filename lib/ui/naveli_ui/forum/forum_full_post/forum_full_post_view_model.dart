import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/models/forum_post_master.dart';
import 'package:naveli_2023/services/api_url.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../models/common_master.dart';
import '../../../../models/forum_comment_master.dart';
import '../../../../services/api_para.dart';
import '../../../../services/index.dart';
import '../../../../utils/common_colors.dart';
import '../../../../utils/common_utils.dart';

class ForumFullPostViewModel with ChangeNotifier {
  late BuildContext context;
  int index = 0;
  int currentPage = 0;
  final _services = Services();
  List<CommentData> commentList = [];
  ForumPost? post;

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> getForumsCommentApi({
    required int forumId,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.forum_id: forumId,
    };
    log(params.toString());
    ForumCommentMaster? master =
        await _services.api!.getForumComment(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Forum full post oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      commentList = (master.data ?? []).reversed.toList();
      // CommonUtils.showSnackBar(
      //   master.message,
      //   color: CommonColors.greenColor,
      // );
    }
    notifyListeners();
  }

  Future<void> storeForumCommentApi({
    required int forumId,
    required String comment,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.forum_id: forumId,
      ApiParams.comment: comment,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.storeForumComment(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................Forum full post oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      // Navigator.of(context).pop();
      getForumsCommentApi(forumId: forumId);
      CommonUtils.showSnackBar(
        master.message,
        color: CommonColors.greenColor,
      );

      // Fetch only the updated post to copy its data locally
      final updatedPostModel =
          await _services.api!.getForumAllPost(params: {"id": forumId});
      if (updatedPostModel != null &&
          updatedPostModel.success == true &&
          updatedPostModel.data != null &&
          updatedPostModel.data!.isNotEmpty) {
        post?.copyFrom(updatedPostModel.data!.first);
      } else {
        // Fallback local update if API fails
        if (post != null) {
          post!.commentCount = (post!.commentCount ?? 0) + 1;
        }
      }
    }
    notifyListeners();
  }

  Future<void> forumPostLikeDislike({
    required int forumId,
    required int isLike,
  }) async {
    try {
      CommonUtils.showProgressDialog();

      final params = <String, dynamic>{
        ApiParams.forumId: forumId,
        ApiParams.isLike: isLike,
      };

      final resp = await _services.api!.forumPostLikeDislike(params: params);

      if (resp.success == true) {
        if (post != null) {
          post!.liked = isLike == 1;
          post!.totalLike = (post!.totalLike ?? 0) + (isLike == 1 ? 1 : -1);
        }
      } else {
        CommonUtils.showSnackBar(
          resp.message ?? "Failed",
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      log("Exception in forumPostLikeDislike: $e");
      CommonUtils.oopsMSG();
    } finally {
      CommonUtils.hideProgressDialog();
      notifyListeners();
    }
  }

  Future<void> forumPostSaveUnsave({
    required int forumId,
    required int isSaved,
  }) async {
    try {
      CommonUtils.showProgressDialog();

      final params = <String, dynamic>{
        ApiParams.forumId: forumId,
        ApiParams.is_saved: isSaved,
      };

      final resp = await _services.api!.forumPostSaveUnsave(params: params);

      if (resp.success == true) {
        if (post != null) {
          post!.saved = isSaved == 1 ? "yes" : "no";
        }
        CommonUtils.showSnackBar(
          isSaved == 1
              ? S.of(context)!.postSavedSuccessfully
              : S.of(context)!.postRemoved,
          color: CommonColors.greenColor,
        );
      } else {
        CommonUtils.showSnackBar(
          resp.message ?? S.of(context)!.somethingWentWrong,
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      log("Exception in forumPostSaveUnsave: $e");
      CommonUtils.oopsMSG();
    } finally {
      CommonUtils.hideProgressDialog();
      notifyListeners();
    }
  }

  Future<void> forumPostComment({
    required String comment,
    required int forumId,
  }) async {
    if (comment.trim().isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.commentEmpty,
        color: CommonColors.mRed,
      );
      return;
    }

    try {
      CommonUtils.showProgressDialog();

      final params = <String, dynamic>{
        ApiParams.forumId: forumId,
        ApiParams.comment: comment.trim(),
      };

      final CommonMaster resp =
          await _services.api!.forumPostComment(params: params);

      if (resp.success == true) {
        CommonUtils.showSnackBar(
          S.of(context)!.commentAddedSuccess,
          color: CommonColors.greenColor,
        );

        // await getForumPostApi(showLoader: false);
      } else {
        CommonUtils.showSnackBar(
          S.of(context)!.somethingWentWrong,
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      log("Exception in forumPostComment: $e");
      CommonUtils.oopsMSG();
    } finally {
      CommonUtils.hideProgressDialog();
    }
  }

  // void _updatePost(int forumId, Function(ForumPost post) update) {
  //   final index = forumPostList.indexWhere((post) => post.id == forumId);
  //   if (index != -1) {
  //     update(forumPostList[index]);
  //     notifyListeners();
  //   }
  // }

  void sharePost({
    required int postId,
    required int index,
  }) {
    try {
      String endpoint = ApiUrl.GET_FORUM_POST;
      String url = endpoint +
          "?id=${postId.toString()}&index=${index.toString()}&page=${currentPage.toString()}";

      log('Share URL: $url');

      Share.share(url);
    } catch (e) {
      debugPrint('Error creating share URL: $e');
    }
  }
}

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/models/common_master.dart';
import '../../../database/app_preferences.dart';
import '../../../models/forum_post_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class ForumViewModel with ChangeNotifier {
  bool _hasShownWelcomeDialog = false;
  bool get hasShownWelcomeDialog => _hasShownWelcomeDialog;

  late BuildContext context;
  final _services = Services();
  List<ForumPost> forumPostList = [];
  bool isLoading = false;
  bool _isRefreshing = false;

  void attachedContext(BuildContext context) {
    this.context = context;
  }

  void setWelcomeDialogShown() {
    _hasShownWelcomeDialog = true;
    notifyListeners();
  }

  Future<void> getForumPostApi({bool showLoader = true}) async {
    if (_isRefreshing) return; // Prevent multiple simultaneous calls
    _isRefreshing = true;

    try {
      if (showLoader) {
        isLoading = true;
        notifyListeners();
        CommonUtils.showProgressDialog();
      }

      final params = <String, dynamic>{
        ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
      };

      final response = await _services.api!.getForumAllPost(params: params);

      if (response == null) {
        CommonUtils.oopsMSG();
        return;
      }

      if (response.success == true) {
        forumPostList = response.data ?? [];
      } else {
        CommonUtils.showSnackBar(
          response.message ?? "--",
          color: CommonColors.mRed,
        );
      }
    } catch (e, s) {
      log("Exception in getForumPostApi: $e\n$s");
      CommonUtils.oopsMSG();
    } finally {
      _isRefreshing = false;
      isLoading = false;
      if (showLoader) CommonUtils.hideProgressDialog();
      notifyListeners();
    }
  }

  Future<void> forumPostLikeDislike({
    required int forumId,
    required int isLike,
  }) async {
    try {
      CommonUtils.showProgressDialog();

      // Optimistic update
      _updatePost(forumId, (post) {
        post.liked = isLike == 1;
        post.totalLike = (post.totalLike ?? 0) + (isLike == 1 ? 1 : -1);
      });

      final params = <String, dynamic>{
        ApiParams.forumId: forumId,
        ApiParams.isLike: isLike,
      };

      final resp = await _services.api!.forumPostLikeDislike(params: params);

      if (resp.success == true) {
        // CommonUtils.showSnackBar(
        //   resp.message ?? S.of(context)!.savedSuccess,
        //   color: CommonColors.greenColor,
        // );
        await getForumPostApi(showLoader: false);
      } else {
        _updatePost(forumId, (post) {
          post.liked = isLike != 1;
          post.totalLike = (post.totalLike ?? 0) - (isLike == 1 ? 1 : -1);
        });

        // CommonUtils.showSnackBar(
        //   resp.message ?? "Failed",
        //   color: CommonColors.mRed,
        // );
      }
    } catch (e) {
      log("Exception in forumPostLikeDislike: $e");
      CommonUtils.oopsMSG();
    } finally {
      CommonUtils.hideProgressDialog();
    }
  }

  Future<void> forumPostSaveUnsave({
    required int forumId,
    required int isSaved,
  }) async {
    try {
      CommonUtils.showProgressDialog();

      // Optimistic update
      _updatePost(forumId, (post) {
        post.saved = isSaved == 1 ? "yes" : "no";
      });

      final params = <String, dynamic>{
        ApiParams.forumId: forumId,
        ApiParams.is_saved: isSaved,
      };

      final resp = await _services.api!.forumPostSaveUnsave(params: params);

      if (resp.success == true) {
         CommonUtils.showSnackBar(
          isSaved == 1 ? S.of(context)!.postSavedSuccessfully : S.of(context)!.postRemoved,
          color: CommonColors.mRed,
        );
        await getForumPostApi(showLoader: false);
      } else {
      
        _updatePost(forumId, (post) {
          post.saved = isSaved == 0 ? "yes" : "no";
        });
        // CommonUtils.showSnackBar(
        // S.of(context)!.somethingWentWrong,
        //   color: CommonColors.mRed,
        // );
      
      }
    } catch (e) {
      log("Exception in forumPostSaveUnsave: $e");
      CommonUtils.oopsMSG();
    } finally {
      CommonUtils.hideProgressDialog();
    }
  }

  Future<void> forumPostComment({
    required String comment,
    required int forumId,
  }) async {
    if (comment.trim().isEmpty) {
      CommonUtils.showSnackBar(
        "Please enter a comment",
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
          resp.message ?? "Comment added successfully",
          color: CommonColors.greenColor,
        );
        // Refresh without showing loader
        await getForumPostApi(showLoader: false);
      } else {
        CommonUtils.showSnackBar(
          resp.message ?? "Failed to add comment",
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

  void _updatePost(int forumId, Function(ForumPost post) update) {
    final index = forumPostList.indexWhere((post) => post.id == forumId);
    if (index != -1) {
      update(forumPostList[index]);
      notifyListeners();
    }
  }
}

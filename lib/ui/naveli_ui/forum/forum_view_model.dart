import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:naveli_2023/generated/i18n.dart';
import 'package:naveli_2023/models/common_master.dart';
import 'package:naveli_2023/services/api_url.dart';
import 'package:share_plus/share_plus.dart';
import '../../../database/app_preferences.dart';
import '../../../models/forum_post_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class ForumViewModel with ChangeNotifier {
  final String baseUrl = ApiUrl.BASE_URL;
  bool _hasShownWelcomeDialog = false;
  bool get hasShownWelcomeDialog => _hasShownWelcomeDialog;
  int _currentPage = 1;
  int? _perPage;
  late BuildContext context;
  final _services = Services();
  List<ForumPost> forumPostList = [];
  bool isLoading = false;
  bool _isRefreshing = false;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;
  int get perPage => _perPage ?? 5;
  bool hasShownEndMessage = false;

  void _resetEndMessage() {
    hasShownEndMessage = false;
  }

  void attachedContext(BuildContext context) {
    this.context = context;
  }

  void setWelcomeDialogShown() {
    _hasShownWelcomeDialog = true;
    notifyListeners();
  }

  Future<void> getForumPostApi({
    bool showLoader = true,
    bool loadMore = false,
  }) async {
    if (_isRefreshing || (_isLoadingMore && loadMore)) return;

    if (loadMore) {
      _isLoadingMore = true;
    } else {
      _isRefreshing = true;
      _currentPage = 1;
      forumPostList.clear();
      _resetEndMessage();
    }
    notifyListeners();
    try {
      if (showLoader && !loadMore) {
        isLoading = true;
        notifyListeners();
        CommonUtils.showProgressDialog();
      }

      final params = <String, dynamic>{
        ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
        ApiParams.page: _currentPage,
      };

      final response = await _services.api!.getForumAllPost(params: params);

      if (response == null) {
        CommonUtils.oopsMSG();
        return;
      }

      if (response.success == true) {
        final newPosts = response.data ?? [];
        if (response.pagination != null) {
          _perPage = response.pagination?.perPage;
          _hasMoreData = response.pagination?.nextPageUrl != null;
          _currentPage = response.pagination?.currentPage ?? _currentPage;
        } else {
          _hasMoreData = newPosts.length >= (perPage);
        }

        if (loadMore) {
          forumPostList.addAll(newPosts);
        } else {
          forumPostList = newPosts;
        }

        // // Check if we have more data to load
        // _hasMoreData = newPosts.length >= _perPage;
        if (_hasMoreData) {
          _currentPage++;
        }
      }
    } catch (e, s) {
      log("Exception in getForumPostApi: $e\n$s");
      CommonUtils.oopsMSG();
    } finally {
      _isRefreshing = false;
      _isLoadingMore = false;
      isLoading = false;
      if (showLoader && !loadMore) CommonUtils.hideProgressDialog();
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
          isSaved == 1
              ? S.of(context)!.postSavedSuccessfully
              : S.of(context)!.postRemoved,
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
   
        // Fetch only the updated post to copy its data locally
        final updatedPostModel =
            await _services.api!.getForumAllPost(params: {"id": forumId});
        if (updatedPostModel != null &&
            updatedPostModel.success == true &&
            updatedPostModel.data != null &&
            updatedPostModel.data!.isNotEmpty) {
          _updatePost(forumId, (post) {
            post.copyFrom(updatedPostModel.data!.first);
          });
        } else {
          // Fallback local update if API fails
          _updatePost(forumId, (post) {
            post.commentCount = (post.commentCount ?? 0) + 1;
          });
        }
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

  void _updatePost(int forumId, Function(ForumPost post) update) {
    final index = forumPostList.indexWhere((post) => post.id == forumId);
    if (index != -1) {
      update(forumPostList[index]);
      notifyListeners();
    }
  }

  void sharePost({
    required int postId,
    required int index,
  }) {
    try {
      String endpoint = ApiUrl.GET_FORUM_POST;
      String url = endpoint +
          "?id=${postId.toString()}&index=${index.toString()}&page=${_currentPage.toString()}";

      log('Share URL: $url');

      Share.share(url);
    } catch (e) {
      debugPrint('Error creating share URL: $e');
    }
  }
}

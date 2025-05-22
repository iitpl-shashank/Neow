import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naveli_2023/models/healthmix_latest_posts.dart';
import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/common_master.dart';
import '../../../models/health_mix_liked_post_master.dart';
import '../../../models/health_mix_posts_master.dart';
import '../../../services/api_para.dart';
import '../../../services/index.dart';
import '../../../utils/common_colors.dart';
import '../../../utils/common_utils.dart';

class HealthMixViewModel with ChangeNotifier {
  late BuildContext context;
  final _services = Services();
  List<HealthMixPosts> healthPostsList = [];
  List<HealthMixPost> healthLatestPostsList = [];
  List<bool> isLikedList = [];

  void attachedContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Future<void> saveHealthMixPost({
    required int healthMixId,
    required int isSaved,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.health_mix_id: healthMixId,
      ApiParams.is_saved: isSaved,
    };
    log("saveHealthMixPost params: $params");
    try {
      final result = await _services.api!.saveHealthMixPost(params: params);
      CommonUtils.hideProgressDialog();
      if (result.success == true) {
        CommonUtils.showSnackBar(
          S.of(context)!.savedSuccess,
          color: CommonColors.greenColor,
        );
      } else {
        CommonUtils.showSnackBar(
          S.of(context)!.savedFailed,
          color: CommonColors.mRed,
        );
      }
    } catch (e) {
      CommonUtils.hideProgressDialog();
      CommonUtils.showSnackBar(
        S.of(context)!.somethingWentWrong,
        color: CommonColors.mRed,
      );
      log("Exception in saveHealthMixPost: $e");
    }
    notifyListeners();
  }

  Future<void> getLikedPostApi() async {
    CommonUtils.showProgressDialog();
    LikedPostMaster? master = await _services.api!.getLikedHealthPost();

    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
      CommonUtils.hideProgressDialog();
    } else if (master.success == true) {
      final likedPosts = master.data ?? [];
      isLikedList.clear();
      for (var post in healthPostsList) {
        isLikedList.add(likedPosts.any((likedPost) =>
            likedPost.healthMixId == post.id && likedPost.isLike == 1));
      }
      print(".................$isLikedList");
      CommonUtils.hideProgressDialog();
    }
    notifyListeners();
  }

  Future<void> likeHealthMixPostApi({
    required int? healthMixId,
    required int? isLike,
  }) async {
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.health_mix_id: healthMixId,
      ApiParams.is_like: isLike,
    };
    log(params.toString());
    CommonMaster? master =
        await _services.api!.likeHealthMixPost(params: params);
    CommonUtils.hideProgressDialog();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {}
    notifyListeners();
  }

  Future<void> getHealthMixPostsApi({
    required int titleId,
    required String type,
  }) async {
    debugPrint("");
    CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.title_id: titleId,
      "type": type,
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    debugPrint("params: $params");
    HealthMixPostMaster? master =
        await _services.api!.getHealthMixPosts(params: params);
    CommonUtils.hideProgressDialog();
    notifyListeners();
    if (master == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix oops.............................");
    } else if (master.success == false) {
      CommonUtils.showSnackBar(
        master.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (master.success == true) {
      healthPostsList = master.data?.healthMixPosts ?? [];

      await getLikedPostApi();
    }
    CommonUtils.hideProgressDialog();
    notifyListeners();
  }

  Future<void> getHealthMixLatestPosts() async {
    debugPrint("UNDER GET HEALTH MIX LATES POSTS");
    // CommonUtils.showProgressDialog();
    Map<String, dynamic> params = <String, dynamic>{
      ApiParams.language_code: AppPreferences.instance.getLanguageCode(),
    };
    debugPrint("params: $params");
    HealthMixLatestPost? posts =
        await _services.api!.getHealthMixLatestPostList(params: params);
    // CommonUtils.hideProgressDialog();
    notifyListeners();

    if (posts == null) {
      CommonUtils.oopsMSG();
      print(
          "................................health mix latest oops.............................");
    } else if (posts.success == false) {
      CommonUtils.showSnackBar(
        posts.message ?? "--",
        color: CommonColors.mRed,
      );
    } else if (posts.success == true) {
      healthLatestPostsList = posts.data?.healthMixPosts ?? [];
      debugPrint("healthLatestPostsList: ${healthLatestPostsList}");
      healthLatestPostsList.forEach((post) {
        debugPrint('Post: $post');
      });
    }
    // CommonUtils.hideProgressDialog();
    notifyListeners();
  }

  bool _isFullScreen = false;

  bool get isFullScreen => _isFullScreen;

  void setFullScreen(bool value) {
    _isFullScreen = value;
    notifyListeners();
  }
}
